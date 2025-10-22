#!/bin/bash
#chmod +x 3-datagenerate.sh

DATADIR='/home/om25003/formative/data'

## SECTION 5 - GENERATING A SAMPLE FILE

# extract accel ID numbers - using accel_filenames.txt - generated earlier
grep -o '[0-9]\+' ${DATADIR}/derived/accel_filenames.txt > ${DATADIR}/derived/accel_IDs.txt   # -o only returns the text that matches, '[0-9]\+' matches 1+ numbers
# file for BMX IDs:
cut -d, -f2 ${DATADIR}/original/BMX_D.csv > ${DATADIR}/derived/BMX_IDs.txt

BMX_IDs=`tail -n+2 ${DATADIR}/original/BMX_D.csv| cut -d, -f2`    # remove the first row | take the second column
accel_IDs=`grep -o '[0-9]\+' ${DATADIR}/derived/accel_filenames.txt`

nano ${DATADIR}/derived/datamatch.txt 
for ID in $BMX_IDs; do     # cycle BMX data IDs

    if grep -q ${ID} ${DATADIR}/derived/accel_filenames.txt; then  # if the BMX ID is found in the accel ID list (i.e. if the patient has accelerometer data)
            #echo "${ID}: accel data"
            echo "${ID},1" >> ${DATADIR}/derived/datamatch.txt     # >> appends the .txt file (on a new line each time): 
    else 
            #echo "${ID}: no accel data"  
            echo "${ID},0" >> ${DATADIR}/derived/datamatch.txt     # >> appends the .txt file (on a new line each time)
    fi 

done 