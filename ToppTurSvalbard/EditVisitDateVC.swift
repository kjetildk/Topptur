//
//  EditVisitDateVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 08.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
//import Photos
//import MobileCoreServices

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class EditVisitDateVC: UIViewController , /*UITableViewController,*/ UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var visitDate:Date = Date()
    var index:Int = 0
    var newItem:Bool = false
    var summit:Summit?
    
    //var imagePicker:ImageVideoPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.summit!.name
        self.visitDate =  self.summit!.getVisitDate(index: self.index)
        
        //update the date picker
        self.datePicker.date = self.visitDate
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        self.selectedDate.text = formatter.string(from: self.visitDate)
        self.commentText.text = self.summit!.getVisitComment(index: self.index)
        
        self.commentText.delegate = self
        
        if(!self.newItem){
            //self.imgView.image = self.summit!.visitdates[self.index].photo
        }
        
        self.hideKeyboardWhenTappedAround()
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //view.addGestureRecognizer(tap)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    //Calls this function when the tap is recognized.
    /*func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        //self.commentText.endEditing(true)
        
        self.commentText.resignFirstResponder()
    }*/
    
    override func viewWillDisappear(_ animated: Bool) {
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.commentText.resignFirstResponder()
        
        return true
    }
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.commentText.endEditing(true)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n"
        {
            
            self.commentText.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }*/
    
//SELF ADDED FUNCTIONS
    
    
    /*func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.setContentOffset( CGPoint(x: 0, y: keyboardSize.height), animated: true)
            /*if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }*/
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.setContentOffset( CGPoint(x: 0, y: 0), animated: true)
            /*if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }*/
        //}
    }*/
    
    
    @IBAction func datePickerChanged(_ sender: AnyObject) {
        self.visitDate = sender.date!!
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        self.selectedDate.text = formatter.string(from: self.visitDate)
    }

    @IBAction func btnSave(_ sender: AnyObject) {
        
        //print("summitMgr.changeVisit(\(self.title), index:\(self.index), newdate:\(self.datePicker.date))")
        
        //update changes
        summitMgr.updateVisit(self.title!, comment:self.commentText.text!, index:self.index, newdate:self.datePicker.date, photo:nil)
        
        //End this view and return to previous view
        self.commentText.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCancel(_ sender: AnyObject) {
        
        if(self.newItem){
            summitMgr.removeVisit(self.title!, index:self.index)
        }
        
        //End this view and return to previous view
        self.commentText.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    
}
