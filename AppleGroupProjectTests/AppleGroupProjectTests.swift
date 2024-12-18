import XCTest
import Combine
@testable import AppleGroupProject

class BackendTests: XCTestCase {
    
    var mockFetchService: MockFetchService!
    var entitiesManager: EntitiesManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockFetchService = MockFetchService()
        entitiesManager = EntitiesManager(apiService: mockFetchService)
    }
    
    override func tearDown() {
        mockFetchService = nil
        entitiesManager = nil
        super.tearDown()
    }
    
    func testLoadUsers() {
        let userObjects = [
            UserResponse.UserObject(
                id: "1",
                userName: "user1",
                password: "password",
                createdQuotes: [],
                likedQuotes: []
            )
        ]
        
        let expectedUserObjects = userObjects.map { userObject in
            User(
                id: userObject.id,
                username: userObject.userName,
                password: userObject.password,
                likedQuotes: userObject.likedQuotes.map { Quote(text: $0.text, author: $0.author, genre: $0.genre, id: $0.id) },
                createdQuotes: userObject.createdQuotes.map { Quote(text: $0.text, author: $0.author, genre: $0.genre, id: $0.id) }
            )
        }
        
        mockFetchService.fetchAllUsersResult = Just(expectedUserObjects)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        entitiesManager.loadUsers()

        XCTAssertEqual(entitiesManager.users.count, 1)
        XCTAssertEqual(entitiesManager.users.first?.username, "user1")
    }
    
    func testLoadQuotes() {
        let expectedQuotes = [Quote(text: "Test Quote", author: "user2", genre: "Inspiration", id: "2")]
        
        mockFetchService.fetchAllQuotesResult = Just(expectedQuotes)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        entitiesManager.fetchAndLoadQuotes()

        XCTAssertEqual(entitiesManager.quotes.count, 1)
        XCTAssertEqual(entitiesManager.quotes.first?.text, "Test Quote")
        XCTAssertEqual(entitiesManager.quotes.first?.author, "user2")
    }
    
    func testAddUser() {
        let newUser = User(id: "3", username: "user3", password: "password3", likedQuotes: [], createdQuotes: [])
        
        entitiesManager.addUser(user: newUser)

        XCTAssertEqual(entitiesManager.users.count, 1)
        XCTAssertEqual(entitiesManager.users.first?.username, "user3")
    }
    
    func testRemoveUser() {
        let userToRemove = User(id: "4", username: "user4", password: "password4", likedQuotes: [], createdQuotes: [])
        
        entitiesManager.users.append(userToRemove)
        
        entitiesManager.removeUser(user: userToRemove)

        XCTAssertEqual(entitiesManager.users.count, 0)
    }
    
    func testAddQuote() {
        let quoteToAdd = QuoteCreationStruct(username: "user5", text: "New Quote", genre: "Motivation")
        let createdQuote = Quote(text: "New Quote", author: "user5", genre: "Motivation", id: "5")

        mockFetchService.addQuoteResult = Just(createdQuote)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        entitiesManager.addQuote(quoteArg: quoteToAdd)

        XCTAssertEqual(entitiesManager.quotes.count, 1)
        XCTAssertEqual(entitiesManager.quotes.first?.text, "New Quote")
    }
    
    func testRemoveQuote() {
        let quoteToRemove = Quote(text: "Quote to Remove", author: "user6", genre: "Humor", id: "6")
        entitiesManager.quotes.append(quoteToRemove)
        
        entitiesManager.removeQuote(quote: quoteToRemove)

        XCTAssertEqual(entitiesManager.quotes.count, 0)
    }
    
    func testSearchQuotes() {
        let quotes = [
            Quote(text: "Inspiring Quote", author: "user7", genre: "Inspiration", id: "1"),
            Quote(text: "Motivational Quote", author: "user8", genre: "Motivation", id: "2"),
            Quote(text: "Funny Quote", author: "user9", genre: "Humor", id: "3")
        ]
        
        entitiesManager.quotes = quotes
        
        let searchResult = entitiesManager.searchQuotes(query: "Motivation")
        
        XCTAssertEqual(searchResult.count, 1)
        XCTAssertEqual(searchResult.first?.text, "Motivational Quote")
    }
    
    func testChangeQuote() {
        let quote = Quote(text: "Old Quote", author: "user1", genre: "Inspiration", id: "1")
        entitiesManager.quotes.append(quote)
        
        let updatedQuote = Quote(text: "Updated Quote", author: "user1", genre: "Inspiration", id: "1")
        
        if let index = entitiesManager.quotes.firstIndex(where: { $0.id == quote.id }) {
            entitiesManager.quotes[index] = updatedQuote
        }
        
        XCTAssertEqual(entitiesManager.quotes.first?.text, "Updated Quote")
        XCTAssertEqual(entitiesManager.quotes.first?.author, "user1")
    }
    
    func testChangeAuthor() {
        let quote = Quote(text: "Some Quote", author: "user10", genre: "Inspiration", id: "10")
        entitiesManager.quotes.append(quote)
        
        let updatedQuote = Quote(text: quote.text, author: "user11", genre: quote.genre, id: quote.id)
        
        if let index = entitiesManager.quotes.firstIndex(where: { $0.id == quote.id }) {
            entitiesManager.quotes[index] = updatedQuote
        }
        
        XCTAssertEqual(entitiesManager.quotes.first?.author, "user11")
        XCTAssertEqual(entitiesManager.quotes.first?.text, "Some Quote")
    }
}
