cd ${WORKSPACE}

if [ ! -d hudson ]; then
  git clone git://github.com/CModEx/hudson.git
fi

cd hudson
## Get rid of possible local changes
git reset --hard
git pull -s resolve

if ! [ -z "${HUDSON_BRANCH}" ]; then
  git checkout "${HUDSON_BRANCH}"
else
  git checkout cm-11.0
fi

git pull

exec ./build.sh
