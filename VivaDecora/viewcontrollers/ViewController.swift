//
//  ViewController.swift
//  VivaDecora
//
//  Created by Welton Stefani on 22/09/16.
//  Copyright © 2016 Welton Stefani. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UITableViewController {

    var locais = Array<Local>()
    var selected = Int()
    
    func add(_ local: Local){
        locais.append(local)
        Dao().saveLocal(local: locais)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        EZLoadingActivity.show("Loading...", disableUI: true)
        //--
        locais = Dao().loadLocal()
        if locais.count == 0{
            getLocais()
        }
        EZLoadingActivity.hide()
    }

    //MARK:- TABLEVIEW
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locais.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let local = locais[(indexPath as NSIndexPath).row]
        
        print(local.venue)
        print(local.note)
        print(local.views)
        print(local.image)
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell

        cell.venue.text = local.venue
        cell.note.text = local.note
        cell.views.text = String(local.views)
        
        DispatchQueue.main.async(execute: {
            do {
                cell.picture.imageFromUrl("\(urlWallpaper)\(local.image)")
            }
        })

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print(indexPath.row)
        
        self.selected = indexPath.row
        self.performSegue(withIdentifier: "detalhe", sender: self)
    }
    
    //---
    func getLocais(){
        Alamofire.request(urlApi)
            //.validate(statusCode: 200..<300)
            .responseJSON { response in
                
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                switch(response.result) {
                case .success(let value):
//                    print("success \(value)")
                    // Yeah! Hand response
                    
                    let json = JSON(value)
//                    print("JSON: \(json)")
                    
                    if let arr = json["avfms"].array {
                        for a in arr{
//                            print("======================= \n \(a)")
                            
                            if let b = self.validade(a: a){
                                self.add(b)
                            }
                        }
                    }
                    
                case .failure(let error):
                    print("success \(error)")
                    
                    if let statusCode = response.response?.statusCode {
                        //Do something with result
                        print(statusCode)
                        
                        Alert(controller: self).show("Ocorreu um erro na sua requisição. \(statusCode)")
                    }
                }
        }
    }
    
    func validade(a:JSON) -> Local?{
        
        let venue = a["venue"].string
        let note = a["note"].string
        let image = a["image"].string
        var views = Int(a["views"].string!)
        
        if views == nil{
            views = 0
        }
        
        let local = Local(venue: venue!, note: note!, image: image!, views: views!)
        print("= save local = '\(local.venue)', '\(local.note)', '\(local.image)', '\(local.views)'")
        return local
    }
    
    //MARK:- SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhe"{
            let backButton = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
            navigationItem.backBarButtonItem?.tintColor = UIColor.white
            navigationItem.backBarButtonItem = backButton
            
            let seg = segue.destination as! DetalheViewController
            seg.selected = self.selected
        }
    }
}

