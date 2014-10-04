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

    var summit:Summit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = summit!.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        visitList.reloadData()
    }
    
    //Button clicked
    func loggVisit() {
        
        summitMgr.addVisit(summit!.name)
        
        visitList.reloadData()
    }
    
    //This is for the tableview actions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summit!.getVisitCount()
    }
    
    //draw a item in the list
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:VisitCell = tableView.dequeueReusableCellWithIdentifier("VisitCell") as VisitCell
        
        if(summit!.visitdates.count > 0){
            
            let date:NSDate = summit!.visitdates[indexPath.row].visitDate
            //let date:NSDate = summitMgr.getVisitDateByIndex(summit!.name, index: indexPath.row)
        
            let formatter = NSDateFormatter()
            formatter.dateStyle = .FullStyle
            cell.visitDate = date
            cell.textLabel?.text = formatter.stringFromDate(date)
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "editVisitDate"){
            //Existing visit date
            var editVC:EditVisitDateVC =  segue.destinationViewController as EditVisitDateVC
            editVC.hidesBottomBarWhenPushed = true
            editVC.summit = self.summit
            editVC.index = self.visitList.indexPathForSelectedRow()!.row
        }
        else if(segue.identifier == "addVisitDate"){
            //New visit date
            loggVisit()
            var editVC:EditVisitDateVC =  segue.destinationViewController as EditVisitDateVC
            editVC.hidesBottomBarWhenPushed = true
            editVC.summit = self.summit
            editVC.index = summit!.getVisitCount() - 1
            editVC.newItem = true
        }
        
    }
    
    //slide selected and click delete
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            summitMgr.removeVisit(summit!.name, index: indexPath.row)
            visitList.reloadData()
        }
    }


}
