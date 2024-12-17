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
    
    private init() {
        users = loadUsers()
        quotes = loadQuotes()
    }
    
    func loadUsers() -> [User] {
        // load all users from backend
        return []
    }
    
    func loadQuotes() -> [Quote] {
        // load all quotes from backend
        return []
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
        quotes.append(quote)
        // add requesting for backend
    }
    
    func removeQuote(quote: Quote) {
        quotes.removeAll { $0.text == quote.text }
        // add requesting for backend
    }
}











//Message Andrii Klykavka, David Bakalov ITBA26, Kseniia Hanziuk









