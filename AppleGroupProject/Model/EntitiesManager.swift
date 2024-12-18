import Foundation
import Combine

final class EntitiesManager {
    static let shared = EntitiesManager()
    
    @Published var users: [User] = []
    @Published var quotes: [Quote] = []
    @Published var currentUser: String
    var apiService: FetchServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiService: FetchServiceProtocol = FetchService()) {
        self.apiService = apiService
        self.currentUser = ""
        self.users = []
        self.quotes = []
        loadUsers()
        fetchAndLoadQuotes()
    }
    

    func loadUsers() {
        apiService.fetchAllUsers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to fetch users: \(error)")
                case .finished:
                    print("Successfully fetched users.")
                }
            }, receiveValue: { [weak self] fetchedUsers in
                self?.users = fetchedUsers
            })
            .store(in: &cancellables)
    }
    
    func fetchAndLoadQuotes() {
        apiService.fetchAllQuotes()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to fetch quotes: \(error)")
                case .finished:
                    print("Successfully fetched quotes.")
                }
            }, receiveValue: { [weak self] fetchedQuotes in
                self?.quotes = fetchedQuotes
                print("Quotes loaded: \(fetchedQuotes.count) quotes")
            })
            .store(in: &cancellables)
        
    }
    
    func regUser(user: String, password: String) {
        apiService.Register(userName: user, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to register user: \(error)")
                case .finished:
                    print("Registration process completed.")
                }
            }, receiveValue: { isSuccess in
                if isSuccess {
                    self.currentUser = user
                } else {
                    print("User registration failed for user: \(user)")
                }
            })
            .store(in: &cancellables)
    }
    func logUser(user: String, password: String, completion: @escaping (Bool) -> Void) {
        apiService.Login(userName: user, password: password)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .failure(let error):
                    print("Failed to log in user: \(error)")
                    completion(false)
                case .finished:
                    print("Login process completed.")
                }
            }, receiveValue: { isSuccess in
                if isSuccess {
                    self.currentUser = user
                    print("Logged in as \(user)") // Debug log
                    completion(true)
                } else {
                    print("Failed to log in as \(user)") // Debug log
                    completion(false)
                }
            })
            .store(in: &cancellables)
    }

    func addUser(user: User) {
        users.append(user)
        // add requesting for backend
    }
    
    func removeUser(user: User) {
        users.removeAll { $0.id == user.id }
        // add requesting for backend
    }
    
    func addQuote(quoteArg: QuoteCreationStruct) {
        apiService.addQuote(quote: quoteArg)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            print("Failed to add quote: \(error)")
                        case .finished:
                            print("Successfully added quote.")
                        }
                    }, receiveValue: { [weak self] createdQuote in
                        self?.quotes.insert(createdQuote, at: 0)
                    })
                    .store(in: &cancellables)
    }
    
    func removeQuote(quote: Quote) {
        quotes.removeAll { $0.text == quote.text }
        // add requesting for backend
    }
    
    func searchQuotes(query: String) -> [Quote] {
        guard !query.isEmpty else { return quotes }
        
        let lowercasedQuery = query.lowercased()
        return quotes.filter { quote in
            quote.text.lowercased().contains(lowercasedQuery) ||
            quote.author.lowercased().contains(lowercasedQuery) ||
            quote.genre.lowercased().contains(lowercasedQuery)
        }
    }
}
