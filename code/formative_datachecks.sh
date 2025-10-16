#!/bin/bash

cd ~/formative

## SECTION 3 - PROCESSING THE DATA
## includes data checks

cd ./data/original/accel

rm ./accel_IDs.txt
rm ./accel_filenames.txt
rm ./accel_headers.txt
rm ../BMX_IDs.txt
rm ../datamatch.txt
rm ./NEW-accel*

nano ./accel_IDs.txt

for file in accel-*; do     # cycle accel files
    if [ -f "$file" ]; then     # if the thing is a file (not a directory)

        #echo ${file}

        # remove first row (so that it is now a header)
        tail -n+2 ${file} > NEW-${file}
        
        # extract file names into their own .txt
        echo "${file}" >> accel_filenames.txt     # >> appends the .txt file (on a new line each time)

    fi 
done

# extract the first row of each NEWaccel .txt file. -q suppresses file name output
head -n1 -q ./NEW*.txt > ./accel_headers.txt 
uniq -c ./accel_headers.txt

# line count of each file
wc -l ./NEW*.txt | awk '{print $1}' | uniq  # looks like most files have 10081 lines
wc -l ./NEW*.txt | grep -v 10081            # extract the filenames that don't 


cd ~/formative/data/original
## SECTION 4 - GENERATING A SAMPLE FILE

# extract accel ID numbers - using accel_filenames.txt - generated earlier
grep -o '[0-9]\+' ./accel_filenames.txt > ./accel/accel_IDs.txt   # -o only returns the text that matches, '[0-9]\+' matches 1+ numbers
# file for BMX IDs:
cut -d, -f2 ./BMX_D.csv > ~/formative/data/original/BMX_IDs.txt

BMX_IDs=`tail -n+2 ./BMX_D.csv| cut -d, -f2`    # remove the first row | take the second column
accel_IDs=`grep -o '[0-9]\+' ./accel/accel_filenames.txt`

nano ../derived/datamatch.txt 
for ID in $BMX_IDs; do     # cycle BMX data IDs

    if grep -q ${ID} ./accel/accel_filenames.txt; then  # if the BMX ID is found in the accel ID list (i.e. if the patient has accelerometer data)
            #echo "${ID}: accel data"
            echo "${ID},1" >> ../derived/datamatch.txt     # >> appends the .txt file (on a new line each time): 
    else 
            #echo "${ID}: no accel data"  
            echo "${ID},0" >> ../derived/datamatch.txt     # >> appends the .txt file (on a new line each time)
    fi 

done 
