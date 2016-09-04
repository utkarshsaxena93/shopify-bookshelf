#= require twine
ready = (event) ->
  showBooks =
    init: () ->
      this.cacheDom();

    cacheDom: () ->
      this.$url = $('#book').attr('data-googleurl')
      this.getBookData()

    getBookData: () ->

      $.get(this.$url, (data) =>
        console.log data
        this.googleBooksData = data
        this.render()
      );

    render: () ->
      volumeInfo = this.googleBooksData.volumeInfo

      $(".book__image").text(volumeInfo.imageLinks.thumbnail)
      $(".book__link").text(volumeInfo.previewLink)
      $(".book__description").text(volumeInfo.description)
      $(".book__authors").text(if volumeInfo.authors then volumeInfo.authors.join(','))
      $(".book__publishedDate").text(volumeInfo.publishedDate)
      $(".book__publisher").text(volumeInfo.publisher)
      $(".book__avgRating").text("#{volumeInfo.averageRating}/5")
      $(".book__totalRatings").text(volumeInfo.ratingsCount)
      return

  showBooks.init()

$(document).on 'ready', ready
