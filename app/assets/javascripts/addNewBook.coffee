#= require twine
### JS logic to:
1. Add an event handler to the input field
2. Use ajax to query google books api.
3. Display the results from google books api on the page.
4. Fill the hidden fields with the info from API.
5. Enable the submit button.
###
$(document).on 'ready', (event) ->
  context = {}
  addBooks =
    googleBooksURL: 'https://www.googleapis.com/books/v1/volumes'
    googleBooksData: []
    init: () ->
      this.cacheDom()
      this.bindEvents();
      #this.render()
    cacheDom: () ->
      this.$el = $('#book_isbn')
      this.$container = $('.form-group-isbn')
      this.$submitButton = $('.submit-btn')
    bindEvents: () ->
      this.$el.on 'keyup', (event) =>
        isbnNumber = event.target.value
        if isbnNumber.length > 13 or isbnNumber.length < 10
          this.$container.addClass("has-error")
        else
          this.$container.removeClass("has-error")
        if isbnNumber.length == 13 or isbnNumber.length == 10
          this.getInformation(isbnNumber)
    updateBookData: (newItems) ->
      # TO DO: This approach can be simplified if using just the first
      # search result from Google Books API
      newData = newItems.items
      existingData = this.googleBooksData;
      if existingData[0]
        # Check if IDs for all results match what we already have
        update = !(newData.length is existingData.length and newData.every (elem, i) -> elem.id is existingData[i].id)
        return update
      else
        return true
    getInformation: (isbn) ->
      $.get(this.googleBooksURL, { q : isbn, maxResults: 1, key: "AIzaSyBnj2IuHkR0a5wFBDb7qVxjMa8Ly8zL_Oc" }, (data) =>
        if data.items and this.updateBookData(data)
          this.googleBooksData = data.items
          this.render()
      );
    render: () ->
      bookData = this.googleBooksData[0]
      volumeInfo = bookData.volumeInfo

      context.newBookInfo =
        selfLink : bookData.selfLink
        id : bookData.id
        authors : volumeInfo.authors.join(',')
        categories : volumeInfo.categories.join(',')
        description : volumeInfo.description
        title: volumeInfo.title
        imageLinks : volumeInfo.imageLinks
        googleLink : volumeInfo.infoLink
        publishedDate : volumeInfo.publishedDate
        publisher : volumeInfo.publiser
        totalRatings : volumeInfo.ratingsCount
        avgRating: volumeInfo.averageRating

      $ =>
        Twine.reset(context.newBookInfo).bind().refresh()
        this.$submitButton.prop('disabled',false)
        if  context.newBookInfo.imageLinks then $('.gbData__thumbnailImage').attr("src", context.newBookInfo.imageLinks.thumbnail )
        return

  addBooks.init()
