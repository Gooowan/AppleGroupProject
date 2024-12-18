//
//  quoteCreationStruct.swift
//  AppleGroupProject
//
//  Created by david david on 18.12.2024.
//

struct QuoteCreationStruct: Encodable {
    var username: String
    var text: String
    var genre: String
    
    init(username: String, text: String, genre: String) {
        self.username = username
        self.text = text
        self.genre = genre
    }
}
