FILE=$($(npm bin)/webpack -p --target=node index.js out.js)
FILE=$(cat out.js | sed -e 's/[]\/$*.^|[]/\\&/g' -e 's/\&/\\\&/g' -e 's/"/\\\\"/g' -e 's/|/\|/g' -e 's/(/\(/g' -e 's/)/\)/g')

# use choose source based upon x86 v ARM architecture of docker host
#echo "FROM nodesource/jessie:4.4" > Dockerfile
echo "FROM hypriot/rpi-node:4.4" > Dockerfile

echo "ENV FILE \"$FILE\"" >> Dockerfile
echo "EXPOSE 3488" >> Dockerfile
echo "CMD echo \$FILE > index.js && npm i wol && node index.js" >> Dockerfile

# remove extraneous character escapes
sed -i "s|^ENV FILE .*$|ENV FILE \"$FILE\"|" Dockerfile

rm out.js
