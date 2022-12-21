//
//  GameListViewModel.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 6.12.2022.
//

import Foundation

protocol GameListViewModelProtocol {
    var delegate : GameListViewModelDelegate? { get set }
    func fetchGames(page:Int)
    func getGameCount() -> Int
    func getGame(at index:Int) -> GamesListModel?
    func getGameId(at index:Int) -> Int?
    func getHighestRating()
    func upcomingGames()
}

protocol GameListViewModelDelegate : AnyObject {
    func gamesLoaded()
    func gamesFailed(error:ErrorModel)
}
final class GameListViewModel : GameListViewModelProtocol {
    
    weak var delegate : GameListViewModelDelegate?
    public var games : [GamesListModel]?
    
    func fetchGames(page: Int) {
        NetworkManager.shared.getAllGames(page: page) { [weak self] result in
            guard let self = self else { return }
            LoadingManager().hide()
            switch result {
            case .success(let games):
                self.games = games.results
                self.delegate?.gamesLoaded()
            case .failure(let error):
                self.delegate?.gamesFailed(error: error)
            }
        }
    }
    
    func getGameCount() -> Int {
        return games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GamesListModel? {
        return games?[index]
    }
    
    func getGameId(at index: Int) -> Int? {
        return games?[index].id
    }
    
    func getHighestRating() {
        NetworkManager.shared.highestRating(page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let ratings):
                self.games = ratings.results
                self.delegate?.gamesLoaded()
            case .failure(let error):
                self.delegate?.gamesFailed(error: error)
            }
        }
    }
    
    func upcomingGames() {
        NetworkManager.shared.thisYearGames(page:1) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let upcoming):
                self.games = upcoming.results
                self.delegate?.gamesLoaded()
            case . failure(let error):
                self.delegate?.gamesFailed(error: error)
            }
        }
    }
}
