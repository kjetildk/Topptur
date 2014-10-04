//
//  SummitCell.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 05.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit

class SummitCell: UITableViewCell {

    @IBOutlet weak var summitName: UILabel!
    @IBOutlet weak var summitVisitCount: UILabel!
    @IBOutlet weak var summitImageView: UIImageView!
    @IBOutlet weak var summitFirstVisitDate: UILabel!
    @IBOutlet weak var summitHeight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.summitImageView.layer.cornerRadius = self.summitImageView.frame.size.width / 2
        self.summitImageView.clipsToBounds = true
        self.summitImageView.layer.borderWidth = 1.0
        self.summitImageView.layer.borderColor = UIColor.blackColor().CGColor
        
        self.summitVisitCount.layer.cornerRadius = 8
        self.summitVisitCount.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
