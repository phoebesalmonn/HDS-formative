#!/bin/bash
#chmod +x 1-datachecks.sh

cd ~/formative

## SECTION 3 - DATA CHECKS

DATADIR="/home/om25003/formative/data"

## body measures file

        # the number of lines in the file
        wc -l ${DATADIR}/original/BMX_D.csv

        # find the number of fields at the top of the file

        echo -e "\n\nNumber of fields on first 10 lines:"
        awk -F, '{print NF}' ${DATADIR}/original/BMX_D.csv | head

        # check the same number of fields all the way down the file

        echo -e "\n\nPrint any lines that do not have 28 fields:"
        awk -F, '{print NF}' ${DATADIR}/original/BMX_D.csv | grep -v 28

        echo -e "\n\n"


## accel files

        # number of accelerometer files
        numFiles=`ls ${DATADIR}/original/accel | wc -l`
        echo "Number of accelerometer files: $numFiles" 

        # pick one example and check the top

        # list some files
        echo "Some file names:"
        ls ${DATADIR}/original/accel | head

        # look at the top of an example file
        echo "Top of example file:"
        head ${DATADIR}/original/accel/accel-31128.txt

        # print top of example accel file
        echo "Number of fields for top of example file:"
        awk -F'\t' '{print NF}' ${DATADIR}/original/accel/accel-31128.txt | head


        #### check that all lines in all the accel files (except first) have 8 columns

        # check that all lines have 8 columns
        echo "Number of columns found in the accelerometer files, different from 8:"
        cat ${DATADIR}/original/accel/accel-*.txt | grep -v '<' | awk -F'\t' '{print NF}' | grep -v 8 | sort -u

        # print all lines that don't have 8 columns
        echo "Lines that don't have 8 columns:"
        cat ${DATADIR}/original/accel/accel-*.txt | grep -v '<' | awk -F'\t' '(NF!=8){print $0}' | sort -u

        # see which files the NA lines exist in
        echo "Files containing NA lines:"
        grep -vH '<' ${DATADIR}/original/accel/accel-*.txt | grep "NA\tNA\tNA" | sort -u




