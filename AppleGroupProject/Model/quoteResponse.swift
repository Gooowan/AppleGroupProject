//
//  quoteResponse.swift
//  AppleGroupProject
//
//  Created by david david on 18.12.2024.
//

struct QuotesResponse: Decodable {
    struct QuoteObject: Decodable {
        let id: String
        let text: String
        let author: String
        let genre: String
    }
    
    let objects: Objects
    
    struct Objects: Decodable {
        let quotes: [QuoteObject]
    }
}

struct CreateQuoteResponse: Decodable {
    struct QuoteObject: Decodable {
        let id: String
        let text: String
        let author: String
        let genre: String
    }
    
    let objects: Objects
    
    struct Objects: Decodable {
        let quote: QuoteObject
    }
}
