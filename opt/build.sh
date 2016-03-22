FILE=$($(npm bin)/webpack -p --target=node index.js out.js)
FILE=$(cat out.js | sed -e 's/[]\/$*.^|[]/\\&/g' -e 's/\&/\\\&/g' -e 's/"/\\\\"/g' -e 's/|/\|/g' -e 's/(/\(/g' -e 's/)/\)/g')
gsed -i "s|^ENV FILE .*$|ENV FILE \"$FILE\"|" Dockerfile
rm out.js
