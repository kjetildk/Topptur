//
//  ViewPhoto.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 26.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import Photos

class ViewPhoto: UIViewController {

    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var index: Int = 0
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func btnCancel(sender: AnyObject) {
        println("Cancel")
        //return to previous view without doing anything :-)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnExport(sender: AnyObject) {
        println("Export")
    }
    
    @IBAction func btnTrash(sender: AnyObject) {
        println("Trash")
        
        let alert = UIAlertController(title: "Delete Image", message: "Are you sure you want to delete this image?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: {(alertAction)in
            //delete image
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let request = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
                request.removeAssets([self.photosAsset[self.index]])
                }, completionHandler: {(success, error)in
                    
                    NSLog("\nDelete Image -> %@", (success ? "Success!": error))
                    alert.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
                    if(self.photosAsset.count == 0){
                        //no photos left
                        self.imgView.image = nil
                        println("No images left!!!")
                        //!!POP TO ROOT VIEW CONTROLLER
                    }
                    if(self.index >= self.photosAsset.count){
                        self.index = self.photosAsset.count - 1
                    }
                    self.displayPhoto()
                })
            }))
        alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: {(alertAction)in
            //do not delete image
            alert.dismissViewControllerAnimated(true, completion: nil)
            }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true
        
        displayPhoto()
    }
    
    func displayPhoto(){
        let imageManager = PHCachingImageManager.defaultManager()
        var ID = imageManager.requestImageForAsset(self.photosAsset[self.index] as PHAsset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill, options: nil) {
                    image, info in
                    self.imgView.image = image
                }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
