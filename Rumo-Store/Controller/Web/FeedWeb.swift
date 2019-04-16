//
//  FeedWeb.swift
//  Rumo-Store
//
//  Created by  Snow on 16/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit
import WebKit


class FeedWeb: UIViewController {
    
    @IBOutlet weak var carregar: UIActivityIndicatorView!
    @IBOutlet weak var webview: WKWebView!
    var selectedFeedURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n", with:"")
        webview.load(URLRequest(url: URL(string: selectedFeedURL! as String)!))
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if webview.isLoading {
                carregar.startAnimating()
                carregar.isHidden = false
                
            }else {
                carregar.stopAnimating()
            }
        }
    }
    

}
