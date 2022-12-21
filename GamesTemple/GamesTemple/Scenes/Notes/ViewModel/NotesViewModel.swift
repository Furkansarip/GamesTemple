//
//  NotesViewModel.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 14.12.2022.
//

import Foundation


protocol NotesViewModelProtocol {
    var delegate : NotesViewDelegate? { get set }
    func fecthGames()
}

protocol NotesViewDelegate : AnyObject {
    func noteLoaded()
    func noteFailed(error:ErrorModel)
}

final class NotesViewModel : NotesViewModelProtocol {
  
    weak var delegate: NotesViewDelegate?
    var games : [NoteGamesModel]?
    
    func fecthGames() {
        NetworkManager.shared.getNoteGames { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let noteGames):
                self.games = noteGames.results
                self.delegate?.noteLoaded()
            case .failure(let error):
                self.delegate?.noteFailed(error: error)
                
            }
        }
    }
    
    
}
