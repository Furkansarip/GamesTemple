//
//  NetworkManager.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 6.12.2022.
//

import Foundation

struct NetworkManager {
    private let baseURL = Constants().baseURL
    private let API_KEY = Constants().API_KEY
    static let shared = NetworkManager()
    private init(){}
    
    func getAllGames(page:Int,completion:@escaping(_ result:Result<GameResponse,ErrorModel>)->Void){
        let endpoint = "\(baseURL)?key=\(API_KEY)&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                print("error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(GameResponse.self, from: data)
                completion(.success(games))
            }catch{
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func highestRating(page:Int,completion:@escaping(_ result:Result<GameResponse,ErrorModel>)->Void){
        let endpoint = "\(baseURL)?key=\(API_KEY)&dates=2001-01-01,2022-12-31&ordering=-rating&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                print("error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let ratings = try decoder.decode(GameResponse.self, from: data)
                completion(.success(ratings))
            }catch{
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func thisYearGames(page:Int,completion:@escaping(_ result:Result<GameResponse,ErrorModel>)->Void){
        let endpoint = "\(baseURL)?key=\(API_KEY)&dates=2021-12-31,2022-12-31&ordering=-added&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                print("error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let upcoming = try decoder.decode(GameResponse.self, from: data)
                completion(.success(upcoming))
            }catch{
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func getDetail(gameID:Int,completion:@escaping(_ result:Result<GameDetail,ErrorModel>)->Void){
        let endpoint = "\(baseURL)/\(gameID)?key=\(API_KEY)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let detail = try decoder.decode(GameDetail.self, from: data)
                completion(.success(detail))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func getNoteGames(completion:@escaping(_ result:Result<NotesModel,ErrorModel>)->Void){
        let endpoint = "\(baseURL)?key=\(API_KEY)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                print("error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(NotesModel.self, from: data)
                completion(.success(games))
            }catch{
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getScreenshots(id: Int, completion:@escaping(_ result:Result<FavoriteModel,ErrorModel>)->Void){
        let endpoint = "\(baseURL)/\(id)/screenshots?key=\(API_KEY)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                print("error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(FavoriteModel.self, from: data)
                completion(.success(games))
            }catch{
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
}
