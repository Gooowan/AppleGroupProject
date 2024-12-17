//
//  Quote.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//
import Foundation

class Quote {
    var text: String
    var author: String
    var genre: String
    
    init(text: String, author: String, genre: String) {
        self.text = text
        self.author = author
        self.genre = genre
    }
    
    func ChangeQuote(text: String){
        self.text = text
    }
    
    func ChangeAuthor(text: String){
        self.text = text
    }

}
