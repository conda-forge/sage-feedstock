set -x

git clone https://github.com/sagemath/sage.git -b ${PKG_VERSION} --depth 1 sagemath
cd sagemath
ln -s $PREFIX local

export SAGE_LOCAL=$PWD/local
export SAGE_ROOT=$PWD
ls $SAGE_ROOT
ls $SAGE_LOCAL
echo $SAGE_ROOT > "$SAGE_LOCAL/lib/sage-current-location.txt"
sed -i.bak "s@SAGE_ROOT=\"$PREFIX\"@SAGE_ROOT=\"$SAGE_ROOT\"@g" $PREFIX/bin/sage-env-config

export SAGE_NUM_THREADS_PARALLEL=$CPU_COUNT
export SAGE_NUM_THREADS=$CPU_COUNT

set +e
sage -tp --initial --all --optional=memlimit,sage | tee doctest.txt

cat doctest.txt | grep '^sage -t ' | grep '#' > doctest.summary.txt
echo `cat doctest.summary.txt | awk '{ print $6 }' | sort | grep -E '[0-9]+' | paste -sd+ | bc` failing individual doctests
cat doctest.summary.txt | awk '{ print $6 }' | sort | grep -vE '[0-9]+' | sort | uniq -c

set -e
