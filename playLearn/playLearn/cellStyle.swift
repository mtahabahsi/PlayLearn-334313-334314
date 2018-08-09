//
//  cellStyle.swift
//  playLearn
//
//  Created by Sierra on 14.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit

class cellStyle: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
