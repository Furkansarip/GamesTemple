//
//  FavoriteViewController.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 12.12.2022.
//

import UIKit

final class FavoriteViewController: BaseViewController {
    @IBOutlet var favoriteListTableView : UITableView!
    var favoriteGame = [FavoriteGame]()
    var favoriteId : Int?
    var screenshots = [Screenshots]()
    var viewModel = FavoriteViewModel()
    //MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
        favoriteListTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoriteGames()
        indicator.stopAnimating()
        favoriteListTableView.reloadData()
        
    }
    func fetchFavoriteGames() {
        indicator.startAnimating()
        favoriteGame = FavoriteCoreDataManager.shared.getFavoriteGame()
    }
    
}

//MARK: FavoriteTableView
extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteListTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        let favoriteGame = favoriteGame[indexPath.row]
        cell.configure(game: favoriteGame)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favoriteGameId = favoriteGame[indexPath.row].gamesId else { return }
        favoriteId = Int(favoriteGameId)
        viewModel.getImages(gameID: favoriteId ?? 0)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameDetail = segue.destination as? GameDetailViewController else { return }
        gameDetail.isFavorite = true
        gameDetail.gameId = favoriteId
        gameDetail.screenshots = screenshots//GameDetail ekranına geçmeden önce screenshots ve geçerli oyun id pushlanıyor.
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = favoriteGame[indexPath.row]
            FavoriteCoreDataManager().managedContext.delete(object)
            favoriteGame.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try  FavoriteCoreDataManager().managedContext.save()
            } catch {
                showErrorAlert(message: "Favorite Game is not deleted!")
            }
        }
    }
    
}
//MARK: FavoriteViewDelegate
extension FavoriteViewController : FavoriteViewDelegate {
    func favoriteImagesLoaded() {
        DispatchQueue.main.async {
            self.screenshots = self.viewModel.images
            self.performSegue(withIdentifier: "favoriteDetail", sender: nil)
        }
    }
    
    func favoriteImagesFailed(error: ErrorModel) {
        showErrorAlert(message: "Screenshots request Failed")
    }
}
