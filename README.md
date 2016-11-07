# Student Completion to Sheets

A script to update a Google Sheet with a batch's students lab completion.

## Instructions

Clone the repository and run `ruby bin/run`.

The first time you run the script, you'll be prompted to authenticate with your Google Account.

Once you've done so, the script will continue. Enter the batch id of the batch you need information for (You can get this from the url when visiting `learn.co/batches/:batch_id/progress`)

Once the info is loaded, you'll be prompted to either put it into a CSV or use a google sheet. Enter the name of the Google Sheet - a new worksheet will automatically be created in the spreadsheet.
