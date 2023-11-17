class BookmarksController < ApplicationController
  def new
    # We need @restaurant in our `simple_form_for`
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
   # achar a lista pelo id do url
   @list = List.find(params[:list_id])
   # criar um novo bookmark usando as informações do form (strong params)
   @bookmark = Bookmark.new(bookmark_params)
   # atribuir a lista ao bookmark
   @bookmark.list = @list
   #salvar a lista
   if @bookmark.save
    redirect_to list_path(@list)
   else
    render :new, status: :unprocessable_entity
   end



  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
