//
//  feedTableViewCell.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/17.
//

import UIKit

class feedTableViewCell: UITableViewCell {
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var userImage: UIImage!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
