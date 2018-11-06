class BooksController < ApplicationController
  before_action :logged_in_user, only: %i(show index)
  before_action :find_book, only: %i(show)

  def show; end

  def index
    @books = Book.paginate page: params[:page],
      per_page: Settings.pages.per_page
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "controllers.users.not_found"
    redirect_to root_path
  end
end
