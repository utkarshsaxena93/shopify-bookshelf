# Browse books page specific JS

$(document).on 'ready', () ->

  booksData = (() ->
    $el = $('.book-container')
    bookIDs = []

    _render = (id, info) ->
      if info.imageLinks.thumbnail then $(".#{id}__image").attr('src', info.imageLinks.thumbnail)
      $(".#{id}__description").html(info.description)
      $(".#{id}__authors").text(if info.authors then info.authors.join(','))
      $(".#{id}__publishedDate").text(info.publishedDate)
      $(".#{id}__publisher").text(info.publisher)
      if info.averageRating
        $(".#{id}__avgRating").text("#{info.averageRating}/5")
        $(".#{id}__totalRatings").text(info.ratingsCount)
      else
        $(".#{id}__avgRating").text("N/A")
        $(".#{id}__totalRatings").text("N/A")

      return

    _getGBdata = (item, index) ->
      bookID = item.id
      gbURL = item.url
      $.get(gbURL, { key: "AIzaSyDQXH48zubdVETswWjDFe6pLcgLfcjxXHk" }, (result) =>
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

  booksList = (() ->
    $el = $('.add-book-to-list-dropdown')
    $elBtn = $('.add-book-to-list-btn')

    _render = (target, success) ->
      bookid = $(target).parents('ul').data('bookid');
      $notificationContainer = $(".notifications-#{bookid}")
      if success
        $(target).parent('li').addClass('bg-success')
        $el.children('li').addClass('disabled')
        $notificationContainer.append($("<p class='bg-success'></p>").html("Successfully added to the list. Go to your <a href='/dashboard'>dashboard</a> to manage your lists."))
        return
      else
        $notificationContainer.append($("<p class='bg-danger'></p>").html("Failed to add to the list. Please try again. Go to your <a href='/dashboard'>dashboard</a> to manage your lists."))
        return
    _getBookID = (selector) ->
      $(selector).closest('.dropdown-menu').attr('data-bookid')

    init = () ->
      $el.on 'click', 'li', (event) ->
        event.preventDefault()
        classNames = $(event.target).parent('li').attr("class")
        if !(/disabled/.test(classNames))
          targetUrl = event.target.href
          bookid = _getBookID(event.target)
          $.post( targetUrl, {bookid: bookid}, (result) =>
              _render(event.target, result.success, )
          );
        false


    return {
      init: init
    }
    )()

  booksRecommendation = (() ->
    $elBtn = $('.btn-recommendation')
    $elModal = $('#modal')
    $elModalLabel = $('.modal-title')
    $elModalBookidInput = $('.modal__bookidInput')
    $elForm = $('.recommendaiton__form')
    $elModalFooter = $('.modal-footer')
    $elModalTextarea = $('#recommendation')
    targetURL = "/addrecommendation"

    _renderMsg = (msg, id) ->
      $elModal.modal('hide')
      if msg
        $(".notifications-#{id}").html($("<p class='bg-success'></p>").html("Successfully added the recommendation. Go to your <a href='/dashboard'>dashboard</a> to manage your recommendations."))
        return
      else
        $(".notifications-#{id}").html($("<p class='bg-danger'></p>").html("Failed to add your recommendation. <strong>Please note you can add only one recommendation per book.</strong> Go to your <a href='/dashboard'>dashboard</a> to manage your recommendations."))
        return

    _showModal = (bookid, bookTitle) ->
      $elModalLabel.text("Write a recommendation for #{bookTitle}")
      $elModal.attr("data-bookid", bookid).modal('show')
      $elModalBookidInput.val(bookid)
      $elModalTextarea.val("")

    init = () ->
      $elBtn.on 'click', (event) =>
        event.preventDefault()
        this.bookid = $(event.target).attr("data-bookid")
        bookTitle = $(".book-#{this.bookid}__title").text()
        _showModal(this.bookid, bookTitle)

      $elForm.on 'submit', (event) =>
        event.preventDefault()
        $.post( targetURL, {bookid: this.bookid, recommendation: $elModalTextarea.val()}, (result) =>
            _renderMsg(result.success, this.bookid)
        );

    return {
      init: init
    }
    )()

  booksData.init();
  booksList.init();
  booksRecommendation.init()
