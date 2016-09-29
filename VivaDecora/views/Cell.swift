//
//  Cell.swift
//  VivaDecora
//
//  Created by Welton Stefani on 26/09/16.
//  Copyright © 2016 Welton Stefani. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.view.layer.borderWidth = 0.5
        self.view.layer.borderColor = UIColor.lightGray.cgColor
        self.view.layer.cornerRadius = 6.0
        self.view.clipsToBounds = true
        self.picture.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
