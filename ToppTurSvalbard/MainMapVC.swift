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
    var locationStatus : String = "Not Started"
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLocationManager()
        
        self.navigationItem.title = NSLocalizedString("APPLICATION_TITLE",comment:"Toppturer på Svalbard")
        
        //position the main map
        let latDelta:CLLocationDegrees = 0.32
        let longDelta:CLLocationDegrees = 0.32
        let theSpan:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let mapCenter:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 78.2, longitude: 15.63)
        let theRegion:MKCoordinateRegion = MKCoordinateRegion(center: mapCenter, span: theSpan)
        
        //Display in map
        self.mapView.setRegion(theRegion, animated: true)
        
        //Add all the summits as pins
        for summit:Summit in summitMgr.summits {
            //Make a pin for the loicaiton
            self.mapView.addAnnotation(SummitPointAnnotation(summit: summit))
        }
        
        //loadGPXTracks("Topptur")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.hidesBarsOnTap = true
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        
        if (seenError == false) {
            seenError = true
//            print(error.localizedDescription)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
//            let locationArray = locations as NSArray
//            let locationObj = locationArray.lastObject as! CLLocation
//            let coord = locationObj.coordinate
            
//            print(coord.latitude)
//            print(coord.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var shouldIAllow = false
            
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = NSLocalizedString("CURRENT_LOCATION_RESTRICTED_ACCESS",comment:"Restricted Access to location")
        case CLAuthorizationStatus.denied:
            locationStatus = NSLocalizedString("CURRENT_LOCATION_USER_DENIED",comment:"User denied access to location")
        case CLAuthorizationStatus.notDetermined:
            locationStatus = NSLocalizedString("CURRENT_LOCATION_NOT_DETERMINED",comment:"Status not determined")
        default:
            locationStatus = NSLocalizedString("CURRENT_LOCATION_ALLOWED",comment:"Allowed to location Access")
            shouldIAllow = true
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "LabelHasbeenUpdated"), object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    
    //For cusomiziong the annotations on the pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "pin"
        
        let summitAnnotation = annotation as! SummitPointAnnotation
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as?  MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            if(summitAnnotation.summit!.visited()){
                pinView!.pinTintColor = MKPinAnnotationView.greenPinColor()
            }
            
        }
        else {
            //we are re-using a view, update its annotation reference...
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            
            let lineView:MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.blue
            return lineView
            
        }
        
        return MKPolylineRenderer()
    }
    
//    func loadGPXTracks(_ filename:NSString){
    
        /*let gpx:GPXRoot = GPXParser.parseGPX(atPath: Bundle.main.path(forResource: filename as String, ofType: "GPX")!)
        
        let tracks = gpx.tracks as! [GPXTrack]
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for oneTrack in tracks{
            pointsToUse.reserveCapacity(oneTrack.tracksegments.count)
            
            let segments = oneTrack.tracksegments as! [GPXTrackSegment]
            
            for segment in segments {
                
                let trackpoints = segment.trackpoints as! [GPXTrackPoint]
        
                for trackpoint in trackpoints{
                   
                    pointsToUse.append(CLLocationCoordinate2DMake( Double(trackpoint.latitude), Double(trackpoint.longitude)))
                }
            }
            
            //Add track to map
            let myPolyline:MKPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsToUse.count)
            self.mapView.add(myPolyline)
            
            //clean up before next track
            pointsToUse.removeAll(keepingCapacity: false)
        }*/
//    }
}
