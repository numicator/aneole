####################################################################################################
# Part of 'anole' pipeline                                                                         #
# This script check fastqc reports (the summary files) for any failed tests                        #
# Usage: bash checkFastqc.sh <directory with the fastqc reports>                                   #
#                                                                                                  #
# Author: Marcin Adamski marcin.adamski@anu.edu.au                                                 #
####################################################################################################

for f in $1/*.txt #iterate through all .txt files in directory specified by parameter $1
do
  PROBLEM=`grep "FAIL" $f`
  #echo "$PROBLEM"
  if [ "$PROBLEM" ]
  then
    echo "file $f has PROBLEMS!"
  else
    echo "file $f checked OK"
  fi
done
