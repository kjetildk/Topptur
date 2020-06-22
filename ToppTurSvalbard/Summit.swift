//
//  Summit.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 06.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import MapKit

class Summit { //: NSObject {
    var visitdates:[Visit] = [Visit]()
    var persistenceHelper:PersistenceHelper = PersistenceHelper()

    var id:Int = 0
    var name:String = "Name"
    var latitude:CLLocationDegrees = 78.21063
    var longitude:CLLocationDegrees = 15.65408
    var height:Int = 0
    var desc:String = ""
//    var distance:Int = 0
    var imageSummit:UIImage?
    var desc_URL:NSURL?
//    var terrain:SummitTerrain = .flat
//    var difficulty:SummitDifficulty = .easy
//    var sutibleFor:SummitSutibleFor = .mostPeople
//    var winter:Bool = false
//    var summer:Bool = true
//    var imageGraph:UIImage?
    
    class Visit: NSObject{
        
        var visitComment:String = ""
        var visitDate:Date = Date()
        
        init(visitComment:String, visitDate:Date){
            self.visitDate = visitDate
            self.visitComment = visitComment
        }
    }
    
    init(id:Int,name:String,height:Int,latitude:CLLocationDegrees,longitude:CLLocationDegrees,description:String,imageSummit:UIImage,desc_url:String){
        self.id = id
        self.name = name
        self.height = height
        self.latitude = latitude
        self.longitude = longitude
        self.desc = description
        self.imageSummit = imageSummit
        self.desc_URL = NSURL(string : desc_url)
        
        //clean up
        if(self.visitdates.count > 0){
            visitdates.removeAll(keepingCapacity: true)
        }
        //get all the visit dates in core data
        let tempVisits:[Any] = persistenceHelper.getListOfVisits(target:name)
        for res:Any in tempVisits {
            
            var comment = (res as AnyObject).value(forKey: "comment")
            if(comment == nil){
                comment = "" 
            }
            
            visitdates.append(Visit(visitComment: comment as! String, visitDate: (res as AnyObject).value(forKey: "visitdate") as! Date))
        }
    }
    
    func getVisitCount() ->Int{
        var count = 0
        if(self.visitdates.count > 0){
            count = self.visitdates.count
        }
        
        return count
    }
    
    func getVisitDate(index:Int) -> Date{
        return self.visitdates[index].visitDate
    }
    
    func getVisitComment(index:Int) -> String{
        return self.visitdates[index].visitComment
    }
    
    func addVisit(visitDate:Date,visitComment:String) ->Int{
        
        var dicVisit:Dictionary<String, Any> = Dictionary<String, Any>()
        dicVisit["name"] = name as String
        dicVisit["comment"] = visitComment as String
        dicVisit["visitdate"] = visitDate as Date
        
        //Update core data and this current list for this object
        if(persistenceHelper.save(entity: "Visit", parameters: dicVisit as Dictionary<String, AnyObject>)){
            self.visitdates.append(Visit(visitComment: visitComment,visitDate: visitDate))
        }
        
        return self.visitdates.count
    }
    
    //Remove all visits for current summit
    func removeAllVisits() {
        var result: Int = 0
        for visit in self.visitdates{
            
            result += removeVisit(self.visitdates.firstIndex(of: visit)!)
            
        }
    }
    
    //Remove for both core data and current list
    func removeVisit(_ index:Int)->Int{
        
        if(persistenceHelper.removeVisit(name: name, value: self.visitdates[index].visitDate)){
            self.visitdates.remove(at: index)
        }
        
        return self.visitdates.count
    }
    
    //Update core data and this current list for this object
    func updateVisit(_ index:Int, newdate:Date, comment:String){
        if(persistenceHelper.updateVisit(name: name, value: self.visitdates[index].visitDate, newdate: newdate, comment: comment)){
            self.visitdates[index].visitDate = newdate
            self.visitdates[index].visitComment = comment
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
            
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.string(from: date)
            
            firstVisitDate = formatter.string(from: date)
        }
        
        return firstVisitDate
    }
    
    //func updatePhotoAtIndex(_ index:Int){
        
    //    if(persistenceHelper.update(entity: "Visit", name: name, value: self.visitdates[index].visitDate)){
        
            //self.visitdates[index].addPhoto(photo)
    //    }
    //}
    
//    func getTerrain() ->String{
//
//        var terrainText:String = "Flatt"
//
//        switch(self.terrain){
//            case .flat: terrainText = NSLocalizedString("TERRAIN_FLAT",comment:"Flatt")
//            case .hilly: terrainText = NSLocalizedString("TERRAIN_HILLY",comment:"Kupert")
//            case .veryHilly: terrainText = NSLocalizedString("TERRAIN_VERYHILLY",comment:"Meget kupert")
//        }
//
//        return terrainText
//    }
//
//    func getDifficulty() ->String{
//
//        var difficultyText:String = "Flatt"
//
//        switch(self.difficulty){
//            case .easy: difficultyText = NSLocalizedString("DIFFICULTY_EASY",comment:"Lett")
//            case .quiteEasy: difficultyText = NSLocalizedString("DIFFICULTY_QUITEEASY",comment:"Ganske lett")
//            case .medium: difficultyText = NSLocalizedString("DIFFICULTY_MEDIUM",comment:"Middels")
//            case .moreDemanding: difficultyText = NSLocalizedString("DIFFICULTY_MOREDEMANDING",comment:"Litt krevende")
//            case .intensive: difficultyText = NSLocalizedString("DIFFICULTY_INTENSIVE",comment:"Krevende")
//            case .extraDemanding: difficultyText = NSLocalizedString("DIFFICULTY_EXSTRADEMANDING",comment:"Ekstra krevende")
//        }
//
//
//        return difficultyText
//    }
//
//    func getSutibleFor() ->String{
//        
//        var sutibleForText:String = "Flatt"
//
//        switch(self.sutibleFor){
//        case .mostPeople: sutibleForText = NSLocalizedString("SUTIBLEFOR_MOSTPEOPLE",comment:"Folk flest")
//        case .child: sutibleForText = NSLocalizedString("SUTIBLEFOR_CHILD",comment:"Barn")
//        case .youth: sutibleForText = NSLocalizedString("SUTIBLEFOR_YOUTH",comment:"Ungdom")
//        case .senior: sutibleForText = NSLocalizedString("SUTIBLEFOR_SENIOR",comment:"Senior")
//        case .mountainSportsEnthusiasts: sutibleForText = NSLocalizedString("SUTIBLEFOR_MOUNTAINSPORTENTHUSIASTS",comment:"Fjellsportinteresserte")
//        }
//
//        return sutibleForText
//    }
    
    
}


//
///*Terreng angir terrenget turen går i og er inndelt i følgende graderinger:
//
//1. Flatt - betyr at turen går i flatt lende
//2. Kupert -betyr at terrenget er småkupert
//3. Meget kupert- betyr at det vil være mye opp- og nedstigning*/
//enum SummitTerrain : UInt {
//    case flat
//    case hilly
//    case veryHilly
//}
//
///*Vanskelighetsgrad
//
//Vanskelighetsgrad sier noe om hvor krevende turen er og er inndelt i følgende graderinger:
//
//Graderinger for sommerturer:
//
//1. Lett - dagsturer ut fra hytte eller lette dagsarrangement for alle. Turene kan vanligvis tilpasses deltagernes forutsetninger. Lett dagstursekk.
//2. Ganske lett - dagsturer fra en hytte eller dagsetapper på 2 - 4 timer/ ca. 15 km. Lett dagstursekk eller sekk på 8–10 kg.
//3. Middels - lengste dagsetappe på 5 timer/ ca. 20 km. Sekk på 8 –10 kg.
//4. Litt krevende - lengste dagsetappe på 6 –7 timer/ ca. 25 km. Sekk på 8 –10 kg.
//5. Krevende - lengste dagsetappe på 7–9 timer/ ca. 30 km. Sekk på 8 –10 kg.
//6. Ekstra krevende - turer med lengre og tyngre dagsetapper enn 9 timer.*/
//enum SummitDifficulty : UInt {
//    case easy
//    case quiteEasy
//    case medium
//    case moreDemanding
//    case intensive
//    case extraDemanding
//}
//
///*Hvem passer turen for?
//
//Folk flest - turer kurs og arrangement for voksne
//Barn - turer, kurs og arrangement for aldersgruppen 0 til 12 år, både med og uten foreldre
//Ungdom - turer, kurs og arrangement for aldersgruppen 13 til 26 år
//Senior - turer og arrangement spesielt tilpasset for aldersgruppen 60+
//Fjellsportinteresserte - turer, kurs og arrangement med aktiviteter innen fjellsport, som feks brevandring og klatring*/
//enum SummitSutibleFor : UInt {
//    case mostPeople
//    case child
//    case youth
//    case senior
//    case mountainSportsEnthusiasts
//}
