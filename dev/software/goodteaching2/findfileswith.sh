#!/bin/bash
for i in $@
do
	echo -e "\n--[files containing '$i']--"
	grep -ic "$i" `find . -name "*.php" -print` | grep -v ":0$"
	echo -e "--[end '$i']--\n"
done
