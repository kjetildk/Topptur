//
//  ImportantAlertViewController.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 21.06.2020.
//  Copyright © 2020 publisoft. All rights reserved.
//

import UIKit

class ImportantAlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var alertTitle = String()
    var alertMessage = String()
    
    var buttonAction: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = alertTitle
        self.messageLabel.text = alertMessage
    }

    @IBAction func okButton(_ sender: Any) {
        
        dismiss(animated: true)
        
        buttonAction?()
    }
}
