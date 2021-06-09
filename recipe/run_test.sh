set -x

git clone https://github.com/sagemath/sage.git -b ${PKG_VERSION} --depth 1 sagemath
cd sagemath

# Apply patches from sagelib-feedstock
git clone https://github.com/conda-forge/sagelib-feedstock.git
pushd sagelib-feedstock
  git reset --hard 4c236cdf6b42b1ab1100e03d98f71cfbd71861f1
popd
for p in `grep -v '#' sagelib-feedstock/recipe/patches/series`;do
    patch -p1 < ./sagelib-feedstock/recipe/patches/"$p"
done

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
