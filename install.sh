#!/bin/bash

current_dir=$(pwd)
source_dir="${current_dir}/src"
output_dir="${current_dir}/build"
opt=$1
commandsArr='{
	"<--help> OR <-h>": "Get all commands and a short description",
	"<--build> OR <-b>": "Build On local default system (Linux x64)",
	"<--clean> OR <-c>": "Remove build files"
}'

help () {
	echo $commandsArr | jq;
	exit 0
}
build() {
	echo start building...
	cmake -S $current_dir -B $output_dir &&
	make -C $output_dir &&
	mkdir "${current_dir}/bin" 1>/dev/null 2>/dev/null & wait $!
	mv "${output_dir}/SMW" "${current_dir}/bin"
	echo building done
	exit 0
}
clean() {
	rm -rf "${output_dir}/* ${current_dir}/bin" &&
	echo Cleaning Done
}

if [ $# -lt 1 ]; then
	echo  "install <command> \ninstall -h to get the list of commands";
	exit 1
fi

case $opt in
	-h | --help)
		help
		;;
	-b | --build)
		build
		;;
	-c | --clean)
		clean
		;;
	*)
		echo "no"
		;;
esac
