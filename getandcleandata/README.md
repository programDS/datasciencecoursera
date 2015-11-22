This repo contains following files:

CodeBook.md:
	This has details on variables and all transformation done on the data
	by run_analysis.R script to get final summary of means of columns, 
	grpouped by activity and subject.
	
final_summary.txt
	This is the file generated, which has final results.
	This is 68 columns, data is grouped by Activity and Subject and
	mean for each column is calculated.
	Activity and Subject are like the primary key of the table generated.

run_analysis.R
	Main and only script which reads data , merges relevant columns
	into one single table and finally merges test and training data`

	More details about the kind of transformation done is listed
	in Codebook.md

	script takes one param, that is the dir where all directory exists.
	default is current dir.

how to run the script:
	run_analysis("/tmp/cleaningdata/uci_har_dataset/")

output:
	generates a final_summary.txt file
