import Foundation
import Combine


final class EntitiesManager {
    static let shared = EntitiesManager()
    
    @Published var users: [User] = []
    @Published var quotes: [Quote] = []
    
    private let apiService = FetchService()
    private var cancellables = Set<AnyCancellable>()
    

    private init() {
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
                        self?.quotes.append(createdQuote)
                        print("Added Quote: \(createdQuote.text) by \(createdQuote.author)")
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
