//
//  DetalheViewController.swift
//  VivaDecora
//
//  Created by Welton Stefani on 27/09/16.
//  Copyright © 2016 Welton Stefani. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetalheViewController: UIViewController {
    
    var selected = Int()
    var detalhe = Array<JSON>()

    var linkSplited = [String]()
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var average_rating: UILabel!
    @IBOutlet weak var stats: UITextView!
    @IBOutlet weak var btSite: UIButton!
    @IBOutlet weak var btShare: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var heightConstraintStats: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        scrollView.isHidden = true
        EZLoadingActivity.show("Loading...", disableUI: true)

        //--
        let locais = Dao().loadLocal()
        if locais.count == 0{
            scrollView.isHidden = true
            return
        }
        
        let local = locais[selected]
        getDetalhes(venue: local.venue)
        
        //--
        self.btSite.layer.borderWidth = 0.5
        self.btSite.layer.borderColor = UIColor.blue.cgColor
        self.btSite.layer.cornerRadius = 6.0
        
        self.picture.clipsToBounds = true
        
        EZLoadingActivity.hide()
    }
    
    //---
    func getDetalhes(venue: String){
        
        var urlDet:String = "\(urlDetalhe)\(venue)"
        urlDet = urlDet.stringByURLEncoding()!
        
            Alamofire.request(urlDet)
            
            //.validate(statusCode: 200..<300)
            .responseJSON { response in
                
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                switch(response.result) {
                case .success(let value):
                    // print("success \(value)")
                    
                    let json = JSON(value)
                    // print("JSON: \(json)")
                    
                    if let arr = json["avfms"].array {
                        for a in arr{
                             print("======================= \n \(a)")

                            self.atualizaDadosTela(a: a)
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
    
    func atualizaDadosTela(a:JSON){
        print(a)
        
        if a["name"] != nil{
            self.navigationItem.title = a["name"].stringValue
            
            name.text = "Name: \(a["name"].stringValue)"
        }else{
            Alert(controller: self).show("Ocorreu um erro na sua requisição.")
            return
        }
        
        if a["newest_image"] != nil{
            print(a["newest_image"].stringValue)
            DispatchQueue.main.async(execute: {
                do {
                    self.picture.imageFromUrl("\(urlPhotos)\(a["newest_image"].stringValue)")
                }
            })
        }
        if a["address"] != nil{
            address.text = "Address: \(a["address"].stringValue)"
        }
        if a["city"] != nil{
            city.text = "City: \(a["city"].stringValue)"
        }
        if a["state"] != nil{
            state.text = "State: \(a["state"].stringValue)"
        }
        if a["country"] != nil{
            country.text = "Country: \(a["country"].stringValue)"
        }
        if a["average_rating"] != nil{
            average_rating.text = a["average_rating"].stringValue
        }
        if a["stats"] != nil{
            if a["stats"].stringValue != ""{
                let s1 : String = "Stats: \(a["stats"].stringValue)"
                var s2 = s1.replacingOccurrences(of: "<b>", with: "")
                s2 = s2.replacingOccurrences(of: "</b>", with: "")
                s2 = s2.replacingOccurrences(of: "<br>", with: ", ")
                
                print(s2)
                stats.text = s2
                
                let sizeThatShouldFitTheContent:CGSize = stats.sizeThatFits(stats.frame.size)
                heightConstraintStats.constant = sizeThatShouldFitTheContent.height;
            }else{
                //esconder
                stats.isHidden = true
                heightConstraintStats.constant = 0
            }
        }else{
            //esconder
            stats.isHidden = true
            heightConstraintStats.constant = 0
        }

        if a["sameas"] != nil{
            if a["sameas"] != ""{
                let sameas = a["sameas"].stringValue
                linkSplited = sameas.components(separatedBy: ",")
            }else{
                //esconder
                btSite.isHidden = true
                btShare.isHidden = true
            }
        }else{
            //esconder
            btSite.isHidden = true
            btShare.isHidden = true
        }
        
        scrollView.isHidden = false
    }
    
    @IBAction func openBrowser(sender: AnyObject) {
        print(linkSplited[0])
        UIApplication.shared.openURL(NSURL(string: linkSplited[0])! as URL)
    }
    
    @IBAction func share(sender: AnyObject) {
        
        let urlWebsite = NSURL(string:linkSplited[0])
        let img: UIImage = picture.image!
        
        guard let url = urlWebsite else {
            return
        }
        
        let shareItems:Array = [img, url]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.copyToPasteboard, UIActivityType.addToReadingList, UIActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
    }
}
