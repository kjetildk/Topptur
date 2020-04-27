//
//  VisitCell.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 10.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit

class VisitCell: UITableViewCell {

    var visitName:NSString = ""
    var visitDate:Date = Date()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
