//
//  InfoTVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 18.09.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit

class InfoVC: UITableViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var bigText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("APPLICATION_TITLE",comment:"Toppturer på Svalbard")
        
        self.bigText.text = NSLocalizedString("INFO_DNT_TEXT",comment:"Veldig lang tekst")
        self.bigText.scrollRangeToVisible(0)
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionName:NSString?
        
        switch(section){
            case 0: sectionName = NSLocalizedString("INFO_HEADER_1",comment:"1")
            case 1: sectionName = NSLocalizedString("INFO_HEADER_2",comment:"2")
            case 2: sectionName = NSLocalizedString("INFO_HEADER_3",comment:"3")
            default: sectionName = "Noe er feil her..."
        }
        return sectionName
        
    }
    
}
