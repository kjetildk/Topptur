//
//  Summit.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 06.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import MapKit

class Summit: NSObject {
    var name:String = "Name"
    var visitdates:[Visit] = [Visit]() //[NSDate] = [NSDate()]
    var persistenceHelper:PersistenceHelper = PersistenceHelper()
    var latitude:CLLocationDegrees = 78.21063
    var longitude:CLLocationDegrees = 15.65408
    var height:Int = 0
    var desc:String = ""
    var distance:Int = 0
    var terrain:SummitTerrain = .Flat
    var difficulty:SummitDifficulty = .Easy
    var sutibleFor:SummitSutibleFor = .MostPeople
    var image:UIImage?
    
    class Visit: NSObject{
        
        var visitDate:NSDate = NSDate()
        var photo:UIImage = UIImage(named: "AppIcon72x72.png")
        
        init(visitDate:NSDate, photo:NSData){
            self.visitDate = visitDate
            self.photo = UIImage(data: photo)
        }
        
        func addPhoto(photo:UIImage){
            self.photo = photo
        }
    }
    
    init(name:String,height:Int,distance:Int,terrain:SummitTerrain,difficulty:SummitDifficulty,sutibleFor:SummitSutibleFor,latitude:CLLocationDegrees,longitude:CLLocationDegrees,description:String,image:UIImage){
        self.name = name
        self.height = height
        self.latitude = latitude
        self.longitude = longitude
        self.desc = description
        self.distance = distance
        self.terrain = terrain
        self.difficulty = difficulty
        self.sutibleFor = sutibleFor
        self.image = image
        
        //clean up
        if(self.visitdates.count > 0){
            visitdates.removeAll(keepCapacity: true)
        }
        //get all the visit dates in core data
        var tempSummits:NSArray = persistenceHelper.list("Summit",summit:name)
        for res:AnyObject in tempSummits {
            visitdates.append(Visit(visitDate: res.valueForKey("visitdate") as NSDate,photo: res.valueForKey("photo") as NSData))
        }
    }
    
    func getVisitCount() ->Int{
        var count = 0
        if(self.visitdates.count > 0){
            count = self.visitdates.count
        }
        
        return count
    }
    
    func getVisitDate(index:Int) -> NSDate{
        return self.visitdates[index].visitDate
    }
    
    func addVisit(visitdate:NSDate) ->Int{
        
        var dicSummit:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        dicSummit["name"] = name as String
        dicSummit["visitdate"] = visitdate as NSDate
        dicSummit["photo"] = UIImagePNGRepresentation(UIImage(named:"AppIcon72x72.png")) as NSData
        
        //Update core data and this current list for this object
        if(persistenceHelper.save("Summit", parameters: dicSummit)){
            self.visitdates.append(Visit(visitDate: visitdate, photo: UIImagePNGRepresentation(UIImage(named:"AppIcon72x72.png"))))
        }
        
        return self.visitdates.count
    }
    
    //Remove for both core data and current list
    func removeVisit(index:Int)->Int{
        
        if(persistenceHelper.remove("Summit", name: name, value: self.visitdates[index].visitDate)){
            self.visitdates.removeAtIndex(index)
        }
        
        return self.visitdates.count
    }
    
    //Update core data and this current list for this object
    func updateVisit(index:Int, newdate:NSDate){
        if(persistenceHelper.update("Summit", name: name, value: self.visitdates[index].visitDate, newdate: newdate)){
            self.visitdates[index].visitDate = newdate
        }
    }
    
    func visited() ->Bool{
        return self.visitdates.count > 0
    }
    
    func getHeight()->String{
        
        let moh = NSLocalizedString("SUMMIT_HEIGHT",comment:"moh")
        
        return "\(self.height) \(moh)"
    }
    
    func firstVisit()->String{
        
        var firstVisitDate = NSLocalizedString("SUMMIT_FIRST_VISIT",comment:"Ikke besøkt")
        
        if(self.visitdates.count > 0){
            
            let date = self.visitdates[0].visitDate
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .LongStyle
            formatter.stringFromDate(date)
            
            firstVisitDate = formatter.stringFromDate(date)
        }
        
        return firstVisitDate
    }
    
    func updatePhotoAtIndex(index:Int,photo:UIImage){
        
        if(persistenceHelper.update("Summit", name: name, value: self.visitdates[index].visitDate, photo:photo)){
        
            self.visitdates[index].addPhoto(photo)
        }
    }
    
    func getTerrain() ->String{
        
        var terrainText:String = "Flatt"
        
        switch(self.terrain){
            case .Flat: terrainText = NSLocalizedString("TERRAIN_FLAT",comment:"Flatt")
            case .Hilly: terrainText = NSLocalizedString("TERRAIN_HILLY",comment:"Kupert")
            case .Hilly: terrainText = NSLocalizedString("TERRAIN_VERYHILLY",comment:"Meget kupert")
            default:
            terrainText = NSLocalizedString("TERRAIN_FLAT",comment:"Flatt")
        }
        
        return terrainText
    }
    
    func getDifficulty() ->String{
        
        var difficultyText:String = "Flatt"
        
        switch(self.difficulty){
        case .Easy: difficultyText = NSLocalizedString("DIFFICULTY_EASY",comment:"Lett")
        case .QuiteEasy: difficultyText = NSLocalizedString("DIFFICULTY_QUITEEASY",comment:"Ganske lett")
        case .Medium: difficultyText = NSLocalizedString("DIFFICULTY_MEDIUM",comment:"Middels")
        case .MoreDemanding: difficultyText = NSLocalizedString("DIFFICULTY_MOREDEMANDING",comment:"Litt krevende")
        case .Intensive: difficultyText = NSLocalizedString("DIFFICULTY_INTENSIVE",comment:"Krevende")
        case .ExtraDemanding: difficultyText = NSLocalizedString("DIFFICULTY_EXSTRADEMANDING",comment:"Ekstra krevende")
        default:
            difficultyText = NSLocalizedString("DIFFICULTY_EASY",comment:"Lett")
        }

        
        return difficultyText
    }
    
    func getSutibleFor() ->String{
        
        var sutibleForText:String = "Flatt"
        
        switch(self.sutibleFor){
        case .MostPeople: sutibleForText = NSLocalizedString("SUTIBLEFOR_MOSTPEOPLE",comment:"Folk flest")
        case .Child: sutibleForText = NSLocalizedString("SUTIBLEFOR_CHILD",comment:"Barn")
        case .Youth: sutibleForText = NSLocalizedString("SUTIBLEFOR_YOUTH",comment:"Ungdom")
        case .Senior: sutibleForText = NSLocalizedString("SUTIBLEFOR_SENIOR",comment:"Senior")
        case .MountainSportsEnthusiasts: sutibleForText = NSLocalizedString("SUTIBLEFOR_MOUNTAINSPORTENTHUSIASTS",comment:"Fjellsportinteresserte")
        default:
            sutibleForText = NSLocalizedString("SUTIBLEFOR_",comment:"Folk flest")
        }

        
        return sutibleForText
    }
    
    
}

/*Terreng angir terrenget turen går i og er inndelt i følgende graderinger:

1. Flatt - betyr at turen går i flatt lende
2. Kupert -betyr at terrenget er småkupert
3. Meget kupert- betyr at det vil være mye opp- og nedstigning*/
enum SummitTerrain : UInt {
    case Flat
    case Hilly
    case VeryHilly
}

/*Vanskelighetsgrad

Vanskelighetsgrad sier noe om hvor krevende turen er og er inndelt i følgende graderinger:

Graderinger for sommerturer:

1. Lett - dagsturer ut fra hytte eller lette dagsarrangement for alle. Turene kan vanligvis tilpasses deltagernes forutsetninger. Lett dagstursekk.
2. Ganske lett - dagsturer fra en hytte eller dagsetapper på 2 - 4 timer/ ca. 15 km. Lett dagstursekk eller sekk på 8–10 kg.
3. Middels - lengste dagsetappe på 5 timer/ ca. 20 km. Sekk på 8 –10 kg.
4. Litt krevende - lengste dagsetappe på 6 –7 timer/ ca. 25 km. Sekk på 8 –10 kg.
5. Krevende - lengste dagsetappe på 7–9 timer/ ca. 30 km. Sekk på 8 –10 kg.
6. Ekstra krevende - turer med lengre og tyngre dagsetapper enn 9 timer.*/
enum SummitDifficulty : UInt {
    case Easy
    case QuiteEasy
    case Medium
    case MoreDemanding
    case Intensive
    case ExtraDemanding
}

/*Hvem passer turen for?

Folk flest - turer kurs og arrangement for voksne
Barn - turer, kurs og arrangement for aldersgruppen 0 til 12 år, både med og uten foreldre
Ungdom - turer, kurs og arrangement for aldersgruppen 13 til 26 år
Senior - turer og arrangement spesielt tilpasset for aldersgruppen 60+
Fjellsportinteresserte - turer, kurs og arrangement med aktiviteter innen fjellsport, som feks brevandring og klatring*/
enum SummitSutibleFor : UInt {
    case MostPeople
    case Child
    case Youth
    case Senior
    case MountainSportsEnthusiasts
}
