#!/bin/bash
set -x

source $RECIPE_DIR/build-env.sh

# Install into the PREFIX.
# --no-deps and --no-build-isolation lets us completely ignore dependencies and
# build dependencies (which otherwise would create an isolated build env instead
# of using the conda-forge toolchain and dependencies from the recipe.)
# The -Csetup-args makes sure that MESON_ARGS are passed on to the internal
# meson (in particular the cross-compilation setup that is encoded there.)
"$PYTHON" -m pip install --no-deps --no-build-isolation . -v --config-settings=setup-args=--wrap-mode=nofallback --config-settings=setup-args=--default-library=shared -Csetup-args=${MESON_ARGS// / -Csetup-args=}

# Replace symlinks that point outside the prefix with files.
rm $PREFIX/share/jupyter/kernels/sagemath/logo.svg
cp pkgs/sagemath-repl/sage/ext_data/notebook-ipython/logo.svg $PREFIX/share/jupyter/kernels/sagemath/

rm $PREFIX/share/jupyter/kernels/sagemath/logo-64x64.png
cp pkgs/sagemath-repl/sage/ext_data/notebook-ipython/logo-64x64.png $PREFIX/share/jupyter/kernels/sagemath/
