//
//  Dao.swift
//  VivaDecora
//
//  Created by Welton Stefani on 26/09/16.
//  Copyright © 2016 Welton Stefani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Dao {
    
    let localArchive:String
    
    init() {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                           FileManager.SearchPathDomainMask.userDomainMask,
                                                           true)
        let dir = userDirs[0] as String
        
        localArchive = "\(dir)/local"
    }
    
    //---
    func saveLocal(local: Array<Local>){
        NSKeyedArchiver.archiveRootObject(local, toFile: localArchive)
    }
    
    func loadLocal() -> Array<Local>{
        
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: localArchive){
            return loaded as! Array
        }
        return Array<Local>()
    }
}
