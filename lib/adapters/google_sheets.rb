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
  end
end
