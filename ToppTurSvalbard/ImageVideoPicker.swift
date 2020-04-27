//
//  ImageVideoPicker.swift
//  HelloSwift
//
//  Created by Mohd Kamarshad on 10/09/14.
//  Copyright (c) 2014 Mohd Kamarshad. All rights reserved.
//

import UIKit


class ImageVideoPicker: UIView,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK:- PROPERTIES
    
    var originVC:UIViewController?
    
    typealias imageCaptureClosure = (_ capturedImage:UIImage?)->Void
    
    var imageCompletionClosure:imageCaptureClosure?
    
    
    //MARK: - View Life Cycle Methods
    
    init(frame:CGRect, superVC originVC:UIViewController, completionBlock:imageCaptureClosure){
        self.originVC = originVC
        self.imageCompletionClosure = completionBlock
        
        super.init(frame:frame)
        
        //Display Capture Options to the User....
        self.showImagePickerActionSheet()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        self.originVC = nil
        self.imageCompletionClosure = nil
        super.init(coder: aDecoder)
        
    }
    
    
    //MARK:- Private Methods
    
    func showImagePickerActionSheet(){
        let actionSheet = UIAlertController(title: " ", message:NSLocalizedString("TAKE_PICTURE",comment:"Take Picture"), preferredStyle: UIAlertControllerStyle.actionSheet)
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("CANCEL",comment:"Cancel"), style: UIAlertActionStyle.cancel, handler:handleCancelAction))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("CAMERA",comment:"Camera"), style: UIAlertActionStyle.default, handler:handleCameraAction))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("PHOTO_LIBRARY",comment:"Photo library"), style: UIAlertActionStyle.destructive, handler:handlePhotoLibAction))
        
        self.originVC!.present(actionSheet, animated: true, completion: nil)
    }
    
    fileprivate func handleCancelAction(_ alertAction:UIAlertAction!){
        self.imageCompletionClosure!(nil)
        self.originVC!.dismiss(animated: true, completion:nil)
        
    }
    
    fileprivate func handleCameraAction(_ alertAction:UIAlertAction!){
        
        self.startCameraControllerFromViewController(self.originVC, usingDelegate:self)
    }
    
    fileprivate func handlePhotoLibAction(_ alertAction:UIAlertAction!){
        self.startPhotoLibraryControllerFromViewController(self.originVC, usingDelegate:self)
    }
    
    fileprivate func startPhotoLibraryControllerFromViewController<T>(_ controller:UIViewController?,
        usingDelegate delegate: T?)->Bool where T: UINavigationControllerDelegate,T: UIImagePickerControllerDelegate{
            
            if((UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == false)||(controller == nil)||(delegate == nil)){
                return false
                
            }
            
            let libraryUI = UIImagePickerController()
            libraryUI.delegate = delegate
            controller!.present(libraryUI, animated: true, completion:nil)
            
            return true
    }
    
    
    
    fileprivate func startCameraControllerFromViewController<T>(_ controller:UIViewController?, usingDelegate delegate:T?)->Bool where T: UINavigationControllerDelegate,T: UIImagePickerControllerDelegate
    {
        if((UIImagePickerController.isSourceTypeAvailable(.camera) == false)||(controller == nil)||(delegate == nil)){
            return false
            
        }
        
        let cameraUI = UIImagePickerController()
        cameraUI.delegate = delegate
        cameraUI.sourceType = .camera
        // Displays a control that allows the user to choose picture or
        // movie capture, if both are available:
        cameraUI.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        
        // Hides the controls for moving & scaling pictures, or for
        // trimming movies. To instead show the controls, use YES.
        cameraUI.allowsEditing = false
        cameraUI.delegate = delegate
        
        controller!.present(cameraUI, animated: true, completion:nil)
        
        return true
    }
    
    //MARK: - UIImagePickerControllerDelegate delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if (self.imageCompletionClosure != nil)
        {
            self.imageCompletionClosure!(tempImage)
            
        }
        picker.dismiss(animated: true,completion:nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController)
    {
        if (self.imageCompletionClosure != nil)
        {
            self.imageCompletionClosure!(nil)
        }
        
        picker.dismiss(animated: true,completion:nil)
    }
}
