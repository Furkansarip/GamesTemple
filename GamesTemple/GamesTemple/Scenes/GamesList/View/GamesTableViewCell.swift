//
//  GamesTableViewCell.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 6.12.2022.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    
    func configure(game : GamesListModel){
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.starMargin = 3.1
        cosmosView.settings.totalStars = 5
        cosmosView.settings.updateOnTouch = false
        cosmosView.text = "\(game.rating)"
        gameNameLabel.text = game.name
        cosmosView.rating = Double(game.rating)
        guard let imageURL = URL(string: game.image ?? "") else { return }
        gameImage.af.setImage(withURL: imageURL)
        
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
    
}
