//
//  Item.swift
//  MarsPlay
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 MarsPlay. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    var imageUrlString : String?
    var title : String?
    var type : String?
    var imdbID : String?
    var year : String?
    
    init(details : [String : Any], currentYear : Int) {
        imageUrlString = details["Poster"] as? String
        title = details["Title"] as? String
        imdbID = details["imdbID"] as? String
        
        if let value = details["Type"] as? String {
            type = value.prefix(1).uppercased() + value.dropFirst()
        }
        
        if let value = details["Year"] as? String {
            let launchYear = (value.count > 4) ? Int(value.prefix(4))! : Int(value)!
            let diff = currentYear - launchYear
            if diff > 0 {
                year = "\(diff) years ago"
            } else if diff == 0 {
                year = "This year"
            }
        }
    }
    
}
