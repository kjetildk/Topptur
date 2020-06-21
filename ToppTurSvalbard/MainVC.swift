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
    
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        
        self.navigationItem.title = NSLocalizedString("APPLICATION_TITLE",comment:"Toppturer på Svalbard")
        
        
        let launchCount = defaults.integer(forKey: "LaunchCount")
        if(launchCount == 5)
        {
            if(defaults.bool(forKey: "neverRate") != true)
            {
                showRateMe()
            }
            defaults.set(0, forKey: "LaunchCount")
        }
        
        let alertVC = alertService.alert(title: NSLocalizedString("ALERT_TITLE",comment:"title"), message: NSLocalizedString("ALERT_MESSAGE",comment:"message")){
            
            print("Joho!!!")
        }
        
        present(alertVC, animated: true)
    }

    func showRateMe() {
        
        let url = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=920734035&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
        //"https://itunes.apple.com/no/app/topptur/id920734035?l=nb&mt=8"
        
        let alert = UIAlertController(title: NSLocalizedString("SHOW_RATE_ME_1",comment:"Rate us"), message: NSLocalizedString("SHOW_RATE_ME_2",comment:"Rate us"), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("SHOW_RATE_ME_3",comment:"Rate us"), style: UIAlertAction.Style.default, handler: { alertAction in
            UIApplication.shared.open(URL(string : url)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("SHOW_RATE_ME_4",comment:"Rate us"), style: UIAlertAction.Style.default, handler: { alertAction in
            UserDefaults.standard.set(true, forKey: "neverRate")
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("SHOW_RATE_ME_5",comment:"Rate us"), style: UIAlertAction.Style.default, handler: { alertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = false
        table.reloadData()
    }
    
    //This is for the tableview actions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return summitMgr.summits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SummitCell = tableView.dequeueReusableCell(withIdentifier: "SummitCell") as! SummitCell
        
        //cell.initCell(summitMgr.summits[indexPath.row],completed: summitMgr.completed)
        
        let summit = summitMgr.summits[(indexPath as NSIndexPath).row]
        
        cell.summitName.text = summit.name
        cell.summitVisitCount.text = "\(summit.getVisitCount())/\(summitMgr.completed)"
        cell.summitHeight.text = summit.getHeight()
        cell.summitFirstVisitDate.text = summit.firstVisit()
        cell.summitImageView.image = summit.imageSummit

        if(summit.getVisitCount() == 0){
            cell.summitVisitCount.backgroundColor = UIColor.white
        }else{
            //set the green color
            //cell.summitVisitCount.backgroundColor = UIColor(red: 0.33, green: 0.88, blue: 0.0, alpha: 0.5)
            cell.summitVisitCount.backgroundColor = UIColor(red: 83/255, green: 215/255, blue: 105/255, alpha: 1)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showVisits"){
            
            //find the selected summit
            let indexPath = self.table.indexPathForSelectedRow!
            let summit = summitMgr.summits[(indexPath as NSIndexPath).row]
  
            let vc:UITabBarController = segue.destination as! UITabBarController
            
            //Add the correct summit to the controllers
            
            var navCon:UINavigationController = vc.viewControllers?[0] as! UINavigationController
            let detailVC:DetailVC =  navCon.topViewController as! DetailVC
            detailVC.summit = summit
            
//            navCon = vc.viewControllers?[1] as! UINavigationController
//            let descVC:DescriptionVC =  navCon.topViewController as! DescriptionVC
//            descVC.summit = summit
            
            navCon = vc.viewControllers?[1] as! UINavigationController
            let mapVC:MapVC =  navCon.topViewController as! MapVC
            mapVC.summit = summit
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
