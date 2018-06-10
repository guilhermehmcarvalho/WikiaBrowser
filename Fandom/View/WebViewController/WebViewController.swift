//
//  WebViewController.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 10/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    let webView = WKWebView()
    internal var url: URL?
    
    var prefix: String {
        return Bundle.main.apiBaseUrl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = self.url else {
            fatalError("no URL was defined")
        }
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.load(NSURLRequest(url: url) as URLRequest)
        view = webView
    }
}
