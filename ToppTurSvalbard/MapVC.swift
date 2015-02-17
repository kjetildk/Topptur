//
//  MapVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 23.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var locationManager: CLLocationManager!
    
    var summit:Summit!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLocationManager()
        
        self.navigationItem.title = self.summit!.name
        
        //position
        var latitude:CLLocationDegrees =  self.summit!.latitude
        var longitude:CLLocationDegrees = self.summit!.longitude
        
        var latDelta:CLLocationDegrees = 0.05
        var longDelta:CLLocationDegrees = 0.05
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var summitLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        var theRegion:MKCoordinateRegion = MKCoordinateRegion(center: summitLocation, span: theSpan)
        
        //Display in map
        self.mapView.setRegion(theRegion, animated: true)
        
        //Make a pin for the loicaiton
        self.mapView.addAnnotation(SummitPointAnnotation(summit: self.summit!))
        
        //Add a overlay map in the view
        var tileOverlay = MKTileOverlay(URLTemplate: "")
        tileOverlay.canReplaceMapContent = true
        self.mapView.addOverlay(tileOverlay)
        
        //Load the track for this summit
        loadGPXTracks(summit.id.description)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        locationManager = CLLocationManager()
        locationManager.delegate = self
        //locationManager.locationServicesEnabled
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as CLLocation
            var coord = locationObj.coordinate
            
            //println(coord.latitude)
            //println(coord.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = NSLocalizedString("CURRENT_LOCATION_RESTRICTED_ACCESS",comment:"Restricted Access to location")
        case CLAuthorizationStatus.Denied:
            locationStatus = NSLocalizedString("CURRENT_LOCATION_USER_DENIED",comment:"User denied access to location")
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = NSLocalizedString("CURRENT_LOCATION_NOT_DETERMINED",comment:"Status not determined")
        default:
            locationStatus = NSLocalizedString("CURRENT_LOCATION_ALLOWED",comment:"Allowed to location Access")
            shouldIAllow = true
        }
        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    
    //For cusomiziong the annotations on the pins
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if !(annotation is MKPointAnnotation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "pin"
        
        var summitAnnotation = annotation as SummitPointAnnotation
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as?  MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            if(summitAnnotation.summit!.visited()){
                pinView!.pinColor = MKPinAnnotationColor.Green
            }
        }
        else {
            //we are re-using a view, update its annotation reference...
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if (overlay is MKPolyline) {
            var lineView:MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.blueColor()
            return lineView
        }
        
        return nil
    }

    func loadGPXTracks(filename:NSString){
        
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: "GPX")
        
        if (path == nil) {
            //the gpx file do not exist ... return
            return
        }
        
        let gpx:GPXRoot = GPXParser.parseGPXAtPath(path)
        
        let tracks = gpx.tracks as [GPXTrack]
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for oneTrack in tracks{
            pointsToUse.reserveCapacity(oneTrack.tracksegments.count)
            
            let segments = oneTrack.tracksegments as [GPXTrackSegment]
            
            for segment in segments {
                
                let trackpoints = segment.trackpoints as [GPXTrackPoint]
                
                for trackpoint in trackpoints{
                    
                    pointsToUse.append(CLLocationCoordinate2DMake( Double(trackpoint.latitude), Double(trackpoint.longitude)))
                }
            }
            
            //Add track to map
            let myPolyline:MKPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsToUse.count)
            self.mapView.addOverlay(myPolyline)
            
            //clean up before next track
            pointsToUse.removeAll(keepCapacity: false)
        }
    }

}
