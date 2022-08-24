//
//  DetailViewController.swift
//  NewsAppFinal
//
//  Created by Abdurrahman Karaoluk on 8.05.2022.
//

import UIKit
import SWXMLHash
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imageNews: UIImageView!
    var newsModel: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async { [self] in
            lblDescription.text = newsModel?.description
            lblTitle.text = newsModel?.title
            let url = URL(string: (newsModel?.imageUrl)!)!
            imageNews.kf.setImage(with: url)
        }
            
            
        
        
    }
  
    @IBAction func showPageTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toWeb", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeb" {
            let detailVC = segue.destination as! WebViewController
            detailVC.link = newsModel?.link
        }
    }
    

}
