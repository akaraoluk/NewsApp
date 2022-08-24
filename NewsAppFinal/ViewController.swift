//
//  ViewController.swift
//  NewsAppFinal
//
//  Created by Abdurrahman Karaoluk on 8.05.2022.
//

import UIKit
import Alamofire
import SWXMLHash

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var newsTableView: UITableView!
    
    var xml: XMLIndexer?
    var newsModel: [NewsModel]?
    var detailNewsModel: NewsModel?
    
    let refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsModel = []
        
        parser {
            self.newsTableView.dataSource = self
            self.newsTableView.delegate = self
            self.newsTableView.reloadData()
        }
        
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        newsTableView.reloadData()
        sender.endRefreshing()
    }
    
    func parser(completion: @escaping () -> Void) {
        
        AF.request("https://www.aa.com.tr/tr/rss/default?cat=guncel").responseString { response in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                self.xml = XMLHash.parse(utf8Text)
                for elem in self.xml!["rss"]["channel"]["item"].all {
                    let tempNewsModel = NewsModel(title: elem["title"].element?.text, link: elem["link"].element?.text, imageUrl: elem["image"].element?.text, description: elem["description"].element?.text)
                    
                    self.newsModel?.append(tempNewsModel)
                    print(tempNewsModel)
                }
            }
            completion()
        }
    }
    
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = newsModel?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        cell.textLabel?.text = newsModel![indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailNewsModel = NewsModel(title: newsModel![indexPath.row].title, link: newsModel![indexPath.row].link, imageUrl: newsModel![indexPath.row].imageUrl, description: newsModel![indexPath.row].description)
        
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.newsModel = detailNewsModel
        }
    }
}

