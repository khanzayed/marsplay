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
    
    init(details : [String : Any]) {
        imageUrlString = details["Poster"] as? String
        title = details["Title"] as? String
        type = details["Type"] as? String
        imdbID = details["Year"] as? String
        year = details["imdbID"] as? String
    }
    
}
