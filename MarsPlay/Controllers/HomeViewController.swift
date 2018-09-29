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
    
    var page : Int = 0
    var items : [Item] = []
    var totalCount = 0
    var apiHandler : APIHandler!
    var isNewDataLoading = false
    var isLandScape = UIDevice.current.orientation.isLandscape
    var screenPadding : CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateScreenPadding()
        fetchItemsList(page: page + 1)
    }
    
    private func calculateScreenPadding() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436, 2688, 1792:
                screenPadding = 46
            default:
                screenPadding = 2
            }
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        isLandScape = UIDevice.current.orientation.isLandscape
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func fetchItemsList(page : Int) {
        isNewDataLoading = true
        
        let params : [String : String] = [
            "s"         :     "Batman",
            "page"      :     "\(page)",
            "apikey"    :     "eeefc96f"
        ]

        apiHandler = APIHandler()
        apiHandler.getItems(params) { [weak self] (responseList, message) in
            guard let strongSelf = self else {
                return
            }
            
            if let list = responseList {
                strongSelf.page += 1
                
                let initial = strongSelf.items.count
                
                strongSelf.items += list
                
                let final = strongSelf.items.count - 1
                
                    if initial > 0 {
                        var indexPaths = [IndexPath]()
                        for i in initial...final {
                            indexPaths.append(IndexPath(item: i, section: 0))
                        }
                        DispatchQueue.main.async {
                            strongSelf.collectionView.insertItems(at: indexPaths )
                            strongSelf.isNewDataLoading = false
                        }
                    } else {
                        DispatchQueue.main.async {
                            strongSelf.collectionView.reloadData()
                            strongSelf.isNewDataLoading = false
                        }
                    }
            } else if let errorMessage = message {
                print(errorMessage)
                strongSelf.isNewDataLoading = false
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
        let offset : CGFloat = (isLandScape) ? screenPadding : 2
        let width = UIScreen.main.bounds.width / 2 - offset
        let heigt = width / 0.75
        return CGSize(width: width, height: heigt)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = items[indexPath.row]
        cell.titleLbl.text = item.title ?? ""
        cell.itemImageView.loadImageUsingString(item.imageUrl)
        cell.typeLbl.text = item.type ?? ""
        cell.yearsLbl.text = item.year ?? ""
        
        if indexPath.row == items.count - 1, !isNewDataLoading { // more items to fetch
            isNewDataLoading = true
            fetchItemsList(page: self.page + 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.item = items[indexPath.row]
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
