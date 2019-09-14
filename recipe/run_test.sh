git clone https://github.com/sagemath/sage.git sagemath
cd sagemath
git checkout ${PKG_VERSION}
ln -s $PREFIX local

export SAGE_LOCAL=$PWD/local
export SAGE_ROOT=$PWD
export CFLAGS="$CFLAGS -I/usr/include"
export CXXFLAGS="$CXXFLAGS -I/usr/include"
export CPPFLAGS="$CPPFLAGS -I/usr/include"
ls $SAGE_ROOT
ls $SAGE_LOCAL
rm "$SAGE_LOCAL/lib/sage-current-location.txt"

(sage -tp --initial --all --optional=memlimit,sage | tee doctest.txt) || true

cat doctest.txt | grep '^sage -t ' | grep '#' > doctest.summary.txt || true
echo `cat doctest.summary.txt | awk '{ print $5 }' | sort | grep -E '[0-9]+' | paste -sd+ | bc` failing individual doctests
cat doctest.summary.txt | awk '{ print $5 }' | sort | grep -vE '[0-9]+' | sort | uniq -c || true

