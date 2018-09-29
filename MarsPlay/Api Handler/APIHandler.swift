//
//  APIHandler.swift
//  MarsPlay
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 MarsPlay. All rights reserved.
//

import Foundation
import UIKit

class APIHandler {
    
    private var baseURL : String {
        get{
            return "http://www.omdbapi.com/"
        }
    }

    internal func getItems(_ params : [String:String], completion : @escaping ([Item]?, String?) -> Void) {
        guard var components = URLComponents(string: baseURL) else {
            return
        }
        
        components.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        
        guard let requestURL = components.url else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let value = data, let json = try? JSONSerialization.jsonObject(with: value) as? [String : Any] {
                if let searchResults = json?["Search"] as? [[String:Any]] {
                    var list = [Item]()
                    for result in searchResults {
                        list.append(Item(details: result))
                    }
                    completion(list, nil)
                }
                
            } else if let err = error {
                completion(nil, err.localizedDescription)
            } else {
                completion(nil, "Oops! Something went wrong.")
            }
        })
        task.resume()
    }
    
    internal func getUserImageFromUrlStr(_ urlString:String, completion:  @escaping (UIImage?) -> Void) {
        guard let requestURL = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let value = data, let image = UIImage(data: value) {
                completion(image)
            } else {
                completion(nil)
            }
        })
        task.resume()
    }
    
}
