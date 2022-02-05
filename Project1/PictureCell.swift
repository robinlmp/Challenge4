//
//  PictureCell.swift
//  Project1
//
//  Created by Robin Phillips on 05/02/2022.
//

import UIKit

class PictureCell: UITableViewCell {
    @IBOutlet var pictureImage: UIImageView!
    @IBOutlet var pictureCaption: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
