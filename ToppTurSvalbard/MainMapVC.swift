//
//  MainMapVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 25.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainMapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLocationManager()
        
        self.navigationItem.title = NSLocalizedString("APPLICATION_TITLE",comment:"Toppturer på Svalbard")
        
        //position the main map
        var latDelta:CLLocationDegrees = 0.32
        var longDelta:CLLocationDegrees = 0.32
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var mapCenter:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 78.2, longitude: 15.6)
        var theRegion:MKCoordinateRegion = MKCoordinateRegion(center: mapCenter, span: theSpan)
        
        //Display in map
        self.mapView.setRegion(theRegion, animated: true)
        
        
        //Add all the summits as pins
        for summit:Summit in summitMgr.summits {
            //Make a pin for the loicaiton
            self.mapView.addAnnotation(SummitPointAnnotation(summit: summit))
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.hidesBarsOnTap = true
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
            
            println(coord.latitude)
            println(coord.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
            
        switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
