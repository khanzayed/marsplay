//
//  MPImageView.swift
//  MarsPlay
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 MarsPlay. All rights reserved.
//

import UIKit

let newImageCache = NSCache<NSString, UIImage>()

class MPImageView: UIImageView {

    var urlString : String?
    
    internal func loadImageUsingString(_ imageUrl : String?) {
        guard let url = imageUrl, url.count > 0 else {
            self.image = defaultImage()
            return
        }
        
        urlString = imageUrl
        if let imageFromCache = newImageCache.object(forKey: url as NSString) {
            self.image = imageFromCache
            return
        }
        
        APIHandler().getUserImageFromUrlStr(url, completion: { [weak self] (image) in
            guard self != nil else {
                return
            }
            
            if let img = image {
                newImageCache.setObject(img, forKey: url as NSString)
            }
            
            DispatchQueue.main.async {
                if self?.urlString == imageUrl {
                    self?.image = image
                }
            }
        })
    }

}

extension UIImageView {
    
    internal func defaultImage() -> UIImage {
        return UIImage(named: "")!
    }
    
}
