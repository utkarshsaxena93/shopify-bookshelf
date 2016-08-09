### JS logic to:
1. Add an event handler to the input field
2. Use ajax to query google books api.
3. Display the results from google books api on the page.
4. Fill the hidden fields with the info from API.
5. Enable the submit button.
###
$(document).on 'ready', (event) ->
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
      newData = newItems.items
      existingData = this.googleBooksData;
      if existingData[0]
        # Check if IDs for all results match what we already have
        update = !(newData.length is existingData.length and newData.every (elem, i) -> elem.id is existingData[i].id)
        return update
      else
        return true
    getInformation: (isbn) ->
      $.get(this.googleBooksURL, { q : isbn, maxResults: 3, projection: "lite", key: "AIzaSyBnj2IuHkR0a5wFBDb7qVxjMa8Ly8zL_Oc" }, (data) =>
        if data.items and this.updateBookData(data)
          this.googleBooksData = data.items
          this.render()
      );
    render: () ->
      console.log "rendering dom"

  addBooks.init()
