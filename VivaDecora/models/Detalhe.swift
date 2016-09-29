//
//  Detalhe.swift
//  VivaDecora
//
//  Created by Welton Stefani on 26/09/16.
//  Copyright © 2016 Welton Stefani. All rights reserved.
//

import Foundation

class Detalhe : NSObject , NSCoding{

    /*
    Deve ser feita uma tela de detalhes, que abre a partir do clique em um item da lista da Tela 1. Deve ser exibido a imagem, o nome ("name"), o endereço ("address", "city", "state", "country") e a média de nota ("average_rating"). Quando existir, deve mostrar o conteúdo "stats" e o "link".
    */

    let name:String
    let address:String
    let city:String
    let state:String
    let country:String
    let average_rating:String
    let stats:String
    let link:String
    
    init(name:String, address:String, city:String, state:String, country:String, average_rating:String, stats:String, link:String){
        self.name = name
        self.address = address
        self.city = city
        self.state = state
        self.country = country
        self.average_rating = average_rating
        self.stats = stats
        self.link = link
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.address = aDecoder.decodeObject(forKey: "address") as! String
        self.city = aDecoder.decodeObject(forKey: "city") as! String
        self.state = aDecoder.decodeObject(forKey: "state") as! String
        self.country = aDecoder.decodeObject(forKey: "country") as! String
        self.average_rating = aDecoder.decodeObject(forKey: "average_rating") as! String
        self.stats = aDecoder.decodeObject(forKey: "stats") as! String
        self.link = aDecoder.decodeObject(forKey: "link") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(average_rating, forKey: "average_rating")
        aCoder.encode(stats, forKey: "stats")
        aCoder.encode(link, forKey: "link")
    }
    
//    override func isEqual(_ object: Any?) -> Bool {
//        if let rhs = object as? Item {
//            return name == rhs.name && calories == rhs.calories
//        }
//        return false
//    }
}

//func ==(first:Item, second:Item) -> Bool{
//    return first.name == second.name && first.calories == second.calories
//}
