//
//  DetailViewController.swift
//  MarsPlay
//
//  Created by Faraz Habib on 29/09/18.
//  Copyright © 2018 MarsPlay. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var itemImageView: MPImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    
    var item : Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLbl.text = item.title ?? ""
        typeLbl.text = item.type ?? ""
        yearLbl.text = item.year ?? ""
        itemImageView.loadImageUsingString(item.imageUrl)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
