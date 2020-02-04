#!/bin/bash

set -ev  # Fail on first non-zero return value.

###############################################################################
# Explicit file paths, explicit output.
###############################################################################

nbconcat \
	tests/fixtures/1_Intro.ipynb \
	tests/fixtures/2_Middle.ipynb \
	tests/fixtures/3_Conclusion.ipynb \
	-o cli_test.ipynb

cmp cli_test.ipynb tests/fixtures/_gold.ipynb

rm cli_test.ipynb

###############################################################################
# Explicit file paths, stdout.
###############################################################################

nbconcat \
	tests/fixtures/1_Intro.ipynb \
	tests/fixtures/2_Middle.ipynb \
	tests/fixtures/3_Conclusion.ipynb \
	> cli_test.ipynb

cmp cli_test.ipynb tests/fixtures/_gold.ipynb

rm cli_test.ipynb


###############################################################################
# Recursive with a regexp, to stdout.
###############################################################################

nbconcat \
	--recursive -i \
	-p "(1_Intro|2_Middle|3_Conclusion)\.ipynb" \
	> cli_test.ipynb

cmp cli_test.ipynb tests/fixtures/_gold.ipynb

###############################################################################
# Recursive with a regexp, explicit output.
###############################################################################

nbconcat \
	--recursive -i \
	-p "(1_Intro|2_Middle|3_Conclusion)\.ipynb" \
	-o cli_test.ipynb

cmp cli_test.ipynb tests/fixtures/_gold.ipynb

rm cli_test.ipynb

###############################################################################
# Recursive with a regexp and explict input, explicit output.
###############################################################################

nbconcat \
	--recursive -i \
	-p "(2_Middle|3_Conclusion)\.ipynb" \
	-o cli_test.ipynb \
	tests/fixtures/1_Intro.ipynb

cmp cli_test.ipynb tests/fixtures/_gold.ipynb

rm cli_test.ipynb

###############################################################################
# When called without any arguments, nbconcat should emit a usage message.
###############################################################################

(! nbconcat ) | grep -q usage

