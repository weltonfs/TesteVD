//
//  Avfms.swift
//  VivaDecora
//
//  Created by Welton Stefani on 26/09/16.
//  Copyright © 2016 Welton Stefani. All rights reserved.
//

import Foundation

class Local : NSObject , NSCoding{
    
    /*
    Deve ser feita uma lista, em que cada elemento tenha a imagem, o nome do local("venue"),
     a descrição("note") quando houver e o número de visualizações.
    */
    
    let venue: String
    let note: String
    let image: String
    let views: Int
//    var items = Array<Item>()
    init(venue:String, note:String, image:String, views:Int){
        self.venue = venue
        self.note = note
        self.image = image
        self.views = views
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.venue = aDecoder.decodeObject(forKey: "venue") as! String
        self.note = aDecoder.decodeObject(forKey: "note") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.views = aDecoder.decodeInteger(forKey: "views")
//        self.items = aDecoder.decodeObjectForKey("items") as! Array
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(venue, forKey: "venue")
        aCoder.encode(note, forKey: "note")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(views, forKey: "views")
    }
    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encode(venue, forKey: "venue")
//        aCoder.encode(note, forKey: "note")
//        aCoder.encode(image, forKey: "image")
//        aCoder.encode(views, forKey: "views")
////        aCoder.encodeObject(items, forKey: "items")
//    }
    
//    func allCalories() -> Double{
//        var total = 0.0
//        for i in items{
//            total += i.calories
//        }
//        return total
//    }
    
//    func details() -> String {
//        var message = "note: \(self.note)"
//        
//        for item in self.items {
//            message += "\n * \(item.venue) - \(item.calories) calories"
//        }
//        
//        return message
//    }
}
