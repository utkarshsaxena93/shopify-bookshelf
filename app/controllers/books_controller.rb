class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :search]

  # GET /books
  # GET /books.json
  def index
    @categories = Book.pluck(:category).uniq

    if params[:category] == "All" or params[:category] == nil
      if params[:title] != nil and params[:title] != ""
        @books = Book.where('lower(title) like ?', "%#{params[:title].downcase}%").paginate(:page => params[:page], per_page: 1).order('id DESC')
      else
        @books = Book.paginate(:page => params[:page], per_page: 1).order('id DESC')
      end
    else
      if params[:title] != nil and params[:title] != ""
        @books = Book.where('lower(title) like ? and category like ?', "%#{params[:title].downcase}%", "%#{params[:category]}%").paginate(:page => params[:page], per_page: 1).order('id DESC')
      else
        @books = Book.where('category like ?', "%#{params[:category]}%").paginate(:page => params[:page], per_page: 1).order('id DESC')
      end
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user = current_user

    respond_to do |format|
      if @book.save
        format.html { redirect_to user_dashboard_path, notice: 'Book was successfully added.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to user_dashboard_path, notice: 'Book was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def search
  end

  def addToCurrentlyReading
    book = Book.find(params[:bookid].to_i)
    book.user = current_user
    @currentlyreadinglist = BooksReading.new(book.attributes)
    respond_to do |format|
      if @currentlyreadinglist.save
        format.json { render json: {success: true}}
      else
        format.json { render json: {success: false}}
      end
    end
  end

  def addToWishList
    book = Book.find(params[:bookid].to_i)
    book.user = current_user
    @wishlist = BooksWishlist.new(book.attributes)
    respond_to do |format|
      if @wishlist.save
        format.json { render json: {success: true}}
      else
        format.json { render json: {success: false}}
      end
    end
  end

  def addToAlreadyRead
    book = Book.find(params[:bookid].to_i)
    book.user = current_user
    @alreadyReadList = BooksRead.new(book.attributes)
    respond_to do |format|
      if @alreadyReadList.save
        format.json { render json: {success: true}}
      else
        format.json { render json: {success: false}}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :googleid, :category, :apiLink, :title)
    end
end
