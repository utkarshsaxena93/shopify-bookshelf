# Browse books page specific JS

$(document).on 'ready', () ->
  booksData = (() ->
    $el = $('.well')
    bookIDs = []

    _render = (id, info) ->
      $(".#{id}__image").text(info.imageLinks.thumbnail)
      $(".#{id}__link").text(info.previewLink)
      $(".#{id}__description").text(info.description)
      $(".#{id}__authors").text(if info.authors then info.authors.join(','))
      $(".#{id}__publishedDate").text(info.publishedDate)
      $(".#{id}__publisher").text(info.publisher)
      $(".#{id}__avgRating").text("#{info.averageRating}/5")
      $(".#{id}__totalRatings").text(info.ratingsCount)
      return

    _getGBdata = (item, index) ->
      bookID = item.id
      gbURL = item.url
      $.get(gbURL, { key: "AIzaSyBnj2IuHkR0a5wFBDb7qVxjMa8Ly8zL_Oc" }, (result) =>
        if result then _render(bookID, result.volumeInfo)
    );

    init = () ->

      $el.each () ->
        bookIDs.push id: $(this).attr('id'), url: $(this).attr('data-googlelink')
      bookIDs.forEach(_getGBdata)

    return {
      init: init
    }
    )()

  booksData.init();
