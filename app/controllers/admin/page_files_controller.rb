class Admin::PageFilesController < AdminController

  def destroy
    @page_file = PageFile.find params[:id]
    @success = @page_file.destroy!
  end

end
