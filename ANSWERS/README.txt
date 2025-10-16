
# Formative assessment

## Environment

This code was run on a Macbook Pro (Sonoma 14.7), in bash and R version 4.4.0.


## Description of the data

### Body measures data

There are 9951 rows, with data on 9950 participants and a header at the top containing column names. The file is comma separated.

There are 28 columns including:
- column 1: A column with no name ("") containing the row number
- column 2: SEQN containing the participant ID
- columns 3-28: contain body measure variables


### Accelerometer data

The accelerometer files have a header line with format <ACTIGRAPH ID=PARTICIPANT_ID>.

The files are tab separated, and there are 8 columns containing accelerometer variables. There is no participant ID as this is contained in the file name (and first line of the file).

There are some lines that have only three columns with NA values.

There are 7455 accelerometer files (with name accel-*.txt).
