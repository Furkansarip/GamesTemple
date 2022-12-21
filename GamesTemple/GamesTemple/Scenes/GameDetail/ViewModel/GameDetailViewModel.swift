//
//  GameDetailViewModel.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 11.12.2022.
//

import Foundation

protocol GameDetailViewModelProtocol {
    var delegate : GameDetailViewModelDelegate? { get set }
    func fetchGame(id:Int)
    func gameID() -> Int
}

protocol GameDetailViewModelDelegate : AnyObject {
    func gameDetailLoaded()
    func gameDetailFail(error:ErrorModel)
}

final class GameDetailViewModel : GameDetailViewModelProtocol {
    
    weak var delegate: GameDetailViewModelDelegate?
    
    var gameDetail : GameDetail?
    func fetchGame(id: Int) {
        NetworkManager.shared.getDetail(gameID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gameDetail):
                self.gameDetail = gameDetail
                self.delegate?.gameDetailLoaded()
            case .failure(let error):
                self.delegate?.gameDetailFail(error: error)
                
            }
        }
    }
    
    func gameID() -> Int {
        return gameDetail?.id ?? 0
    }

    
    
}
