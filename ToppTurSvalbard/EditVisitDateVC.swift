//
//  EditVisitDateVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 08.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import Photos
//import MobileCoreServices

class EditVisitDateVC: UITableViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var selectedDate: UILabel!
    
    var visitDate:NSDate = NSDate()
    var index:Int = 0
    var newItem:Bool = false
    var summit:Summit?
    
    var imagePicker:ImageVideoPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.summit!.name
        self.visitDate =  self.summit!.getVisitDate(self.index)
        
        //update the date picker
        self.datePicker.date = self.visitDate
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        
        self.selectedDate.text = formatter.stringFromDate(self.visitDate)
        
        if(!self.newItem){
            self.imgView.image = self.summit!.visitdates[self.index].photo
        }
    }

    override func viewWillAppear(animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//SELF ADDED FUNCTIONS
    
    @IBAction func datePickerChanged(sender: AnyObject) {
        self.visitDate = sender.date!!
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        
        self.selectedDate.text = formatter.stringFromDate(self.visitDate)
        
    }
    
    //Open the Topptur Album library
    @IBAction func btnPhotoAlbum(sender: AnyObject) {
        
        //var picker: UIImagePickerController = UIImagePickerController()
        //picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        //picker.delegate = self
        //picker.allowsEditing = false
        //self.presentViewController(picker, animated: true, completion: nil)
        
        //self.imagePicker = ImageVideoPicker(frame: self.view.frame, superVC: self) { (capturedImage) -> Void in
        self.imagePicker = ImageVideoPicker(frame: self.imgView.frame, superVC: self) { (capturedImage) -> Void in
            ///
            
            if let captureImage = capturedImage{
                //you did it.....
                
                //load new image for this visit
                self.imgView.image = captureImage
                
            }
            
        }
        
    }
    
    //Open the Camera
    @IBAction func btnCamera(sender: AnyObject) {
/*        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            //load the camera interface
            var picker: UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
            
        }else{
            //no camera available
            var alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }*/
    }
    
    @IBAction func btnSave(sender: AnyObject) {
        
        println("summitMgr.changeVisit(\(self.title), index:\(self.index), newdate:\(self.datePicker.date))")
        
        //update changes
        summitMgr.updateVisit(self.title!, index:self.index, newdate:self.datePicker.date, photo:self.imgView.image)
        
        //End this view and return to previous view
        self.view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnCancel(sender: AnyObject) {
        
        if(self.newItem){
            summitMgr.removeVisit(self.title!, index:self.index)
        }
        
        //End this view and return to previous view
        self.view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnExport(sender: AnyObject) {
        println("Export")
    }
    
    @IBAction func btnTrash(sender: AnyObject) {
        println("Trash")

    }
    
}
