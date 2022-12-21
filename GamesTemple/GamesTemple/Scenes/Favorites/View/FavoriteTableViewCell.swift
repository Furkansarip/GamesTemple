//
//  FavoriteTableViewCell.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 12.12.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    func configure(game : FavoriteGame){
        nameLabel.text = game.name
        guard let imageURL = URL(string: game.image ?? "") else { return }
        gameImage.af.setImage(withURL: imageURL)
        
    }
    override func prepareForReuse() {
        gameImage.image = nil
    }
    
}
