#!/bin/bash

# Gather latest version of telegram
version=$(curl -XGET --head https://telegram.org/dl/desktop/linux |grep Location |cut -d '/' -f 5 |cut -d '.' -f 2-4)
sed -i 's/\(Telegram Version \)[0-9]*\.[0-9]*\.[0-9]*$/\1'"${version}"'/' Dockerfile
sed -i 's/\(tsetup.\).*\(.tar.xz -O\)/\1'"${version}"'\2/' Dockerfile
git commit -am "Telegram version ${version}" -S
git tag -am "Telegram version ${version}" "${version}"
git push --follow-tags
docker build -t "lemmy04/docker-telegram/telegram:${version}" .
docker push lemmy04/docker-telegram:${version}
