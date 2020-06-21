//
//  DetailVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 01.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet var visitList: UITableView!
    @IBOutlet weak var summitImage: UIImageView!
    @IBOutlet weak var summitLabel: UILabel!
    @IBOutlet weak var emptyListMessageLabel: UILabel!
    
    @IBAction func openURL(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://svalbardturn.no/topptrimmen/varden-i-endalen/")! as URL)
    }
    
    var summit:Summit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = summit!.name
        
        self.summitImage.image = summit!.imageSummit
        
        //self.summitImage.layer.cornerRadius = self.summitImage.frame.size.width / 5
        self.summitImage.clipsToBounds = true
        //self.summitImage.layer.borderWidth = 0.7
        //self.summitImage.layer.borderColor = UIColor.gray.cgColor
        
        self.emptyListMessageLabel.text = NSLocalizedString("DETAILS_TEXT_MESSAGE",comment:"Dobbeltrykk for å legge til dagens besøk")
        
        updateSummitlabel()
    }
    
    func updateSummitlabel()
    {
        var text = ""
        
        if(self.summit!.visitdates.count == 0)
        {
            text = self.summit!.getHeight() + " - " + NSLocalizedString("DETAILS_TEXT_1",comment:"Du har ikke besøkt denne toppen ennå")
            
            self.emptyListMessageLabel.isHidden = false
        }
        else if(self.summit!.visitdates.count == 1)
        {
            text = self.summit!.getHeight() + " - "
                + NSLocalizedString("DETAILS_TEXT_2",comment:"Du har besøkt toppen ")
                + self.summit!.visitdates.count.description
                + NSLocalizedString("DETAILS_TEXT_3",comment:" gang")
            
            self.emptyListMessageLabel.isHidden = true
        }
        else
        {
            text = self.summit!.getHeight() + " - "
                + NSLocalizedString("DETAILS_TEXT_2",comment:"Du har besøkt toppen ")
                + self.summit!.visitdates.count.description
                + NSLocalizedString("DETAILS_TEXT_4",comment:" ganger")
            
            self.emptyListMessageLabel.isHidden = true
        }
        
        self.summitLabel.text = text
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        visitList.reloadData()
    }
    
    //Button clicked
    func loggVisit() {
        
        summitMgr.addVisit(summit!.name,comment: "")
        
        visitList.reloadData()
        updateSummitlabel()
    }
    
    //Add current date to the list
    @IBAction func AddCurrentDate(_ sender: AnyObject) {
        
        loggVisit()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionName:String?
        
        switch(section){
        case 0: sectionName = NSLocalizedString("DETAILS_VISITS",comment:"1")
            
        default: sectionName = "Noe er feil her..."
        }
        return sectionName
        
    }
    
    //This is for the tableview actions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summit!.getVisitCount()
    }
    
    //draw a item in the list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:VisitCell = tableView.dequeueReusableCell(withIdentifier: "VisitCell") as! VisitCell
        
        if(summit!.visitdates.count > 0){
            
            let date:Date = summit!.visitdates[(indexPath as NSIndexPath).row].visitDate as Date
            let comment:String = summit!.visitdates[(indexPath as NSIndexPath).row].visitComment
            
            //let date:NSDate = summitMgr.getVisitDateByIndex(summit!.name, index: indexPath.row)
        
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            cell.visitDate = date
            cell.detailTextLabel?.text = comment as String
            cell.textLabel?.text = formatter.string(from: date)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "editVisitDate"){
            //Existing visit date
            let editVC:EditVisitDateVC =  segue.destination as! EditVisitDateVC
            editVC.hidesBottomBarWhenPushed = true
            editVC.summit = self.summit
            editVC.index = (self.visitList.indexPathForSelectedRow! as NSIndexPath).row
        }
        else if(segue.identifier == "addVisitDate"){
            //New visit date
            loggVisit()
            let editVC:EditVisitDateVC =  segue.destination as! EditVisitDateVC
            editVC.hidesBottomBarWhenPushed = true
            editVC.summit = self.summit
            editVC.index = summit!.getVisitCount() - 1
            editVC.newItem = true
        }
        
    }
    
    //slide selected and click delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.delete){
            summitMgr.removeVisit(summit!.name, index: (indexPath as NSIndexPath).row)
            visitList.reloadData()
            updateSummitlabel()
        }
    }


}
