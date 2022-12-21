//
//  ItemCell.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 10.12.2022.
//

import UIKit
import DropDown
class ItemCell: DropDownCell {

    @IBOutlet var itemImage : UIImageView!
    @IBOutlet var itemLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.contentMode = .scaleAspectFit
        optionLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
