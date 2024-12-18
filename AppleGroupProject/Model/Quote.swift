//
//  Quote.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//
import Foundation

class Quote {
    let id: String
    var text: String
    var author: String
    var genre: String
    
    init(text: String, author: String, genre: String, id: String) {
        self.text = text
        self.author = author
        self.genre = genre
        self.id = id
    }
    
    func ChangeQuote(text: String) {
        self.text = text
    }
    
    func ChangeAuthor(text: String) {
        self.text = text
    }

}
