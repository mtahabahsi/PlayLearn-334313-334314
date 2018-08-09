//
//  labelStyle.swift
//  playLearn
//
//  Created by Sierra on 15.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit

class labelStyle: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
