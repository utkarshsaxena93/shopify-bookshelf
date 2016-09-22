#= require twine
ready = (event) ->

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
        $(".notifications-#{id}").html($("<p class='bg-success'></p>").html("Successfully added the recommendation. <strong>Your recommendation will appear shortly</strong>. Go to your <a href='/dashboard'>dashboard</a> to manage your recommendations."))
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
  booksRecommendation.init()

$(document).on 'ready', ready
