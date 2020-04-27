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
    var completed:Int = 0
    
    override init() {
        super.init()
        
        summits.append(
            Summit(id:1,name: "Sukkertoppen",height: 370,distance:0,winter:true,terrain: .hilly,difficulty: .medium,sutibleFor: .mostPeople,
                latitude: 78.21063,longitude: 15.65408,description:NSLocalizedString("SUKKERTOPPEN_DESC",comment:"Sukkertoppen"),
                imageSummit:UIImage(named: "Sukkertoppen.jpg")!,imageGraph:UIImage(named: "SukkertoppenGraf.png")!))
        summits.append(
            Summit(id:2,name: "Sarkofagen",height: 490,distance:0,winter:true,terrain: .hilly,difficulty: .medium,sutibleFor: .mostPeople,
                latitude: 78.1902,longitude: 15.56362,description:NSLocalizedString("SARKOFAGEN_DESC",comment:"Sarkofagen"),
                imageSummit:UIImage(named: "Sarkofagen.jpg")!,imageGraph:UIImage(named: "SarkofagenGraf.png")!))
        summits.append(
            Summit(id:3,name: "Trollsteinen",height: 850,distance:0,winter:true,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                latitude: 78.1685,longitude: 15.58627,description:NSLocalizedString("TROLLSTEINEN_DESC",comment:"Trollsteinen"),
                imageSummit:UIImage(named: "Trollstein.jpg")!,imageGraph:UIImage(named: "TrollsteinGraf.png")!))
        summits.append(
            Summit(id:4,name: "Nordenskiöld",height: 1050,distance:0,winter:true,terrain: .hilly,difficulty: .intensive,sutibleFor: .mostPeople,
                latitude: 78.17903,longitude: 15.42458,description:NSLocalizedString("NORDENSKJOLD_DESC",comment:"Nordenskiöld"),
                imageSummit:UIImage(named: "Nordenskjold.jpg")!,imageGraph:UIImage(named: "NordenskjoldGraf.png")!))
        summits.append(
            Summit(id:5,name: "Morena ved Longyearbreen",height: 246,distance:0,winter:false,terrain: .flat,difficulty: .easy,sutibleFor: .child,
                latitude: 78.19205,longitude: 15.53917,description:NSLocalizedString("MORENA_DESC",comment:"Morena ved Longyearbreen"),
                imageSummit:UIImage(named: "MorenaLongyearbreen.jpg")!,imageGraph:UIImage(named: "MorenaLongyearbreenGraf.png")!))
        summits.append(
            Summit(id:6,name: "Varden i Bjørndalen",height: 89,distance:0,winter:false,terrain: .flat,difficulty: .easy,sutibleFor: .child,
                latitude: 78.2163,longitude: 15.34592,description:NSLocalizedString("BJORNDALEN_DESC",comment:"Varden i Bjørndalen"),
                imageSummit:UIImage(named: "VardenBjorndalen.jpg")!,imageGraph:UIImage(named: "VardenBjorndalenGraf.png")!))
        summits.append(
            Summit(id:7,name: "Sneheim",height: 545,distance:0,winter:false,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                latitude: 78.25927,longitude: 15.76723,description:NSLocalizedString("SNEHEIM_DESC",comment:"Sneheim"),
                imageSummit:UIImage(named: "Sneheim.jpg")!,imageGraph:UIImage(named: "SneheimGraf.png")!))
        summits.append(
            Summit(id:8,name: "Varden ved Platåberget",height: 326,distance:0,winter:true,terrain: .hilly,difficulty: .easy,sutibleFor: .mostPeople,
                latitude: 78.2185,longitude: 15.59543,description:NSLocalizedString("PLATAABERGET_DESC",comment:"Varden ved Platåberget"),
                imageSummit:UIImage(named: "VardenPlataaberget.jpg")!,imageGraph:UIImage(named: "VardenPlataabergetGraf.png")!))
        summits.append(
            Summit(id:9,name: "Fuglefjella",height: 437,distance:0,winter:false,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                latitude: 78.21647,longitude: 15.27997,description:NSLocalizedString("FUGLEFJELLA_DESC",comment:"Fuglefjella"),
                imageSummit:UIImage(named: "Fuglefjella.jpg")!,imageGraph:UIImage(named: "FuglefjellaGraf.png")!))
        summits.append(
            Summit(id:10,name: "Lindholmhøgda",height: 361,distance:0,winter:false,terrain: .hilly,difficulty: .medium,sutibleFor: .child,
                latitude: 78.20385,longitude: 15.7028,description:NSLocalizedString("LINDHOLMHOGDA_DESC",comment:"Lindholmhøgda"),
                imageSummit:UIImage(named: "Lindholmhogda.jpg")!,imageGraph:UIImage(named: "LindholmhogdaGraf.png")!))
        summits.append(
            Summit(id:11,name: "Blomsterdalshøgda",height: 317,distance:0,winter:false,terrain: .hilly,difficulty: .medium,sutibleFor: .child,
                latitude: 78.22653,longitude: 15.53115,description:NSLocalizedString("BLOMSTERDALSHOGDA_DESC",comment:"Blomsterdalshøgda"),
                imageSummit:UIImage(named: "Blomsterdalshogda.jpg")!,imageGraph:UIImage(named: "BlomsterdalshogdaGraf.png")!))
        summits.append(
            Summit(id:12,name: "Endalen",height: 190,distance:0,winter:true,terrain: .flat,difficulty: .easy,sutibleFor: .child,
                latitude: 78.16238,longitude: 15.67135,description:NSLocalizedString("ENDALEN_DESC",comment:"Endalen"),
                imageSummit:UIImage(named: "Endalen2.jpg")!,imageGraph:UIImage(named: "EndalenGraf.png")!))
        summits.append(
            Summit(id:13,name: "Varden på Sverdruphamaren",height: 456,distance:0,winter:false,terrain: .hilly,difficulty: .medium,sutibleFor: .mostPeople,
                latitude: 78.20413,longitude: 15.55447,description:NSLocalizedString("SVERDRUPHAMAREN_DESC",comment:"Varden på Sverdruphamaren"),
                imageSummit:UIImage(named: "Sverdruphammern.jpg")!,imageGraph:UIImage(named: "SverdruphammarenGraf.png")!))
        summits.append(
            Summit(id:14,name: "Varden i Bolterdalen",height: 175,distance:0,winter:false,summer:false,terrain: .flat,difficulty: .easy,sutibleFor: .child,
                 latitude: 78.13518,longitude: 16.00832,description:NSLocalizedString("BOLTERDALEN_DESC",comment:"Varden i Bolterdalen"),
                 imageSummit:UIImage(named: "VardenBolterdalen.jpg")!,imageGraph:UIImage(named: "VardenBolterdalenGraf.png")!))
        //summits.append(
            //Summit(id:14,name: "Gruvefjellet",height: 451,distance:0,winter:false,terrain: .hilly,difficulty: .medium,sutibleFor: .mostPeople,
            //    latitude: 78.2039,longitude: 15.6289,description:NSLocalizedString("GRUVEFJELLET_DESC",comment:"Gruvefjellet"),
            //    imageSummit:UIImage(named: "Gruvefjellet.jpg")!,imageGraph:UIImage(named: "GruvefjelletGraf.png")!))
        summits.append(
            Summit(id:15,name: "Tenoren",height: 656,distance:0,winter:true,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                latitude: 78.2227,longitude: 15.9755,description:NSLocalizedString("TENOREN_DESC",comment:"Tenoren"),
                imageSummit:UIImage(named: "Tenoren_person.jpg")!,imageGraph:UIImage(named: "TenorenGraf.png")!))
        
        summits.append(
            Summit(id:16,name: "Janssonhaugen",height: 352,distance:0,winter:true,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                   latitude: 78.17869,longitude: 16.34768,description:NSLocalizedString("JANSSON_DESC",comment:"Janssonhaugen"),
                   imageSummit:UIImage(named: "Jansson.jpg")!,imageGraph:UIImage(named: "Turboski.jpg")!))
        
        summits.append(
            Summit(id:17,name: "Lars Hiertafjellet",height: 878,distance:0,winter:true,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                   latitude: 78.1657,longitude: 15.5110,description:NSLocalizedString("LARS_DESC",comment:"Lars Hiertafjellet"),
                   imageSummit:UIImage(named: "LarsHiertafjellet.jpg")!,imageGraph:UIImage(named: "TenorenGraf.png")!))
        summits.append(
            Summit(id:18,name: "Halvveis til Sukkertoppen",height: 171,distance:0,winter:true,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                   latitude: 78.2145,longitude: 15.6532,description:NSLocalizedString("DUMMY_DESC",comment:"Halvveis til Sukkertoppen"),
                   imageSummit:UIImage(named: "Lunsjtoppen.jpg")!,imageGraph:UIImage(named: "Turboski.jpg")!))
        summits.append(
            Summit(id:19,name: "Taubanebukken på Kuhaugen",height: 78,distance:0,winter:true,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                   latitude: 78.2129,longitude: 15.6893,description:NSLocalizedString("DUMMY_DESC",comment:"Taubanebukken på Kuhaugen"),
                   imageSummit:UIImage(named: "Kuhaugen.jpg")!,imageGraph:UIImage(named: "Turboski.jpg")!))
        summits.append(
            Summit(id:20,name: "Halvveis til Platåberget",height: 131,distance:0,winter:true,terrain: .hilly,difficulty: .moreDemanding,sutibleFor: .mostPeople,
                   latitude: 78.2201,longitude: 15.5993,description:NSLocalizedString("DUMMY_DESC",comment:"Halvveis til Platåberget"),
                   imageSummit:UIImage(named: "HalveistilVarden.jpg")!,imageGraph:UIImage(named: "Turboski.jpg")!))
        
        for index:Int in 0...(self.summits.count-1){
            if(summits[index].visitdates.count > 0){
                self.completed += 1
            }
        }
    }
    
    func getTotalHeight() ->Int{
        
        var total = 0
        
        for index in 0...(self.summits.count-1){
            
            let count = summitMgr.summits[index].getVisitCount()
            if(count > 0)
            {
                total += count * summitMgr.summits[index].height
            }
            
        }
        
        return total
    }
    
    func deleteAll() {
        for index in 0...(self.summits.count-1){
            self.summits[index].removeAllVisits()
        }
        
        self.completed = 0
    }
    
    func indexByName(_ name:String) ->Int{
        
        let index:Int = 0
        
        for index in 0...(self.summits.count-1){
            if( summits[index].name == name){
                return index
            }
        }
        
        return index
    }
    
    func firstVisit(_ name:String)->String{
        
        var firstVisitDate = NSLocalizedString("SUMMIT_FIRST_VISIT",comment:"Ikke besøkt")
        
        if(self.summits[indexByName(name)].visitdates.count > 0){
            
            let date = self.summits[indexByName(name)].visitdates[0].visitDate
            
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            //formatter.timeStyle = .MediumStyle
            formatter.string(from: date as Date)
            
            firstVisitDate = formatter.string(from: date as Date)
        }
        
        return firstVisitDate
    }
    
    func getVisitCount(_ name:String) ->Int{
        return self.summits[indexByName(name)].visitdates.count
    }
    
    func getVisitDateByIndex(_ name:String, index:Int) ->Date{
        return self.summits[indexByName(name)].visitdates[index].visitDate as Date
    }
    
    func addVisit(_ name:String,comment:String){
        
        //Add a current date to summit
        if( self.summits[indexByName(name)].addVisit(visitDate: Date(),visitComment: comment) == 1){
            //update the completed for the first visit
            self.completed += 1
        }
    }
    
    func removeVisit(_ name:String, index:Int) {
        
        //Remove date form visits for this summit
        if( self.summits[indexByName(name)].removeVisit(index) == 0){
            //update the completed
            self.completed -= 1
        }
    }
    
    //Change the date and photo (if any) for this visit
    func updateVisit(_ name:String, comment:String, index:Int, newdate:Date, photo:UIImage?){
        
        self.summits[indexByName(name)].updateVisit(index,newdate: newdate, comment: comment)
        if(photo != nil){
            //self.summits[indexByName(name)].updatePhotoAtIndex(index, photo: photo!)
        }
    }
    
}
