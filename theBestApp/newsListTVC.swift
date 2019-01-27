//
//  newsListTVC.swift
//  theBestApp
//
//  Created by Ashot on 1/21/19.
//  Copyright © 2019 Ashot. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire
import RSLoadingView

class newsListTVC: UITableViewController {
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var centerLoadingView: UIView!
    var currentNews: newsModel?
    
    override func loadView() {
        super.loadView()
        let loadingViewRS = RSLoadingView(effectType: RSLoadingView.Effect.twins)
        loadingViewRS.mainColor = UIColor.green
        loadingViewRS.show(on: view)
        centerLoadingView.addSubview(loadingViewRS)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get(offset: offset, limit: 12, completion: {(success) in
            if (success) {
                self.tableView.reloadData()
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNews", for: indexPath)
        let newsCell: newsModel? = newsArray![indexPath.row]
        cell.textLabel?.text = newsCell!.title
        cell.detailTextLabel?.text = newsCell!.provider
        let imgCell: UIImageView = UIImageView(frame: CGRect(x: 16, y: 5, width: 32, height: 32))
        let urlKey = newsCell!.imgURL!
        if let url = URL(string: urlKey){
            do {
                let data = try Data(contentsOf: url)
                imgCell.image = UIImage(data: data)
                cell.addSubview(imgCell)
            }catch let err {
                print("error: \(err.localizedDescription)")
            }
        }
        
        loadingView.removeFromSuperview()
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentNews = newsArray![indexPath.row]
        performSegue(withIdentifier: "segueNewsDeital", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest: newsDeitalVC = segue.destination as! newsDeitalVC
        dest.currentNews = currentNews
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        get(offset: offset + 12, limit: 12, completion: {(success) in
            if (success) {
                self.tableView.reloadData()
            }
        })
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = (scrollView.contentOffset.y > 100)
    }
}
