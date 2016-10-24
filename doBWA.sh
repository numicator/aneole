####################################################################################################
# Part of 'anole' pipeline                                                                         #
# This script maps short reads in fastq files on the reference                                     #
# Usage: bash doBWA.sh <population.tab                                                             #
#                                                                                                  #
# Author: Marcin Adamski marcin.adamski@anu.edu.au                                                 #
####################################################################################################

REF="anole_ref.fa"    #the reference sequence for the alignments
DIR_FASTQ="fastq"     #directory with the fastq files
DIR_ALN="alignment"   #directory to put the alignments

while read population libs #read a line from standard input and assign the first field to variable 'population' and other fields to variable 'libs'
do
  echo "BWA on population $population"
  for lib in $libs #iterate through all fileds in variable 'libs', each time assign the current field to variable 'lib'
  do
    echo "  library $lib"
    ./bwa mem ${REF} ${DIR_FASTQ}/${lib}_R1.fastq ${DIR_FASTQ}/${lib}_R2.fastq >${DIR_ALN}/${lib}.sam #run BWA MEM aligner on given reference and pair of fastq files
    ./bwa mem ${REF} ${DIR_FASTQ}/${lib}_R1.fastq ${DIR_FASTQ}/${lib}_R2.fastq | ./samtools view -S -u - | ./samtools sort - ${DIR_ALN}/${lib} #run a pipe to get sorted .bam files
  done
done
