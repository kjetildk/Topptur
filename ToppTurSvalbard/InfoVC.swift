//
//  InfoTVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 18.09.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import StoreKit

class InfoVC: UITableViewController {

    @IBOutlet weak var totalHeight: UILabel!
    @IBOutlet weak var compareHeight: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("APPLICATION_TITLE",comment:"Toppturer på Svalbard")
        
        self.buttonLabel.setTitle(NSLocalizedString("INFO_DELETE_BUTTON",comment:"Slette alt"), for: UIControlState())
        
        self.total = summitMgr.getTotalHeight()
        updateHeight()
    }
    
    func updateHeight(){
    
        //main text
        self.totalHeight.text = total.description + " " + NSLocalizedString("SUMMIT_HEIGHT",comment:"moh")
        
        let mountEverest = 8848
        let galdhoepiggen = 2469
        
        //subtitle
        self.compareHeight.text =  (self.total * 100 / galdhoepiggen).description + "% " + NSLocalizedString("INFO_GALD",comment:"av Galdhøpiggen")
            + " (" + galdhoepiggen.description + NSLocalizedString("SUMMIT_HEIGHT",comment:"moh") + "), "
            + (self.total * 100 / mountEverest).description + "% " + NSLocalizedString("INFO_EVER",comment:"av Mount Everest")
            + " (" + mountEverest.description + NSLocalizedString("SUMMIT_HEIGHT",comment:"moh") + ")"
    
    }
    
    // MARK: - Segues
    
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionName:String?
        
        switch(section){
            case 0: sectionName = NSLocalizedString("INFO_HEADER_1",comment:"1")
            case 1: sectionName = NSLocalizedString("INFO_HEADER_2",comment:"2")
            case 2: sectionName = NSLocalizedString("INFO_HEADER_3",comment:"3")
            case 3: sectionName = NSLocalizedString("INFO_HEADER_4",comment:"4")
            case 4: sectionName = NSLocalizedString("INFO_HEADER_5",comment:"5")
            case 5: sectionName = NSLocalizedString("INFO_HEADER_6",comment:"6")
            
            default: sectionName = "Noe er feil her..."
        }
        return sectionName
        
    }
    
    override func tableView(_ tableView: UITableView,
                              titleForFooterInSection section: Int) -> String?{
        
        var sectionName:String?
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        if (section == 0){
            let footertext = NSLocalizedString("INFO_FOOTER_1",comment:"1")
            sectionName = footertext + " : " + appVersion
        }
        
        return sectionName
    }
    
    @IBAction func showActionSheet(_ sender: AnyObject) {
        
        // 1
        let optionMenu = UIAlertController(title: nil, message: NSLocalizedString("INFO_DELETE_ALERT",comment:"Slette?"), preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("INFO_DELETE_BUTTON",comment:"Slette?"), style: .default, handler: {
            (alert: UIAlertAction) -> Void in
            
            summitMgr.deleteAll()
            
            self.total = 0
            self.updateHeight()
            self.reloadInputViews()
            
        })
        
        //
        let cancelAction = UIAlertAction(title: NSLocalizedString("INFO_DELETE_CANCEL",comment:"Avbryt"), style: .cancel, handler: {
            (alert: UIAlertAction) -> Void in
//            print("Avbryt")
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
    }
}
