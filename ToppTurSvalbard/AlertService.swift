//
//  AlertService.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 21.06.2020.
//  Copyright © 2020 publisoft. All rights reserved.
//

import UIKit

class AlertService{
    
    func alert(title: String, message: String, completion: @escaping () -> Void) -> AlertViewController {
        
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        
        alertVC.alertTitle = title
        alertVC.alertMessage = message
        
        alertVC.buttonAction = completion
        
        return alertVC
    }
    
}
