//
//  NotesModel.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 14.12.2022.
//

import Foundation

struct NotesModel : Decodable {
    var results = [NoteGamesModel]()
}

struct NoteGamesModel : Decodable  {
    let id: Int?
    let name: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case image = "background_image"
    }
}
