#!/bin/bash
#chmod +x 2-datafix.sh

## SECTION 4 - FIXING THE DATA

DATADIR='/home/om25003/formative/data'

##
## Removing the first line of each file with format <ACTIGRAPH ID=PARTICIPANT_ID>
## and extracting accel IDs

nano ${DATADIR}/derived/accel_filenames.txt
cd ${DATADIR}/original/accel

for file in ./accel-*; do     # cycle accel files

    if [ -f "$file" ]; then     # if the thing is a file (not a directory)

        #echo ${file}

        # copy original files over to derived
        cp ${file} ../../derived/accel

        # remove first row (so that it is now a header)
        tail -n+2 ${file} > ${DATADIR}/derived/accel/${file}
        
        # extract file names into their own .txt
        echo "${file}" >> ${DATADIR}/derived/accel_filenames.txt     # >> appends the .txt file (on a new line each time)

    fi 
done
# ALTERNATIVE METHOD (FROM SOLUTIONS):

    # remove first line in all accel files (with <.*> format)
    #echo -e "\n\nREMOVING FIRST LINE OF FORM  <ACTIGRAPH ID=PARTICIPANT_ID>\n"
    #mkdir ${DATADIR}/derived/accel
    #cp ${DATADIR}/original/accel/accel*.txt ${DATADIR}/derived/accel
    #sed -i '1d' ${DATADIR}/derived/accel/accel*.txt

# extract the first row of each new accel .txt file. -q suppresses file name output
head -n1 -q ${DATADIR}/derived/accel/*.txt > ${DATADIR}/derived/accel_headers.txt 
uniq -c ${DATADIR}/derived/accel_headers.txt
# looks like all files have the same header wooo

# line count of each file (don't know if this is necessary tbh)
#wc -l ${DATADIR}/derived/accel/*.txt | awk '{print $1}' | uniq  # looks like most files have 10081 lines
#wc -l ${DATADIR}/derived/accel/*.txt | grep -v 10081            # extract the filenames that don't 


## Remove all the lines with 3 columns with NA values

        echo -e "\n\nRemoving lines with NA\tNA\tNA\n"

        # remove those lines
        sed -i '/NA\tNA\tNA/d' ${DATADIR}/derived/accel/accel-*.txt

        # check the files to make sure the lines have been removed correctly - rerun same command as above to find lines that don't have 8 columns
        echo "Any lines still not with 8 columns are listed here:"
        awk -F'\t' '(NF!=8){print $0}' ${DATADIR}/derived/accel/accel-*.txt | sort -u