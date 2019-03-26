class Admin::ExportUsersController < Admin::AdminBaseController
  def index
    csv = ExportCsvService.new User.all.ordered_by_name, User::CSV_ATTRIBUTES
    respond_to do |format|
      format.csv{send_data csv.perform, filename: Settings.csv_users_file}
    end
  end
end
