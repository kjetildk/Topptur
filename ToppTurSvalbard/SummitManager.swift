//
//  SummitManager.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 01.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit

var summitMgr:SummitManager = SummitManager()

class SummitManager:NSObject {

    var summits:[Summit] = [Summit]()
    //var persistenceHelper:PersistenceHelper = PersistenceHelper()
    var completed:Int = 0
    
    override init() {
        super.init()
        
        summits.append(
            Summit(name: "Sukkertoppen",height: 370,distance:0,terrain: .Hilly,difficulty: .Medium,sutibleFor: .MostPeople,
                latitude: 78.21063,longitude: 15.65408,description:NSLocalizedString("SUKKERTOPPEN_DESC",comment:"Sukkertoppen"),
                image:UIImage(named: "Sukkertoppen.png")!))
        summits.append(
            Summit(name: "Sarkofagen",height: 490,distance:0,terrain: .Hilly,difficulty: .Medium,sutibleFor: .MostPeople,
                latitude: 78.1902,longitude: 15.56362,description:NSLocalizedString("SARKOFAGEN_DESC",comment:"Sarkofagen"),
                image:UIImage(named: "Sarkofagen.png")!))
        summits.append(
            Summit(name: "Trollsteinen",height: 850,distance:0,terrain: .Hilly,difficulty: .MoreDemanding,sutibleFor: .MostPeople,
                latitude: 78.1685,longitude: 15.58627,description:NSLocalizedString("TROLLSTEINEN_DESC",comment:"Trollsteinen"),
                image:UIImage(named: "Trollstein.png")!))
        summits.append(
            Summit(name: "Nordenskiöld",height: 1050,distance:0,terrain: .Hilly,difficulty: .Intensive,sutibleFor: .MostPeople,
                latitude: 78.17903,longitude: 15.42458,description:NSLocalizedString("NORDENSKJOLD_DESC",comment:"Nordenskiöld"),
                image:UIImage(named: "Nordenskjold.png")!))
        summits.append(
            Summit(name: "Varden i Bolterdalen",height: 175,distance:0,terrain: .Flat,difficulty: .Easy,sutibleFor: .Child,
                latitude: 78.13518,longitude: 16.00832,description:NSLocalizedString("BOLTERDALEN_DESC",comment:"Varden i Bolterdalen"),
                image:UIImage(named: "VardenBolterdalen.png")!))
        summits.append(
            Summit(name: "Morena ved Longyearbreen",height: 246,distance:0,terrain: .Flat,difficulty: .Easy,sutibleFor: .Child,
                latitude: 78.19205,longitude: 15.53917,description:NSLocalizedString("MORENA_DESC",comment:"Morena ved Longyearbreen"),
                image:UIImage(named: "MorenaLongyearbreen.png")!))
        summits.append(
            Summit(name: "Varden i Bjørndalen",height: 89,distance:0,terrain: .Flat,difficulty: .Easy,sutibleFor: .Child,
                latitude: 78.2163,longitude: 15.34592,description:NSLocalizedString("BJORNDALEN_DESC",comment:"Varden i Bjørndalen"),
                image:UIImage(named: "VardenBjorndalen.png")!))
        summits.append(
            Summit(name: "Sneheim",height: 545,distance:0,terrain: .Hilly,difficulty: .MoreDemanding,sutibleFor: .MostPeople,
                latitude: 78.25927,longitude: 15.76723,description:NSLocalizedString("SNEHEIM_DESC",comment:"Sneheim"),
                image:UIImage(named: "Sneheim.png")!))
        summits.append(
            Summit(name: "Varden ved Platåberget",height: 326,distance:0,terrain: .Hilly,difficulty: .Easy,sutibleFor: .MostPeople,
                latitude: 78.2185,longitude: 15.59543,description:NSLocalizedString("PLATAABERGET_DESC",comment:"Varden ved Platåberget"),
                image:UIImage(named: "VardenPlataaberget.png")!))
        summits.append(
            Summit(name: "Fuglefjella",height: 437,distance:0,terrain: .Hilly,difficulty: .MoreDemanding,sutibleFor: .MostPeople,
                latitude: 78.21647,longitude: 15.27997,description:NSLocalizedString("FUGLEFJELLA_DESC",comment:"Fuglefjella"),
                image:UIImage(named: "Fuglefjella.png")!))
        summits.append(
            Summit(name: "Lindholmhøgda",height: 361,distance:0,terrain: .Hilly,difficulty: .Medium,sutibleFor: .Child,
                latitude: 78.20385,longitude: 15.7028,description:NSLocalizedString("LINDHOLMHOGDA_DESC",comment:"Lindholmhøgda"),
                image:UIImage(named: "Lindholmhogda.png")!))
        summits.append(
            Summit(name: "Blomsterdalshøgda",height: 317,distance:0,terrain: .Hilly,difficulty: .Medium,sutibleFor: .Child,
                latitude: 78.22653,longitude: 15.53115,description:NSLocalizedString("BLOMSTERDALSHOGDA_DESC",comment:"Blomsterdalshøgda"),
                image:UIImage(named: "Blomsterdalshogda.png")!))
        summits.append(
            Summit(name: "Endalen",height: 190,distance:0,terrain: .Flat,difficulty: .Easy,sutibleFor: .Child,
                latitude: 78.16238,longitude: 15.67135,description:NSLocalizedString("ENDALEN_DESC",comment:"Endalen"),
                image:UIImage(named: "Endalen.png")!))
        summits.append(
            Summit(name: "Varden på Sverdruphamaren",height: 456,distance:0,terrain: .Hilly,difficulty: .Medium,sutibleFor: .MostPeople,
                latitude: 78.20413,longitude: 15.55447,description:NSLocalizedString("SVERDRUPHAMAREN_DESC",comment:"Varden på Sverdruphamaren"),
                image:UIImage(named: "Sverdruphammaren.png")!))
        
        for index:Int in 0...13{
            if(summits[index].visitdates.count > 0){
                self.completed++
            }
        }
    }
    
    func indexByName(name:String) ->Int{
        
        var index:Int = 0
        
        for index in 0...13{
            if( summits[index].name == name){
                return index
            }
        }
        
        return index
    }
    
    func firstVisit(name:String)->String{
        
        var firstVisitDate = NSLocalizedString("SUMMIT_FIRST_VISIT",comment:"Ikke besøkt")
        
        if(self.summits[indexByName(name)].visitdates.count > 0){
            
            let date = self.summits[indexByName(name)].visitdates[0].visitDate
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .LongStyle
            //formatter.timeStyle = .MediumStyle
            formatter.stringFromDate(date)
            
            firstVisitDate = formatter.stringFromDate(date)
        }
        
        return firstVisitDate
    }
    
    func getVisitCount(name:String) ->Int{
        return self.summits[indexByName(name)].visitdates.count
    }
    
    func getVisitDateByIndex(name:String, index:Int) ->NSDate{
        return self.summits[indexByName(name)].visitdates[index].visitDate
    }
    
    func addVisit(name:String){
        
        //Add a current date to summit
        if( self.summits[indexByName(name)].addVisit(NSDate()) == 1){
            //update the completed for the first visit
            self.completed++
        }
    }
    
    func removeVisit(name:String, index:Int) {
        
        //Remove date form visits for this summit
        if( self.summits[indexByName(name)].removeVisit(index) == 0){
            //update the completed
            self.completed--
        }
    }
    
    //Change the date and photo (if any) for this visit
    func updateVisit(name:String, index:Int, newdate:NSDate, photo:UIImage?){
        
        self.summits[indexByName(name)].updateVisit(index,newdate: newdate)
        if(photo != nil){
            //self.summits[indexByName(name)].updatePhotoAtIndex(index, photo: photo!)
        }
    }
    
}
