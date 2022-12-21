//
//  SlideCollectionViewCell.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 17.12.2022.
//

import UIKit
import AlamofireImage

class SlideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImage: UIImageView!
    
    func configure(screenshot: URL){
        gameImage.af.setImage(withURL: screenshot)
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
}
