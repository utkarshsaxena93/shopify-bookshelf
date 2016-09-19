#= require twine
ready = (event) ->
  context = {}
  addBooks =
    googleBooksURL: 'https://www.googleapis.com/books/v1/volumes'
    googleBooksData: []
    init: () ->

      this.cacheDom()
      this.bindEvents();

    cacheDom: () ->

      this.$el = $('.query-isbn')
      this.$queryTitle = $('.query-title')
      this.$container = $('.form-group-isbn')
      this.$submitButton = $('.submit-btn')
      this.$resultContainer = $('.gbData__container')

    bindEvents: () ->

      this.$queryTitle.on 'keyup', (event) =>
        title = event.target.value
        if title.length > 5
          this.getInformation(title)

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

    getInformation: (queryParam) ->

      $.get(this.googleBooksURL, { q : queryParam, maxResults: 1, key: "AIzaSyBYfDjMf5wBQzxVxwhZYTlBOynml-eGdkE" }, (data) =>
        if data.items and this.updateBookData(data)
          this.googleBooksData = data.items
          this.render()
      );

    render: () ->
      bookData = this.googleBooksData[0]
      volumeInfo = bookData.volumeInfo

      context.newBookInfo =
        selfLink : bookData.selfLink
        id : bookData.id,
        isbn : if volumeInfo.industryIdentifiers? and volumeInfo.industryIdentifiers[0]? then volumeInfo.industryIdentifiers[0].identifier
        authors : if volumeInfo.authors then volumeInfo.authors.join(',')
        categories : if volumeInfo.categories then volumeInfo.categories.join(',') else ''
        description : volumeInfo.description
        title: volumeInfo.title
        imageLinks : volumeInfo.imageLinks
        googleLink : volumeInfo.infoLink
        publishedDate : volumeInfo.publishedDate
        publisher : volumeInfo.publiser
        totalRatings : volumeInfo.ratingsCount
        avgRating: if volumeInfo.averageRating? then "#{volumeInfo.averageRating}/5"

      this.$resultContainer.css("opacity","1");

      $ =>
        Twine.reset(context.newBookInfo).bind().refresh()
        this.$submitButton.prop('disabled',false)
        if  context.newBookInfo.imageLinks then $('.gbData__thumbnailImage').attr("src", context.newBookInfo.imageLinks.thumbnail )
        return

  addBooks.init()

$(document).on 'ready', ready
