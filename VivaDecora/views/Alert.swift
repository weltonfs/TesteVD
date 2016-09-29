//
//  Alert.swift
//  VivaDecora
//
//  Created by Welton Stefani on 31/08/16.
//  Copyright © 2016 Welton Stefani. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    
    let controller: UIViewController
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func show(_ message : String = "Erro inesperado."){
        let alert = UIAlertController(title: "Desculpe!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
}
