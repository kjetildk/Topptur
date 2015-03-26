//
//  NewMap.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 24.02.15.
//  Copyright (c) 2015 publisoft. All rights reserved.
//

import UIKit
import MapKit
import ArcGIS

class NewMapVC : UIViewController, AGSMapViewLayerDelegate {

    @IBOutlet weak var mapView: AGSMapView!
    
    let clientID = "H5MJzDsYix5Qxgbz"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("APPLICATION_TITLE",comment:"Toppturer på Svalbard")
        
        // Set the client ID
        var error:NSError? = nil
        let clientID = self.clientID
        AGSRuntimeEnvironment.setClientID(clientID, error: &error)
        if error != nil{
            // We had a problem using our client ID
            println("Error using client ID : \(error?.localizedDescription)")
        }
        
        //Add a basemap tiled layer
        let url = NSURL(string: "http://geodata.npolar.no/arcgis/rest/services/Basisdata/NP_Basiskart_Svalbard_WMTS_25833/MapServer")
        let tiledLayer = AGSTiledMapServiceLayer(URL: url)
        self.mapView.addMapLayer(tiledLayer, withName: "Basemap Tiled Layer")
        
        
        
        
        
        //Set the map view's layer delegate
        self.mapView.layerDelegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: map view layer delegate methods
    
    func mapViewDidLoad(mapView: AGSMapView!) {
        //do something now that the map is loaded
        //for example, show the current location on the map
        mapView.locationDisplay.startDataSource()
    }
    
}
