//
//  User.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

class User {
    var id: String
    var username: String
    var password: String
    var likedQuotes: [Quote]
    
    init(id: String, username: String, password: String, likedQuotes: [Quote]) {
        self.id = id
        self.username = username
        self.password = password
        self.likedQuotes = likedQuotes
    }
    
    func addQuote(quote: Quote) {
        likedQuotes.append(quote)
        // add requesting for backend
    }
    
    func removeQuote(quote: Quote) {
        likedQuotes.removeAll { $0.text == quote.text }
        // add requesting for backend
    }
    
    func loadallQuotes() -> [Quote] {
        //load all quotes from backend
        return []
    }
}
