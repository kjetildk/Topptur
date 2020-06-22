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
    @IBOutlet weak var summitSummerImage: UIImageView!
    
    var target:Summit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = self.target!.name
        self.summitDescription.text = self.target!.desc
        self.summitDescription.scrollRangeToVisible(NSRange(location: summitDescription.text.count, length: 0))
        self.summitHeight.text = self.target!.getHeight()
        
//        self.summitImage.image = self.summit!.imageGraph
//
//        if(self.summit!.winter == false)
//        {
//            self.summitWinterImage.isHidden = true
//        }
//
//        if(self.summit!.summer == false)
//        {
//            self.summitSummerImage.isHidden = true
//        }
        
        //self.summitTerrain.text = self.summit!.getTerrain()
        //self.summitDifficulty.text = self.summit!.getDifficulty()
        //self.summitSutibleFor.text = self.summit!.getSutibleFor()
        
        //view.backgroundColor = UIColor.darkGrayColor()
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
