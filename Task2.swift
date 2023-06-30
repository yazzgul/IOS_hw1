import UIKit
//основные действия с библиотекой
protocol ActInLibraries {
    func addBook(book: Book)
    func borrowBook(book: Book)
    func getBooksByAuthor(author: Author) -> [Book]
    func addReader(reader: Reader)
}
//печатает инфо про книгу (название, автор)
protocol PrintInfo {
    func printTitle()
    func printAuthor()
}
//жанры книг
enum Genre: String {
    case nonFiction
    case fantasy
    case novel
}
//тип книги: печатная/электронная
enum TypeOfBook: String {
    case paper
    case ebook
}
//издатель
struct Publisher {
    let name: String
    let address: String
    init (name: String, address: String) {
        self.name = name
        self.address = address
    }
}
//читатель
struct Reader {
    let name: String
    let age: Int
    let favoriteGenre: Genre
    init(name: String, age: Int, favoriteGenre: Genre) {
        self.name = name
        self.age = age
        self.favoriteGenre = favoriteGenre
    }
}
//для библиотек в городе (название библиотеки и где расположена)
struct LibraryLocation: Equatable {
    let name: String
    let location: String
    init (name: String, location: String) {
        self.name = name
        self.location = location
    }
}
//автор книги
public class Author: Equatable {
    let name : String
    init(name: String) {
        self.name = name
    }
    public static func == (lhs: Author, rhs: Author) -> Bool {
        return (lhs.name == rhs.name)
    }
    
}
//книга с ее данными
public class Book: Equatable, PrintInfo {
    private let title: String
    let author: Author
    let publisher: Publisher
    private let genre: Genre
    private var type: TypeOfBook
    init(title: String, author: Author, publisher: Publisher, genre: Genre, type: TypeOfBook) {
        self.title = title
        self.author = author
        self.publisher = publisher
        self.genre = genre
        self.type = type
    }
    public static func == (lhs: Book, rhs: Book) -> Bool {
        
        return ((lhs.title == rhs.title) && (lhs.author.name == rhs.author.name))
    }
    func printTitle() {
        print(title)
    }
    
    func printAuthor() {
        print(author.name)
    }
    
}
// аудиокнига (наследует от обычной книги, добавляется рассказчик)
public class AudioBook: Book {
    private let narrator: String
    init(title: String, author: Author, publisher: Publisher, genre: Genre, type: TypeOfBook, narrator: String) {
        self.narrator = narrator
        super.init(title: title, author: author, publisher: publisher, genre: genre, type: type)
    }
    override func printAuthor() {
        super.printAuthor()
        print("Narrated by\(narrator)")
    }
    override func printTitle() {
        super.printTitle()
        print("AUDIOBOOK")
        
    }
}

//система библиотеки, то есть что разрешается делать, что хранится
open class LibrarySystem: ActInLibraries {
    //    массив всех книг в библио
    private var books = [Book] ()
    //    каталог автор -> все его книги
    private var catalog = [String: [Book]] ()
    var publishersList = [Publisher]()
    func addBook(book: Book) {
        books.append(book)
        publishersList.append(book.publisher)
        if catalog[book.author.name] == nil {
            catalog[book.author.name] = []
        }
        catalog[book.author.name]?.append(book)
    }
    var borrowedBooks = [Book] ()
    func borrowBook(book: Book) {
        for b in 0 ..< books.count {
            if books[b] == book {
                catalog[book.author.name]?.removeAll{$0 == book}
//                catalog.removeValue(forKey: book.author.name)
                books.remove(at: b)
                borrowedBooks.append(book)
                break
            }
        }
    }
    
    func getBooksByAuthor(author: Author) -> [Book] {
        for a in catalog {
            if a.key == author.name {
                return a.value
            }
        }
        let booksNew = [Book] ()
        print("not found, got empty array")
        return booksNew
    }
    var readersList = [Reader] ()
    func addReader(reader: Reader) {
        readersList.append(reader)
    }
    
}

//менеджер(контроллер) расположений библиотек в городе
open class LibraryManagerOfLocation {
    private var locations = [LibraryLocation] ()
    func addNewLocation (location: LibraryLocation) {
        locations.append(location)
    }
    func removeLocation (location: LibraryLocation) {
        for l in 0 ..< locations.count {
            if (locations[l] == location) {
                locations.remove(at: l)
                break
            }
        }
    }
    func printAllLocations() {
        for l in locations {
            print(l)
        }
    }
}
let publisher = Publisher(name: "ACT", address: "Moscow")
let author1 = Author(name: "Jane Austen")
let book = Book(title: "Pride and prejudice", author: author1, publisher: publisher, genre: .novel, type: .ebook)
var myLibrary = LibrarySystem()
myLibrary.addBook(book: book)
myLibrary.borrowBook(book: book)
book.printTitle()
book.printAuthor()
let author2 = Author(name: "Ray Bradbury")
let audioBook = AudioBook(title: "Fahrenheit 451", author: author2, publisher: publisher, genre: .novel, type: .ebook, narrator: "Ruslan Gabidullin")
myLibrary.addBook(book: audioBook)
let reader = Reader(name: "Yazgul", age: 19, favoriteGenre: .novel)
myLibrary.addReader(reader: reader)
myLibrary.getBooksByAuthor(author: author1)
let location = LibraryLocation(name: "The Library", location: "Square")
var libraryManager = LibraryManagerOfLocation()
libraryManager.addNewLocation(location: location)
libraryManager.printAllLocations()
