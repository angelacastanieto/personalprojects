'''
This script takes a Hal Higdon-formatted CSV file and transforms it to a CSV file uploadable to Google Calendar

Before running this script, you need to store a CSV file formatted like Hal Higdon in the same directory as this file

A Hal Higdon formatted file (shown here as a grid) looks like this (the alignment is off here)

WEEK	MON	TUE	WED	THU	FRI	SAT	SUN
1	Rest	3 m run	3 m run	3 m run	Rest	6	Cross
2	Rest	3 m run	3 m run	3 m run	Rest	7	Cross
3	Rest	3 m run	4 m run	3 m run	Rest	5	Cross
4	Rest	3 m run	4 m run	3 m run	Rest	9	Cross
5	Rest	3 m run	5 m run	3 m run	Rest	10	Cross
6	Rest	3 m run	5 m run	3 m run	Rest	7	Cross
7	Rest	3 m run	6 m run	3 m run	Rest	12	Cross
8	Rest	3 m run	6 m run	3 m run	Rest	Rest	Half Marathon
9	Rest	3 m run	7 m run	4 m run	Rest	10	Cross
10	Rest	3 m run	7 m run	4 m run	Rest	15	Cross
11	Rest	4 m run	8 m run	4 m run	Rest	16	Cross
12	Rest	4 m run	8 m run	5 m run	Rest	12	Cross
13	Rest	4 m run	9 m run	5 m run	Rest	18	Cross
14	Rest	5 m run	9 m run	5 m run	Rest	14	Cross
15	Rest	5 m run	10 m run	5 m run	Rest	20	Cross
16	Rest	5 m run	8 m run	4 m run	Rest	12	Cross
17	Rest	4 m run	6 m run	3 m run	Rest	8	Cross
18	Rest	3 m run	4 m run	2 m run	Rest	Rest	Marathon

Important!!!!  You need to get rid of the first column (Week and Week Numbers)

SO you can just go to Hal Higdons website, copy the entire grid schedule, and paste it into a Google Sheets document.  Then Remove the first column.
Now it shoud look like this in Google Sheets (the alignment is off but you get the idea)

MON	TUE	WED	THU	FRI	SAT	SUN
Rest	3 m run	3 m run	3 m run	Rest	6	Cross
Rest	3 m run	3 m run	3 m run	Rest	7	Cross
Rest	3 m run	4 m run	3 m run	Rest	5	Cross
Rest	3 m run	4 m run	3 m run	Rest	9	Cross
Rest	3 m run	5 m run	3 m run	Rest	10	Cross
Rest	3 m run	5 m run	3 m run	Rest	7	Cross
Rest	3 m run	6 m run	3 m run	Rest	12	Cross
Rest	3 m run	6 m run	3 m run	Rest	Rest	Half Marathon
Rest	3 m run	7 m run	4 m run	Rest	10	Cross
Rest	3 m run	7 m run	4 m run	Rest	15	Cross
Rest	4 m run	8 m run	4 m run	Rest	16	Cross
Rest	4 m run	8 m run	5 m run	Rest	12	Cross
Rest	4 m run	9 m run	5 m run	Rest	18	Cross
Rest	5 m run	9 m run	5 m run	Rest	14	Cross
Rest	5 m run	10 m run	5 m run	Rest	20	Cross
Rest	5 m run	8 m run	4 m run	Rest	12	Cross
Rest	4 m run	6 m run	3 m run	Rest	8	Cross
Rest	3 m run	4 m run	2 m run	Rest	Rest	Marathon

Download the spreadsheet as a comma-delimited (.csv) file.  Make sure to move it to the same directory this file is in.

Now you can run the script to transform this into a format uploadable to Google Calendar!

Open the terminal (on mac its a program called Terminal)
Navigate to the directory you saved this file in.
Run the command below

Generic command:

ruby runner.rb transform --file YOUR-DOWNLOADED-FILE.csv --date YOUR-MARATHON-DATE


Example:
ruby runner.rb transform --file hal-higdon-marathon-novice.csv --date 03-18-2018


The transformed file will start with "to-upload" and will be in the same directory as this file.  Upload this to your Google Calendar of choice
using the Import option.  Be careful when doing this as you cannot undo an upload!

'''

require 'time'
require 'date'
require 'thor'
require 'bson'
require 'csv'

INPUT_HEADER = %w(mon tue wed thu fri sat sun)
OUTPUT_HEADER = ["Subject", "Start Date", "All Day Event", "Start Time", "End Time", "Location", "Description"]
`
ALL_DAY_EVENT = true
START_TIME = ""
END_TIME = ""
LOCATION = ""
DESCRIPTION = ""
`
class Runner < Thor
  desc :transform, 'Transforms a csv file copied from Hal Higdon to uploadable csv for Google Calendar'
  option :file, required: true, type: :string, desc: 'csv file to transform for google calendar'
  option :date, type: :string, required: true, desc: 'marathon date as UTC time in this format: 09-23-2016'
  def transform
    file = options[:file]
    marathon_date = Date.strptime(options[:date], '%m-%d-%Y')

    rows = CSV.read(file)

    num_training_days = (rows.count - 1) * 7 - 1 # subtract 1 for header, mult by num days in week, off by one for some reason

    start_date = marathon_date - num_training_days

    CSV.open("to-upload-#{file}", "wb") do |csv|
      csv << OUTPUT_HEADER
      training_date = start_date
      rows.each_with_index do |row, i|
        if i == 0
          row.each_with_index do |day, j|
            if day.downcase != INPUT_HEADER[j]
              fail "header not valid - should be: #{INPUT_HEADER.join(" ")}"
            end
          end

          next
        end

        row.each do |task|
          csv << [task, training_date, ALL_DAY_EVENT, START_TIME, END_TIME, LOCATION, DESCRIPTION]
          training_date += 1
        end
      end
    end
  end
end

Runner.start(ARGV)
