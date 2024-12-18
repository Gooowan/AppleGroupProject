import Foundation
import Combine

protocol FetchServiceProtocol {
    func fetchAllQuotes() -> AnyPublisher<[Quote], Error>
    func fetchAllUsers() -> AnyPublisher<[User], Error>
    func addQuote(quote: QuoteCreationStruct) -> AnyPublisher<Quote, Error>
    func Register(userName: String, password: String) -> AnyPublisher<Bool, Error>
    func Login(userName: String, password: String) -> AnyPublisher<Bool, Error>
}

class MockFetchService: FetchServiceProtocol {
    var fetchAllUsersResult: AnyPublisher<[User], Error>?
    var fetchAllQuotesResult: AnyPublisher<[Quote], Error>?
    var addQuoteResult: AnyPublisher<Quote, Error>?
    var shouldRegisterSucceed: Bool = true
    var shouldLoginSucceed: Bool = true

    func fetchAllUsers() -> AnyPublisher<[User], Error> {
        return fetchAllUsersResult ?? Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func fetchAllQuotes() -> AnyPublisher<[Quote], Error> {
        return fetchAllQuotesResult ?? Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func addQuote(quote: QuoteCreationStruct) -> AnyPublisher<Quote, Error> {
        return addQuoteResult ?? Just(Quote(text: "", author: "", genre: "", id: "" ))
            .setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func Register(userName: String, password: String) -> AnyPublisher<Bool, Error> {
        return Just(shouldRegisterSucceed)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func Login(userName: String, password: String) -> AnyPublisher<Bool, Error> {
        return Just(shouldLoginSucceed)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
