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
    @IBOutlet weak var totalHeight: UILabel!
    @IBOutlet weak var compareHeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("APPLICATION_TITLE",comment:"Toppturer på Svalbard")
        
        var total = 0
        
        for(var i=0;i < summitMgr.summits.count;i++)
        {
            var count = summitMgr.summits[i].getVisitCount()
            if(count > 0)
            {
                total += count * summitMgr.summits[i].height
            }
        }
        
        //main text
        self.totalHeight.text = total.description + " " + NSLocalizedString("SUMMIT_HEIGHT",comment:"moh")
        
        var mountEverest = 8848
        var galdhoepiggen = 2469
        
        //subtitle
        self.compareHeight.text = (total * 100 / galdhoepiggen).description + "% " + NSLocalizedString("INFO_GALD",comment:"av Galdhøpiggen")
                                + " (" + galdhoepiggen.description + NSLocalizedString("SUMMIT_HEIGHT",comment:"moh") + "), "
                                + (total * 100 / mountEverest).description + "% " + NSLocalizedString("INFO_EVER",comment:"av Mount Everest")
                                + " (" + mountEverest.description + NSLocalizedString("SUMMIT_HEIGHT",comment:"moh") + ")"
        
        
        //self.bigText.text = NSLocalizedString("INFO_DNT_TEXT",comment:"Veldig lang tekst")
        //self.bigText.scrollRangeToVisible(0)
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionName:NSString?
        
        switch(section){
            case 0: sectionName = NSLocalizedString("INFO_HEADER_1",comment:"1")
            case 1: sectionName = NSLocalizedString("INFO_HEADER_2",comment:"2")
            case 2: sectionName = NSLocalizedString("INFO_HEADER_3",comment:"3")
            case 3: sectionName = NSLocalizedString("INFO_HEADER_4",comment:"4")

            default: sectionName = "Noe er feil her..."
        }
        return sectionName
        
    }
    
}
