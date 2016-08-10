### JS Logic:
1. Get the div ID
2. Get the div isbn
3. Make an ajax call.
4. Get the data from GB.
5. Sort the data to only what will be rendered.
6. Use the save div ID to append it back to the div with the new information.
7. Use scroll position to get the data from GB 10 books at a time.
Note: Do not need two way data binding. Simply using jquery to append
information should work
Note 2: URL for query books https://books.google.ca/books?id=kDOlPwAACAAJ
###

booksData = (() ->
  

  return {
  }
  )()

console.log(booksData)
