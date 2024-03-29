#! /bin/sh -l

echo "Hello $1"
time=$(date)
echo "::set-output name=time::$time"

set -eu

grepExit () {
	# Grep Returns 1 if pattern not found, > 1 is an error
	if [ $1 -eq 1 ]; then
		printf "\033[0;32mNo merge conflicts found.\033[0m\n"
		exit 0;
	fi
	printf "\033[1;31mGrep Error.\033[0m\n"
	exit 1;
}

EXCLUDE=(${INPUT_EXCLUDES/,/ })
EXCLUDE_DIR=(${INPUT_EXCLUDE_DIR/,/ })

CONFLICTS="$(grep -lr -R --exclude-dir=.git "${EXCLUDE_DIR[@]/#/--exclude-dir=}" "${EXCLUDE[@]/#/--exclude=}" -E -- '^<<<<<<<|^>>>>>>>' .)" || grepExit $?

printf "\033[1;31mFound merge conflicts.\033[0m\n"
for file in "$CONFLICTS"
do
	echo "::error file="$file"::Merge conflict found in $file"
done

exit 1;
