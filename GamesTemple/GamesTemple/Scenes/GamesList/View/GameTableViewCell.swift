//
//  GameTableViewCell.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 6.12.2022.
//

import UIKit
import AlamofireImage
class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameRatingLabel: UILabel!
    

    func configure(game : GamesListModel){
        gameNameLabel.text = game.name
        gameRatingLabel.text = "\(game.rating)"
        guard let imageURL = URL(string: game.image ?? "") else { return }
        gameImage.af.setImage(withURL: imageURL)
        
    }
    override func prepareForReuse() {
        gameImage.image = nil
    }
}
