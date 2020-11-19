$!/usr/bin/env sh
set -e
npm rnu bild
cd dist
git init
git add -A 
git commit -m 'deploy'
git push -f git@github.com:<LeoDiKadyrov>/<Vuelidate-ClientForm>.git master:gh-pages
cd -