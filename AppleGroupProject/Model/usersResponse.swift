//
//  usersResponse.swift
//  AppleGroupProject
//
//  Created by david david on 18.12.2024.
//

struct UserResponse: Decodable {
    struct UserObject: Decodable {
        let id: String
        let userName: String
        let password: String
        let createdQuotes: [QuotesResponse.QuoteObject]
        let likedQuotes: [QuotesResponse.QuoteObject]
    }
    
    let users: [UserObject]
}

struct RegisterResponse: Decodable {
    let regResult: Bool
}

struct LoginResponse: Decodable {
    let logResult: Bool
}
