set -e
mv golang.mk golang-old.mk
sed -e 's_@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/golang.mk -O_@cp ../dev-handbook/make/golang.mk_' golang-old.mk > golang.mk
make golang-update-makefile

cp golang.mk golang-after-update

mv golang.mk golang-old.mk
sed -e 's_@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/golang-v1.mk -O_@cp ../dev-handbook/make/golang-v1.mk_' golang-old.mk > golang.mk

make golang-major-update-makefile
##
