#= require twine
ready = (event) ->

  booksRecommendation = (() ->
    $elBtn = $('.btn-recommendation')
    $elModal = $('#modal')
    $elModalLabel = $('.modal-title')
    $elModalBookidInput = $('.modal__bookidInput')
    $elForm = $('.recommendation__form')
    $elModalFooter = $('.modal-footer')
    $elModalTextarea = $('#recommendation')
    targetURL = "/addrecommendation"

    _renderMsg = (msg, id) ->
      $elModal.modal('hide')
      if msg
        $(".notifications-#{id}").html($("<p class='bg-success'></p>").html("Successfully added the review. <strong>Your review will appear shortly</strong>. Go to your <a href='/dashboard'>dashboard</a> to manage your reviews."))
        return
      else
        $(".notifications-#{id}").html($("<p class='bg-danger'></p>").html("Failed to add your review. <strong>Please note you can add only one review per book.</strong> Go to your <a href='/dashboard'>dashboard</a> to manage your reviews."))
        return

    _showModal = (bookid, bookTitle) =>
      $elModalLabel.text("Write a review for #{bookTitle}")
      $elModal.attr("data-bookid", bookid).modal('show')
      $elModalBookidInput.val(bookid)
      $elModalTextarea.val("")

      $elForm.on 'submit', (event) =>
        event.preventDefault()
        booksID = $elModalBookidInput.val()
        $.post( targetURL, {bookid: booksID, recommendation: $elModalTextarea.val()}, (result) =>
            _renderMsg(result.success, booksID)
        );

    init = () ->
      $elBtn.on 'click', (event) =>
        event.preventDefault()
        this.bookid = $(event.target).attr("data-bookid")
        bookTitle = $(".book-#{this.bookid}__title").text()
        _showModal(this.bookid, bookTitle)

    return {
      init: init
    }
    )()
  booksRecommendation.init()

$(document).on 'ready', ready
