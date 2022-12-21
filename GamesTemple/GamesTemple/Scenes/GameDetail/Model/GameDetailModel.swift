//
//  GameDetail.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 11.12.2022.
//

import Foundation

struct GameDetail : Codable {
    let id: Int
    let slug, name, released: String
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratingsCount, reviewsTextCount : Int
    let suggestionsCount: Int
    let reviewsCount: Int
    let parentPlatforms: [ParentPlatform]
    let genres: [Genre]
    let developers : [Developers]
    let description : String
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case suggestionsCount = "suggestions_count"
        case reviewsCount = "reviews_count"
        case parentPlatforms = "parent_platforms"
        case genres,developers
        case description = "description_raw"
        
        
    }
}

struct Developers : Codable {
    var name : String
}

struct EsrbRating: Codable {
    let id: Int
    let name, slug: String
}

struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        
    }
}

struct ParentPlatform: Codable {
    let platform: EsrbRating
}



