//
//  EntitiesManager.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import Foundation

final class EntitiesManager {
    static let shared = EntitiesManager()
    
    var users: [User] = []
    var quotes: [Quote] = []
    
    private init() {}
    
    func loadUsers() -> [User] {
        // load all users from backend
        return []
    }
    
    func loadQuotes() -> [Quote] {
        // load all quotes from backend
        return [
            Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs", genre: "Business"),
            Quote(text: "Life is what happens when you're busy making other plans.", author: "John Lennon", genre: "Life"),
            Quote(text: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston Churchill", genre: "Motivation")
        ]
    }
    
    func addUser(user: User) {
        users.append(user)
        // add requesting for backend
    }
    
    func removeUser(user: User) {
        users.removeAll { $0.id == user.id }
        // add requesting for backend
    }
    
    func addQuote(quote: Quote) {
        guard !quotes.contains(where: { $0.text == quote.text && $0.author == quote.author }) else {
                print("Duplicate quote detected")
                return
            }
        
        quotes.append(quote)
        // add requesting for backend
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
