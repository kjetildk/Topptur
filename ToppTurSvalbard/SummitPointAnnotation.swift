//
//  SummitPointAnnotation.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 25.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import MapKit

class SummitPointAnnotation: MKPointAnnotation {
   
    var summit:Summit!
 
    init(summit:Summit){
        super.init()
        
        self.summit = summit
        
        var summitLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: summit.latitude, longitude: summit.longitude)
        
        self.coordinate = summitLocation
        self.title = summit.name
        self.subtitle = "\(summit.height) moh"
        
    }
    
}
