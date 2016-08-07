### JS logic to:
1. Add an event handler to the input field
2. Use ajax to query google books api.
3. Display the results from google books api on the page.
4. Fill the hidden fields with the info from API.
5. Enable the submit button.
###
$(document).on 'ready', (event) ->
  addBooks =
    init: () ->
      this.cacheDom()
      this.bindEvents();
      #this.render()
    cacheDom: () ->
      this.$el = $('#book_isbn')
      this.$container = $('.form-group-isbn')
    bindEvents: () ->
      this.$el.on 'keyup', (event) =>
        isbnNumber = event.target.value
        if isbnNumber.length > 13 or isbnNumber.length < 10
          this.$container.addClass("has-error")
        else
          this.$container.removeClass("has-error")
        if isbnNumber.length > 9
          console.log isbnNumber



  addBooks.init()
