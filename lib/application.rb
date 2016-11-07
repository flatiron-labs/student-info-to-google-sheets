class Application

  def call
    set_batch_id
    fetch_batch_students
    puts "Found data for #{students.length} students. Type 'csv' to download a CSV"
    answer = gets.strip
    puts 'Enter spreadsheet name'
    title = gets.strip
    create_spreadsheet(answer, title)
  end

  private

  attr_reader :batch_id, :students

  def create_spreadsheet(answer, title)
    case answer
    when "csv"
      StudentCsvParser.new(students).to_csv
    else
      sheets_adapter = Adapters::GoogleSheets.new(title)
      sheet = sheets_adapter.create_worksheet("Week of #{Date.today.strftime()}")
      StudentCsvParser.new(students).to_google_sheet(sheet)
    end
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
