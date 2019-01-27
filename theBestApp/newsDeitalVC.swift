//
//  newsDeitalVC.swift
//  theBestApp
//
//  Created by Ashot on 1/24/19.
//  Copyright © 2019 Ashot. All rights reserved.
//

import UIKit

class newsDeitalVC: UIViewController {
    var currentNews: newsModel?
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UITextView!
    @IBOutlet weak var newsProvider: UILabel!
    @IBOutlet weak var newsHostname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlKey = currentNews?.imgURL
        if let url = URL(string: urlKey!){
            do {
                let data = try Data(contentsOf: url)
                self.newsImage.image = UIImage(data: data)
            }catch let err {
                print("error: \(err.localizedDescription)")
            }
        }
        newsTitle.text = currentNews?.title
        newsProvider.text = currentNews?.provider
        newsHostname.text = currentNews?.hostname
    }
    
}
