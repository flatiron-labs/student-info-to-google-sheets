require 'pry'

class StudentCsvParser

  attr_reader :students

  def initialize(students)
    @students = students
  end

  def to_csv
    CSV.open('./students.csv', "wb") do |csv|
      csv << ["Name", "Completed Lessons", "Total Lessons", "Github Username", "Last Seen At"]
      students.each do |student|
        csv << [student["full_name"], student["completed_lessons_count"], student["total_lessons_count"], student["github_username"], student["last_seen_at"] ]
      end
    end
  end

  def to_google_sheet(sheet)
    sheet.insert_rows(1, [["Name", "Completed Lessons", "Total Lessons", "Github Username", "Last Seen At"]])
    student_data = students.map {|student| [student["full_name"], student["completed_lessons_count"], student["total_lessons_count"], student["github_username"], student["last_seen_at"] ]}
    sheet.insert_rows(2, student_data)
    sheet.save
  end

  def update_google_sheet(adapter, worksheet, week)
    students.each do |student|
      percentage_complete = (student["completed_lessons_count"].to_f/student["total_lessons_count"]).round(2)
      row_index = adapter.get_row_index(worksheet, student["github_username"])
      if row_index
        x_index = row_index + 1
        y_index = adapter.get_col_index(worksheet, week) + 1
        worksheet[x_index, y_index] = percentage_complete
        worksheet.save
      end
    end
  end
end
