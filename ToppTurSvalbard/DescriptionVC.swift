//
//  DescriptionVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 23.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {

    @IBOutlet weak var summitImage: UIImageView!
    @IBOutlet weak var summitDescription: UITextView!
    @IBOutlet weak var summitTerrain: UILabel!
    @IBOutlet weak var summitDifficulty: UILabel!
    @IBOutlet weak var summitSutibleFor: UILabel!
    @IBOutlet weak var summitHeight: UILabel!
    @IBOutlet weak var summitWinterImage: UIImageView!
    
    var summit:Summit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = self.summit!.name
        
        self.summitDescription.text = self.summit!.desc
        self.summitDescription.scrollRangeToVisible(0)
        
        self.summitImage.image = self.summit!.imageGraph
        self.summitHeight.text = self.summit!.getHeight()
        
        if(self.summit!.winter == false)
        {
            self.summitWinterImage.hidden = true
        }
        //self.summitTerrain.text = self.summit!.getTerrain()
        //self.summitDifficulty.text = self.summit!.getDifficulty()
        //self.summitSutibleFor.text = self.summit!.getSutibleFor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
