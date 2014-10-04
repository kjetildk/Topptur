//
//  PhotoThumbnail.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 26.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit

class PhotoThumbnail: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    func setThumbnailImage(thumbnailImage: UIImage){
        self.imgView.image = thumbnailImage
    }
    
}
