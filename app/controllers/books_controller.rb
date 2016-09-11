class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :search]

  # GET /books
  # GET /books.json
  def index
    @categories = Book.pluck(:category).uniq

    if current_user
      @userReadList = current_user.books_reads.select(:isbn).map{ |elem| elem }
      @userWishList = current_user.books_wishlists.select(:isbn).map{ |elem| elem.isbn }
      @userReadingList = current_user.books_readings.select(:isbn).map{ |elem| elem.isbn }
    end

    if params[:category] == "All" or params[:category] == nil
      if params[:title] != nil and params[:title] != ""
        @books = Book.where('lower(title) like ?', "%#{params[:title].downcase}%").paginate(:page => params[:page], per_page: 10).order('id DESC')
      else
        @books = Book.paginate(:page => params[:page], per_page: 10).order('id DESC')
      end
    else
      if params[:title] != nil and params[:title] != ""
        @books = Book.where('lower(title) like ? and category like ?', "%#{params[:title].downcase}%", "%#{params[:category]}%").paginate(:page => params[:page], per_page: 10).order('id DESC')
      else
        @books = Book.where('category like ?', "%#{params[:category]}%").paginate(:page => params[:page], per_page: 10).order('id DESC')
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
    @bookAlreadyExists = Book.exists?(isbn: book_params["isbn"].to_i)
    @book = Book.new(book_params)
    @book.user = current_user

    respond_to do |format|
      if  @bookAlreadyExists
        format.html { redirect_to new_book_path, alert: 'Book with this ISBN already exists in the bookshelf.' }
      elsif @book.save
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
    without_tracking(Book) do
      @book.destroy
    end
    respond_to do |format|
      format.html { redirect_to user_dashboard_path, notice: 'Book was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def addToCurrentlyReading
    book = Book.find(params[:bookid].to_i)
    book.user = current_user
    @currentlyreadinglist = BooksReading.new(book.attributes.except("id", "location"))
    respond_to do |format|
      if @currentlyreadinglist.save
        format.json { render json: {success: true}}
      else
        format.json { render json: {success: false}}
      end
    end
  end

  def destroyCurrentlyReading
    without_tracking(BooksReading) do
      books_reading = current_user.books_readings
      books_reading.find(params[:id].to_i).destroy()
    end

    book = Book.find(params[:id].to_i)
    book.user = current_user
    @booksread = BooksRead.new(book.attributes.except("id", "location"))

    respond_to do |format|
      if @booksread.save
        format.html { redirect_to user_dashboard_path, notice: 'Book was successfully moved to your "Read" list.' }
        format.json { head :no_content }
      else
        format.json { render json: {success: false}}
      end
    end
  end

  def addToWishList
    book = Book.find(params[:bookid].to_i)
    book.user = current_user
    @wishlist = BooksWishlist.new(book.attributes.except("id", "location"))
    respond_to do |format|
      if @wishlist.save
        format.json { render json: {success: true}}
      else
        format.json { render json: {success: false}}
      end
    end
  end

  def destroyWishList
    books_wishlist = current_user.books_wishlists
    without_tracking(BooksWishlist) do
      books_wishlist.find(params[:id].to_i).destroy()
    end
    respond_to do |format|
      format.html { redirect_to user_dashboard_path, notice: 'Book was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def addToAlreadyRead
    book = Book.find(params[:bookid].to_i)
    book.user = current_user
    @alreadyReadList = BooksRead.new(book.attributes.except("id", "location"))
    respond_to do |format|
      if @alreadyReadList.save
        format.json { render json: {success: true}}
      else
        format.json { render json: {success: false}}
      end
    end
  end

  def destroyAlreadyRead
    books_read = current_user.books_reads
    without_tracking(BooksRead) do
      books_read.find(params[:id].to_i).destroy()
    end
    respond_to do |format|
      format.html { redirect_to user_dashboard_path, notice: 'Book was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def addRecommendation
    byebug
    book = Book.find(params[:bookid].to_i)
    book.recommendation.new(user_id: current_user.id, user_recommendation: params[:recommendation])
    respond_to do |format|
      if book.save
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
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "The book seems to have been deleted!"
        redirect_to :back
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :googleid, :category, :apiLink, :title, :location)
    end

    def without_tracking(modalName)
      modalName.public_activity_off
      yield if block_given?
      modalName.public_activity_on
    end
end
