class Application

  def call
    set_batch_id
    fetch_batch_students
    puts "Found data for #{students.length} students.  Type 'csv' to download a csv or press enter to add to a Google Sheet "

    answer = gets.strip

    if answer == 'csv'
      create_csv
    else
      puts "Enter spreadsheet name"
      spreadsheet_title = gets.strip
      puts "Type 'edit' to edit cells on an existing worksheet or press enter to create a new worksheet"
      response = gets.strip
      if response == 'edit'
        puts "Enter the name of the worksheet you want to edit"
        worksheet_title = gets.strip
        puts "Type the week you are entering data for i.e. 'Week 6'"
        week = gets.strip
        edit_worksheet(spreadsheet_title, worksheet_title, week)
      else
        create_worksheet(spreadsheet_title)
      end
    end
  end

  private

  attr_reader :batch_id, :students

  def create_csv
    StudentCsvParser.new(students).to_csv
  end

  def create_worksheet(spreadsheet_title)
    sheets_adapter = Adapters::GoogleSheets.new(spreadsheet_title)
    worksheet = sheets_adapter.create_worksheet("Week of #{Date.today.strftime()}")
    StudentCsvParser.new(students).to_google_sheet(worksheet)
  end

  def edit_worksheet(spreadsheet_title, worksheet_title, week)
    sheets_adapter = Adapters::GoogleSheets.new(spreadsheet_title)
    worksheet = sheets_adapter.get_worksheet(worksheet_title)
    StudentCsvParser.new(students).update_google_sheet(sheets_adapter, worksheet, week)
  end


  def fetch_batch_students
    adapter = Adapters::Learn.new
    @students = adapter.fetch_batch_students(batch_id)
  end

  def set_batch_id
    puts "Enter a batch ID"
    @batch_id = gets.strip
  end

end
