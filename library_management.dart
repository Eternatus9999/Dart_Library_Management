import 'dart:io';



void printWelcomeMessage() {
  print("\n");
  print(r"""
  ██╗     ██╗██████╗ ██████╗  █████╗ ██████╗ ██╗   ██╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗███╗   ███╗███████╗███╗   ██╗████████╗
  ██║     ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝
  ██║     ██║██████╔╝██████╔╝███████║██████╔╝ ╚████╔╝     ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║
  ██║     ██║██╔══██╗██╔══██╗██╔══██║██╔══██╗  ╚██╔╝      ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║
  ███████╗██║██████╔╝██║  ██║██║  ██║██║  ██║   ██║       ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║
  ╚══════╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝                               
  """);
}

void displayMenu() {
  print("1. Add Regular Book");
  print("2. Add TextBook");
  print("3. Remove Book");
  print("4. Search by Title");
  print("5. Search by Author");
  print("6. Update Book Status");
  print("7. Display All Books");
  print("8. Exit");
  print("Enter your choice (1-8):");
}

void main() {
  printWelcomeMessage();
  var library = BookManagement();
  while (true) {
    displayMenu();
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        library.addRegularBook();
        break;
      case "2":
        library.addTextBook();
        break;
      case "3":
        library.removeBook();
        break;
      case "4":
        library.searchByTitle();
        break;
      case "5":
        library.searchByAuthor();
        break;
      case "6":
        library.updateBookStatus();
        break;
      case "7":
        library.displayAllBooks();
        break;
      case "8":
        print("\nThank you for using Book Management System!");
        return;
      default:
        print("\nInvalid choice! Please try again.");
    }

  }
}

enum BookStatus{available, borrowed}

class Book{
  String title;
  String author;
  String isbn;
  BookStatus status = BookStatus.available;

  Book(this.title, this.author, this.isbn);

  String get getTitle => title;
  set setTitle(String title) => this.title = title;

  String get getAuthor => author;
  set setAuthor(String author) => this.author = author;

  String get getIsbn => isbn;
  set setIsbn(String isbn) => this.isbn =isbn;

  BookStatus get getStatus => status;
  set setStatus(BookStatus status) => this.status = status;

  bool isValidIsbn(){
    return isbn.length == 13;
  }

  void updateStatus(BookStatus newStatus){
    status = newStatus;
  }
  String toString() {
    return 'Title: $title, Author: $author, ISBN: $isbn, Status: $status';
  }
}

class TextBook extends Book{
  String subject;
  int grade;

  TextBook(String title, String author, String isbn, this.subject, this.grade):super(title, author, isbn);

  String get getSubject => subject;
  set setSubject(String subject) => this.subject = subject;

  int get getGrade => grade;
  set setGrade(int grade) => this.grade = grade;

  String toString() {
    return '${super.toString()}, Subject: $subject, Grade Level: $grade';
  }

}



class BookManagement {
  List<Book> books = [];
  bool isValidISBN(String isbn) {
    if (isbn.length != 13) {
      return false;
    }
    for (int i = 0; i < isbn.length; i++) {
      if (!isNumeric(isbn[i])) {
        return false;
      }
    }
    return true;
  }

  bool isNumeric(String str) {
    return int.tryParse(str) != null;
  }

  bool isDuplicateISBN(String isbn) {
    for (var book in books) {
      if (book.getIsbn == isbn) {
        return true;
      }
    }
    return false;
  }

  void addRegularBook() {
    print("\nEnter Regular Book Details:");
    print("Enter title:");
    String title = stdin.readLineSync() ?? "";
    print("Enter author:");
    String author = stdin.readLineSync() ?? "";
    String isbn;
    while (true) {
      print("Enter ISBN (13 digits):");
      isbn = stdin.readLineSync() ?? "";
      if (!isValidISBN(isbn)) {
        print("Invalid ISBN. Please re-enter a valid 13-digit ISBN.");
        continue;
      }
      if (isDuplicateISBN(isbn)) {
        print(
            "A book with this ISBN already exists. Please enter a unique ISBN.");
        continue;
      }
      break;
    }
    var book = Book(title, author, isbn);
    books.add(book);
    print('Book added successfully');
  }

  void addTextBook() {
    print("\nEnter TextBook Details:");
    print("Enter title:");
    String title = stdin.readLineSync() ?? "";
    print("Enter author:");
    String author = stdin.readLineSync() ?? "";
    String isbn;
    while (true) {
      print("Enter ISBN (13 digits):");
      isbn = stdin.readLineSync() ?? "";
      if (!isValidISBN(isbn)) {
        print("Invalid ISBN. Please re-enter a valid 13-digit ISBN.");
        continue;
      }
      if (isDuplicateISBN(isbn)) {
        print(
            "A book with this ISBN already exists. Please enter a unique ISBN.");
        continue;
      }
      break;
    }
    print("Enter subject:");
    String subject = stdin.readLineSync() ?? "";
    print("Enter grade level:");
    int grade = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
    var textbook = TextBook(title, author, isbn, subject, grade);
    books.add(textbook);
    print('TextBook added successfully.');
  }

  void searchByTitle() {
    print("\nEnter title to search:");
    String searchTitle = stdin.readLineSync() ?? "";
    List<Book> foundBooks = [];
    for (var book in books) {
      if (book.getTitle.toLowerCase().contains(searchTitle.toLowerCase())) {
        foundBooks.add(book);
      }
    }
    if (foundBooks.isEmpty) {
      print("No books found with that title.");
    } else {
      print("\nFound Books:");
      for (var book in foundBooks) {
        print(book);
      }
    }
  }

  void searchByAuthor() {
    print("\nEnter author name to search:");
    String searchAuthor = stdin.readLineSync() ?? "";
    List<Book> foundBooks = [];
    for (var book in books) {
      if (book.getAuthor.toLowerCase().contains(searchAuthor.toLowerCase())) {
        foundBooks.add(book);
      }
    }
    if (foundBooks.isEmpty) {
      print("No books found by that author.");
    } else {
      print("\nFound Books:");
      for (var book in foundBooks) {
        print(book);
      }
    }
  }

  void removeBook() {
    print("\nEnter ISBN of book to remove:");
    String isbn = stdin.readLineSync() ?? "";
    bool bookRemoved = false;
    for (int i = 0; i < books.length; i++) {
      if (books[i].getIsbn == isbn) {
        books.removeAt(i);
        bookRemoved = true;
        print('Book removed successfully');
        break;
      }
    }
    if (!bookRemoved) {
      print('No book found with that ISBN.');
    }
  }

  void updateBookStatus() {
    print("\nEnter ISBN of book to update status:");
    String isbn = stdin.readLineSync() ?? "";
    Book? foundBook;
    for (var book in books) {
      if (book.getIsbn == isbn) {
        foundBook = book;
        break;
      }
    }
    if (foundBook == null) {
      print("Book not found!");
      return;
    }
    print("Current status: ${foundBook.getStatus}");
    print("Enter new status (0 for available, 1 for borrowed):");
    String choice = stdin.readLineSync() ?? "";
    if (choice == "0") {
      foundBook.setStatus = BookStatus.available;
      print("Status updated to available.");
    } else if (choice == "1") {
      foundBook.setStatus = BookStatus.borrowed;
      print("Status updated to borrowed.");
    } else {
      print("Invalid choice!");
    }
  }

  void displayAllBooks() {
    if (books.isEmpty) {
      print('\nNo books in the system');
      return;
    }
    print('\nAll Books:');
    for (var book in books) {
      print(book);
    }
  }
}

