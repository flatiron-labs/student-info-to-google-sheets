require 'pry'

module Adapters
  class GoogleSheets

    attr_reader :session, :spreadsheet

    def initialize(spreadsheet_title)
      @session = GoogleDrive::Session.from_config("config.json")
      @spreadsheet = session.spreadsheet_by_title(spreadsheet_title)
    end

    def create_worksheet(title)
      spreadsheet.add_worksheet(title)
    end

    def get_worksheet(title)
      spreadsheet.worksheets.find{ |ws| ws.title == title }
    end

    def get_row_index(worksheet, username)
      worksheet.rows.index{ |row| row.include?(username)}
    end

    def get_col_index(worksheet, week)
      worksheet.rows[0].index(week)
    end
  end
end
