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
    func searchGames(searchText:String)
    func searchGenre(genreText:String)
    func getHighestRating()
    func gamesOf2022()
}

protocol GameListViewModelDelegate : AnyObject {
    func gamesLoaded()
    func gamesFailed(error:ErrorModel)
}
final class GameListViewModel : GameListViewModelProtocol {
    weak var delegate : GameListViewModelDelegate?
    public var games : [GamesListModel]?
    public var gamesArray = [GamesListModel]()
    
    func fetchGames(page: Int) {
        NetworkManager.shared.getAllGames(page: page) { [weak self] result in
            guard let self = self else { return }
            LoadingManager().hide()
            switch result {
            case .success(let games):
                self.games = games.results
                self.gamesArray.append(contentsOf: games.results)
                self.delegate?.gamesLoaded()
            case .failure(let error):
                self.delegate?.gamesFailed(error: error)
            }
        }
    }
    
    func getGameCount() -> Int {
        return gamesArray.count
    }
    
    func getGame(at index: Int) -> GamesListModel? {
        return gamesArray[index]
    }
    
    func getGameId(at index: Int) -> Int? {
        return gamesArray[index].id
    }
    
    func searchGames(searchText:String) {
        NetworkManager.shared.searchGame(searchText: searchText) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let searchedGame):
                self.gamesArray = searchedGame.results
                self.delegate?.gamesLoaded()
            case . failure(let error):
                self.delegate?.gamesFailed(error: error)
            }
        }
    }
    
    func searchGenre(genreText: String) {
        NetworkManager.shared.searchGenre(genreText: genreText) { result in
            switch result {
            case .success(let searchedGenres):
                self.gamesArray = searchedGenres.results
                self.delegate?.gamesLoaded()
            case .failure(let error):
                self.delegate?.gamesFailed(error: error)
            }
        }
    }
    
    func getHighestRating() {
        NetworkManager.shared.highestRating(page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let ratings):
                self.gamesArray = ratings.results
                self.delegate?.gamesLoaded()
            case .failure(let error):
                self.delegate?.gamesFailed(error: error)
            }
        }
    }
    
    func gamesOf2022() {
        NetworkManager.shared.thisYearGames(page:1) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let upcoming):
                self.gamesArray = upcoming.results
                self.delegate?.gamesLoaded()
            case . failure(let error):
                self.delegate?.gamesFailed(error: error)
            }
        }
    }
}
