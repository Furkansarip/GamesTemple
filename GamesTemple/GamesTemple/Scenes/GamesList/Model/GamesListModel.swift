//
//  Games.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 6.12.2022.
//

import Foundation

struct GamesListModel: Codable {
    let id: Int?
    let name: String
    let released: String?
    let image: String?
    let rating: Float
    let genres: [Genres]
    let platforms: [Platforms]?
    let ratings: [Ratings]?
    let description: String?
    let screenshots: [Screenshots]
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, genres, platforms, ratings, description
        case image = "background_image"
        case screenshots = "short_screenshots"
        
    }
}

struct Genres: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Platforms: Codable {
    let platform: DetailPlatform
}

struct DetailPlatform: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Ratings: Codable {
    let title: String
    let percent: Float
}

struct Screenshots : Codable {
    let image : String
}
