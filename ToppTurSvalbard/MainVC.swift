//
//  MainVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 01.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //this is my table view
    @IBOutlet var table: UITableView!
    var summitName:String = "No Name"
    
    var imageCache = [String : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("APPLICATION_TITLE",comment:"Toppturer på Svalbard")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = false
        table.reloadData()
    }
    
    //This is for the tableview actions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return summitMgr.summits.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:SummitCell = tableView.dequeueReusableCellWithIdentifier("SummitCell") as SummitCell
        
        //cell.initCell(summitMgr.summits[indexPath.row],completed: summitMgr.completed)
        
        cell.summitName.text = summitMgr.summits[indexPath.row].name
        cell.summitVisitCount.text = "\(summitMgr.summits[indexPath.row].getVisitCount())/\(summitMgr.completed)"
        cell.summitHeight.text = summitMgr.summits[indexPath.row].getHeight()
        cell.summitFirstVisitDate.text = summitMgr.summits[indexPath.row].firstVisit()
        cell.summitImageView.image = summitMgr.summits[indexPath.row].imageSummit
//        cell.imageView.image = UIImage(named: "AppIcon72x72")
        
        if(summitMgr.getVisitCount(cell.summitName.text!) == 0){
            cell.summitVisitCount.backgroundColor = UIColor.whiteColor()
        }else{
            cell.summitVisitCount.backgroundColor = UIColor(red: 0.33, green: 0.88, blue: 0.0, alpha: 0.5)
        }
        
//        //CHACING AV BILDER!!!!
//        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
//        let urlString = "AppIcon72x72" //rowData["artworkUrl60"] as String
//
//        // Check our image cache for the existing key. This is just a dictionary of UIImages
//        //var image: UIImage? = self.imageCache.valueForKey(urlString) as? UIImage
//        var image = self.imageCache[urlString]
//
//        if( image == nil ) {
//            // If the image does not exist, we need to download it
//            var imgURL: NSURL = NSURL(string: urlString)
//
//            // Download an NSData representation of the image at the URL
//            let request: NSURLRequest = NSURLRequest(URL: imgURL)
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
//                if error == nil {
//                    image = UIImage(data: data)
//
//                    // Store the image in to our cache
//                    self.imageCache[urlString] = image
//                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
//                        cellToUpdate.imageView.image = image
//                    }
//                }
//                else {
//                    println("Error: \(error.localizedDescription)")
//                }
//            })
//
//        }
//        else {
//            dispatch_async(dispatch_get_main_queue(), {
//                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
//                    cellToUpdate.imageView.image = image
//                }
//            })
//        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showVisits"){
            
            //find the selected summit
            let indexPath = self.table.indexPathForSelectedRow()!
            let summit:Summit = summitMgr.summits[indexPath.row] as Summit
  
            var vc:UITabBarController = segue.destinationViewController as UITabBarController
            
            //Add the correct summit to the controllers
            
            var navCon:UINavigationController = vc.viewControllers?[0] as UINavigationController
            var detailVC:DetailVC =  navCon.topViewController as DetailVC
            detailVC.summit = summit
            
            navCon = vc.viewControllers?[1] as UINavigationController
            var descVC:DescriptionVC =  navCon.topViewController as DescriptionVC
            descVC.summit = summit
            
            navCon = vc.viewControllers?[2] as UINavigationController
            var mapVC:MapVC =  navCon.topViewController as MapVC
            mapVC.summit = summit
        }
    }
    
}
