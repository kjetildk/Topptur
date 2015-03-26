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
            Summit(id:1,name: "Sukkertoppen",height: 370,distance:0,winter:true,terrain: .Hilly,difficulty: .Medium,sutibleFor: .MostPeople,
                latitude: 78.21063,longitude: 15.65408,description:NSLocalizedString("SUKKERTOPPEN_DESC",comment:"Sukkertoppen"),
                imageSummit:UIImage(named: "Sukkertoppen.jpg")!,imageGraph:UIImage(named: "SukkertoppenGraf.png")!))
        summits.append(
            Summit(id:2,name: "Sarkofagen",height: 490,distance:0,winter:true,terrain: .Hilly,difficulty: .Medium,sutibleFor: .MostPeople,
                latitude: 78.1902,longitude: 15.56362,description:NSLocalizedString("SARKOFAGEN_DESC",comment:"Sarkofagen"),
                imageSummit:UIImage(named: "Sarkofagen.jpg")!,imageGraph:UIImage(named: "SarkofagenGraf.png")!))
        summits.append(
            Summit(id:3,name: "Trollsteinen",height: 850,distance:0,winter:true,terrain: .Hilly,difficulty: .MoreDemanding,sutibleFor: .MostPeople,
                latitude: 78.1685,longitude: 15.58627,description:NSLocalizedString("TROLLSTEINEN_DESC",comment:"Trollsteinen"),
                imageSummit:UIImage(named: "Trollstein.jpg")!,imageGraph:UIImage(named: "TrollsteinGraf.png")!))
        summits.append(
            Summit(id:4,name: "Nordenskiöld",height: 1050,distance:0,winter:true,terrain: .Hilly,difficulty: .Intensive,sutibleFor: .MostPeople,
                latitude: 78.17903,longitude: 15.42458,description:NSLocalizedString("NORDENSKJOLD_DESC",comment:"Nordenskiöld"),
                imageSummit:UIImage(named: "Nordenskjold.jpg")!,imageGraph:UIImage(named: "NordenskjoldGraf.png")!))
        summits.append(
            Summit(id:5,name: "Varden i Bolterdalen",height: 175,distance:0,winter:true,terrain: .Flat,difficulty: .Easy,sutibleFor: .Child,
                latitude: 78.13518,longitude: 16.00832,description:NSLocalizedString("BOLTERDALEN_DESC",comment:"Varden i Bolterdalen"),
                imageSummit:UIImage(named: "VardenBolterdalen.jpg")!,imageGraph:UIImage(named: "VardenBolterdalenGraf.png")!))
        summits.append(
            Summit(id:6,name: "Morena ved Longyearbreen",height: 246,distance:0,winter:false,terrain: .Flat,difficulty: .Easy,sutibleFor: .Child,
                latitude: 78.19205,longitude: 15.53917,description:NSLocalizedString("MORENA_DESC",comment:"Morena ved Longyearbreen"),
                imageSummit:UIImage(named: "MorenaLongyearbreen.jpg")!,imageGraph:UIImage(named: "MorenaLongyearbreenGraf.png")!))
        summits.append(
            Summit(id:7,name: "Varden i Bjørndalen",height: 89,distance:0,winter:false,terrain: .Flat,difficulty: .Easy,sutibleFor: .Child,
                latitude: 78.2163,longitude: 15.34592,description:NSLocalizedString("BJORNDALEN_DESC",comment:"Varden i Bjørndalen"),
                imageSummit:UIImage(named: "VardenBjorndalen.jpg")!,imageGraph:UIImage(named: "VardenBjorndalenGraf.png")!))
        summits.append(
            Summit(id:8,name: "Sneheim",height: 545,distance:0,winter:false,terrain: .Hilly,difficulty: .MoreDemanding,sutibleFor: .MostPeople,
                latitude: 78.25927,longitude: 15.76723,description:NSLocalizedString("SNEHEIM_DESC",comment:"Sneheim"),
                imageSummit:UIImage(named: "Sneheim.jpg")!,imageGraph:UIImage(named: "SneheimGraf.png")!))
        summits.append(
            Summit(id:9,name: "Varden ved Platåberget",height: 326,distance:0,winter:true,terrain: .Hilly,difficulty: .Easy,sutibleFor: .MostPeople,
                latitude: 78.2185,longitude: 15.59543,description:NSLocalizedString("PLATAABERGET_DESC",comment:"Varden ved Platåberget"),
                imageSummit:UIImage(named: "VardenPlataaberget.jpg")!,imageGraph:UIImage(named: "VardenPlataabergetGraf.png")!))
        summits.append(
            Summit(id:10,name: "Fuglefjella",height: 437,distance:0,winter:false,terrain: .Hilly,difficulty: .MoreDemanding,sutibleFor: .MostPeople,
                latitude: 78.21647,longitude: 15.27997,description:NSLocalizedString("FUGLEFJELLA_DESC",comment:"Fuglefjella"),
                imageSummit:UIImage(named: "Fuglefjella.jpg")!,imageGraph:UIImage(named: "FuglefjellaGraf.png")!))
        summits.append(
            Summit(id:11,name: "Lindholmhøgda",height: 361,distance:0,winter:false,terrain: .Hilly,difficulty: .Medium,sutibleFor: .Child,
                latitude: 78.20385,longitude: 15.7028,description:NSLocalizedString("LINDHOLMHOGDA_DESC",comment:"Lindholmhøgda"),
                imageSummit:UIImage(named: "Lindholmhogda.jpg")!,imageGraph:UIImage(named: "LindholmhogdaGraf.png")!))
        summits.append(
            Summit(id:12,name: "Blomsterdalshøgda",height: 317,distance:0,winter:false,terrain: .Hilly,difficulty: .Medium,sutibleFor: .Child,
                latitude: 78.22653,longitude: 15.53115,description:NSLocalizedString("BLOMSTERDALSHOGDA_DESC",comment:"Blomsterdalshøgda"),
                imageSummit:UIImage(named: "Blomsterdalshogda.jpg")!,imageGraph:UIImage(named: "BlomsterdalshogdaGraf.png")!))
        summits.append(
            Summit(id:13,name: "Endalen",height: 190,distance:0,winter:true,terrain: .Flat,difficulty: .Easy,sutibleFor: .Child,
                latitude: 78.16238,longitude: 15.67135,description:NSLocalizedString("ENDALEN_DESC",comment:"Endalen"),
                imageSummit:UIImage(named: "Endalen.jpg")!,imageGraph:UIImage(named: "EndalenGraf.png")!))
        summits.append(
            Summit(id:14,name: "Varden på Sverdruphamaren",height: 456,distance:0,winter:false,terrain: .Hilly,difficulty: .Medium,sutibleFor: .MostPeople,
                latitude: 78.20413,longitude: 15.55447,description:NSLocalizedString("SVERDRUPHAMAREN_DESC",comment:"Varden på Sverdruphamaren"),
                imageSummit:UIImage(named: "Sverdruphammaren.jpg")!,imageGraph:UIImage(named: "SverdruphammarenGraf.png")!))
        summits.append(
            Summit(id:15,name: "Gruvefjellet",height: 467,distance:0,winter:false,terrain: .Hilly,difficulty: .Medium,sutibleFor: .MostPeople,
                latitude: 78.2041,longitude: 15.6292,description:NSLocalizedString("GRUVEFJELLET_DESC",comment:"Gruvefjellet"),
                imageSummit:UIImage(named: "dummy")!,imageGraph:UIImage(named: "VardenPlataabergetGraf.png")!))
        for index:Int in 0...(self.summits.count-1){
            if(summits[index].visitdates.count > 0){
                self.completed++
            }
        }
    }
    
    func indexByName(name:String) ->Int{
        
        var index:Int = 0
        
        for index in 0...(self.summits.count-1){
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
