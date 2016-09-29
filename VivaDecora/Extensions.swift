//
//  AppDelegate.swift
//  Contacts
//
//  Created by Welton Stefani on 15/07/16.
//  Copyright © 2016 Welton Stefani. All rights reserved.
//

import UIKit

extension UIImageView
{
    public func imageFromUrl(_ urlString: String)
    {
        if let url = URL(string: urlString)
        {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let destinationPath = documentsPath + ("/"+url.lastPathComponent)
            
            let checkValidation = FileManager.default
            if (checkValidation.fileExists(atPath: "\(destinationPath)"))
            {
                print("FILE AVAILABLE");
                
                print("Loading image from path: \(destinationPath)")
                
                self.image = UIImage(contentsOfFile: destinationPath)
            }
            else
            {
                print("FILE NOT AVAILABLE");
            
                let request = URLRequest(url:url)
                URLSession.shared.dataTask(with: request as URLRequest){
                    
//                let request = NSMutableURLRequest(url: url)
//                URLSession.shared.dataTask(with: request, completionHandler: {
                    (data, response, error) in
                
                    print(urlString)
                    
                    guard let data = data , error == nil else{
                        NSLog("Image download error: \(error)")
                        DispatchQueue.main.async(execute: {
                            
                            self.image = UIImage(named: "no_image")
                            try? UIImageJPEGRepresentation(self.image!,1.0)!.write(to: URL(fileURLWithPath: destinationPath), options: [.atomic])
                        })
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse{
                        if httpResponse.statusCode > 400 {
                            let errorMsg = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                            NSLog("Image download error, statusCode: \(httpResponse.statusCode), error: \(errorMsg!)")
                            DispatchQueue.main.async(execute: {
                                self.image = UIImage(named: "no_image")
                                try? UIImageJPEGRepresentation(self.image!,1.0)!.write(to: URL(fileURLWithPath: destinationPath), options: [.atomic])
                            })
                            return
                        }
                    }
                    
                    DispatchQueue.main.async(execute: {
                        NSLog("Image download success")
                        self.image = UIImage(data: data)
                        try? UIImageJPEGRepresentation(self.image!,1.0)!.write(to: URL(fileURLWithPath: destinationPath), options: [.atomic])
                    })
                    
                    }
                    .resume()
            }
        }
    }
}

extension String {
    
    func stringByURLEncoding() -> String? {
        
        let char = NSCharacterSet.urlQueryAllowed
//        char.remove(charactersIn: "&")
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: char) else{
            return nil
        }
        
        return encodedString
        
    }
    
}
