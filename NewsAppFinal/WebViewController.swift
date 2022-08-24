//
//  WebViewController.swift
//  NewsAppFinal
//
//  Created by Abdurrahman Karaoluk on 8.05.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var web: WKWebView!
    var link: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: link!)!
        web.load(URLRequest(url: url))
    }
    
    
}
