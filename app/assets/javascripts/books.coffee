# Browse books page specific JS

$(document).on 'ready', () ->

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
    
  booksList.init();
  booksRecommendation.init()
