//
//  ViewController.swift
//  MarsPlay
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 MarsPlay. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var page : Int = 1
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params : [String : String] = [
            "s"         :     "Batman",
            "page"      :     "1",
            "apikey"    :     "eeefc96f"
        ]
        
        APIHandler().getItems(params) { [weak self] (responseList, message) in
            guard let strongSelf = self else {
                return
            }
            
            if let list = responseList {
                strongSelf.items += list
                
                DispatchQueue.main.async {
                    strongSelf.collectionView.reloadData()
                }
            } else if let errorMessage = message {
                print(errorMessage)
            }
        }
    }

}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2 - 2
        let heigt = width / 0.75
        return CGSize(width: width, height: heigt)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = items[indexPath.row]
        cell.titleLbl.text = item.title ?? ""
        cell.itemImageView.loadImageUsingString(item.imageUrlString)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
}

