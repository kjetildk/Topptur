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
    var locationStatus : String = "Not Started"
    var locationManager: CLLocationManager!
//    var totalDistance : CLLocationDistance = 0
//    var oldLocation : CLLocation! = nil
//    var myLocations: [CLLocation] = []
//    var directionsResponse = MKDirectionsResponse()
    
    var summit:Summit!
    
    //Wrapper class for tracker line
//    class TrackerPolyline : MKPolyline {
    
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLocationManager()
        
        self.navigationItem.title = self.summit!.name
        
        //position
        let latitude:CLLocationDegrees =  self.summit!.latitude
        let longitude:CLLocationDegrees = self.summit!.longitude
        
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        
        let theSpan:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let summitLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let theRegion:MKCoordinateRegion = MKCoordinateRegion(center: summitLocation, span: theSpan)
        
        //Display in map
        self.mapView.setRegion(theRegion, animated: true)
        
        //Make a pin for the loicaiton
        self.mapView.addAnnotation(SummitPointAnnotation(summit: self.summit!))
        
        //Add a overlay map in the view
 //       let tileOverlay = MKTileOverlay(urlTemplate: "")
//        tileOverlay.canReplaceMapContent = true
//        self.mapView.add(tileOverlay)
        
        //Load the track for this summit
//        loadGPXTracks(summit.id.description as NSString)
        
        /*let request:MKDirectionsRequest = MKDirectionsRequest()
        
        // source and destination are the relevant MKMapItems
        let placeSource = MKPlacemark(coordinate: mapView.userLocation.coordinate, addressDictionary: nil)
        request.source = MKMapItem(placemark: placeSource)
        
        let placeDestination = MKPlacemark(coordinate: summitLocation, addressDictionary: nil)
        request.destination = MKMapItem(placemark: placeDestination)
        
        // Specify the transportation type
        request.transportType = MKDirectionsTransportType.walking;
        
        // If you're open to getting more than one route,
        // requestsAlternateRoutes = true; else requestsAlternateRoutes = false;
        request.requestsAlternateRoutes = true*/
        
        //let directions = MKDirections(request: request)
        
        //directions.calculate (completionHandler: {
        //    (response: MKDirectionsResponse?, error: NSError?) in
            
        //    if error == nil {
        //        self.directionsResponse = response!
        //    }
        //} as! MKDirectionsHandler)
        
//        let route = directionsResponse.routes[currentRoute] as MKRoute
//        let distance = route.distance
//        let seconds = route.expectedTravelTime
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDistance(){
        //distanceLabel.text = totalDistance.description
        
        //println(totalDistance.description)
    }
    
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.activityType = .fitness
        
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        
        if (!self.seenError) {
            self.seenError = true
//            print(error, terminator: "")
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
        
        /*if(overlay is TrackerPolyline) {
         let lineView:MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
         lineView.strokeColor = UIColor.red
         lineView.lineWidth = 3
         return lineView
         }
         else*/
        
        if (overlay is MKPolyline) {
            let lineView:MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.blue
            lineView.lineWidth = 4
            return lineView
        }
        
        return MKOverlayRenderer()
    }
    
    /*@IBAction func showActionSheet(_ sender: AnyObject) {
        
        // 1
        let optionMenu = UIAlertController(title: nil, message: NSLocalizedString("TRACKER_FOCUS",comment:"Fokuser på:"), preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: NSLocalizedString("TRACKER_MY_POSITION",comment:"Min posisjon"), style: .default, handler: {
            (alert: UIAlertAction) -> Void in
            self.locationManager.startUpdatingLocation()
        })
        let saveAction = UIAlertAction(title: self.summit.name, style: .default, handler: {
            (alert: UIAlertAction) -> Void in
            
            self.locationManager.stopUpdatingLocation()
            
            let summitLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: self.summit!.latitude, longitude: self.summit!.longitude)
            self.mapView.setCenter(summitLocation, animated: true)
        })
        
        //
        let cancelAction = UIAlertAction(title: "Avbryt", style: .cancel, handler: {
            (alert: UIAlertAction) -> Void in
            print("Avbryt")
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
    }*/
    
    
    
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //save my location
        myLocations.append(locations[0] )
        
  /*      if (locationFixAchieved == false) {
            locationFixAchieved = true
            //This is the first time!
            oldLocation = locations.first as? CLLocation
        }*/

        let spanX = 0.007
        let spanY = 0.007
        let newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(newRegion, animated: true)
        
        if (myLocations.count > 1){
            let sourceIndex = myLocations.count - 1
            let destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            let polyline = TrackerPolyline(coordinates: &a, count: a.count)
            mapView.add(polyline)
        }*/
        
/*        if let firstLocation = locations.first as? CLLocation
        {
            mapView.setCenterCoordinate(firstLocation.coordinate, animated: true)
            
            let region = MKCoordinateRegionMakeWithDistance(firstLocation.coordinate, 1000, 1000)
            mapView.setRegion(region, animated: true)
            
            if firstLocation != oldLocation {
                let delta: CLLocationDistance = firstLocation.distanceFromLocation(oldLocation)
                totalDistance += delta
                updateDistance()
            }
            oldLocation = firstLocation
        }
*/

//    }
    
    

}
