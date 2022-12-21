//
//  NotesTableViewCell.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 14.12.2022.
//

import UIKit
import AlamofireImage

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var noteGameImage: UIImageView!
    
    func configure(noteModel : Note){
       
        cosmosView.settings.starSize = 15
        cosmosView.settings.starMargin = 3.1
        cosmosView.settings.fillMode = .precise
        cosmosView.rating = noteModel.rating
        gameLabel.text = noteModel.gameName
        nameLabel.text = noteModel.header
        guard let imageURL = URL(string: noteModel.gameImage ?? "") else { return }
        noteGameImage.af.setImage(withURL: imageURL)
    }

    
   
    
}


