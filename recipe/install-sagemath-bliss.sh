#!/bin/bash
set -x

source $RECIPE_DIR/build-env.sh

# Install into the PREFIX.
# --no-deps and --no-build-isolation lets us completely ignore dependencies and
# build dependencies (which otherwise want things such as sage-setup and
# sage-conf which we do not want or need.)
"$PYTHON" -m pip install --no-deps --no-build-isolation pkgs/sagemath-bliss -vv
