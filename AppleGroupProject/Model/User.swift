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
    var createdQuotes: [Quote]
    
    init(id: String, username: String, password: String, likedQuotes: [Quote], createdQuotes: [Quote]) {
        self.id = id
        self.username = username
        self.password = password
        self.likedQuotes = likedQuotes
        self.createdQuotes = createdQuotes
    }
    
    func toggleLikedQuote(quote: Quote) {
        likedQuotes.append(quote)
        // add requesting for backend
    }
    
}
