git clone https://github.com/sagemath/sage.git sagemath
cd sagemath
git checkout ${PKG_VERSION}
ln -s $PREFIX local

export SAGE_LOCAL=$PREFIX/local
export SAGE_ROOT=$PREFIX
ls $SAGE_ROOT
ls $SAGE_LOCAL
rm "$SAGE_LOCAL/lib/sage-current-location.txt"

(sage -tp --initial --all --optional=memlimit,sage | tee doctest.txt) || true

conda list '^sagelib$'
conda list '^sage$'
cat doctest.txt | grep '^sage -t ' | grep '#' > doctest.summary.txt || true
echo `cat doctest.summary.txt | awk '{ print $5 }' | sort | grep -E '[0-9]+' | paste -sd+ | bc` failing individual doctests
cat doctest.summary.txt | awk '{ print $5 }' | sort | grep -vE '[0-9]+' | sort | uniq -c || true

