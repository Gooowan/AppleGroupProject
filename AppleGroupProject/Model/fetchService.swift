//
//  fetchService.swift
//  AppleGroupProject
//
//  Created by david david on 18.12.2024.
//

import Foundation
import Combine
import UIKit

private enum APIEndpoint {
    
    static let baseURL = URL(string: "https://rpa-final-bakcend.onrender.com/")!
    
}

final class FetchService: FetchServiceProtocol {
    private var cancellable = Set<AnyCancellable>()
    
    func fetchAllQuotes() -> AnyPublisher<[Quote], Error> {
            let quotesURL = APIEndpoint.baseURL.appendingPathComponent("quote/getAllQuotes")
            var request = URLRequest(url: quotesURL)
            request.httpMethod = "GET"
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: QuotesResponse.self, decoder: JSONDecoder())
                .map { response in
                    response.objects.quotes.map {
                        Quote( text: $0.text, author: $0.author, genre: $0.genre, id: $0.id )
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    func fetchAllUsers() -> AnyPublisher<[User], Error> {
        let usersURL = APIEndpoint.baseURL.appendingPathComponent("quote/getAllUsers")
        var request = URLRequest(url: usersURL)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .map { response in
                response.users.map { userObject in
                    let createdQuotes = userObject.createdQuotes.map {
                        Quote(text: $0.text, author: $0.author, genre: $0.genre, id: $0.id)
                    }
                    
                    let likedQuotes = userObject.likedQuotes.map {
                        Quote(text: $0.text, author: $0.author, genre: $0.genre, id: $0.id)
                    }
                    
                    return User(
                        id: userObject.id,
                        username: userObject.userName,
                        password: userObject.password,
                        likedQuotes: likedQuotes,
                        createdQuotes: createdQuotes
                    )
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func makePostRequest<T: Encodable>(endpoint: String, body: T) -> AnyPublisher<Data, Error> {
            let url = APIEndpoint.baseURL.appendingPathComponent(endpoint)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .mapError { $0 as Error }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
    func addQuote(quote: QuoteCreationStruct) -> AnyPublisher<Quote, Error> {
        makePostRequest(endpoint: "quote/create", body: quote)
            .decode(type: CreateQuoteResponse.self, decoder: JSONDecoder())
            .map { response in
                let quoteObject = response.create
                return Quote(
                    text: quoteObject.text,
                    author: quoteObject.author,
                    genre: quoteObject.genre,
                    id: quoteObject.id
                )
            }
            .eraseToAnyPublisher()
    }
    
    func Register(userName: String, password: String) -> AnyPublisher<Bool, Error> {
        let body = ["username": userName, "password": password]

        return makePostRequest(endpoint: "auth/register", body: body)
            .decode(type: RegisterResponse.self, decoder: JSONDecoder())
            .map { response in
                return response.regResult
            }
            .eraseToAnyPublisher()
    }
    
    func Login(userName: String, password: String) -> AnyPublisher<Bool, Error> {
        let body = ["username": userName, "password": password]

        return makePostRequest(endpoint: "auth/login", body: body)
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .map { response in
                return response.logResult
            }
            .eraseToAnyPublisher()
    }
    
}
