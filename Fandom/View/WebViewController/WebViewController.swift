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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var webView = WKWebView()
    internal var url: URL?
    
    var prefix: String {
        guard let prefix = url?.absoluteString else {
            fatalError("Could not get url prefix")
        }
        return prefix
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = self.url else {
            fatalError("no URL was defined")
        }
        
        self.view.addSubview(webView)
        self.view.addSubview(activityIndicator)
        
        webView.frame = view.frame
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.allowsBackForwardNavigationGestures = false
        webView.navigationDelegate = self
        webView.load(NSURLRequest(url: url) as URLRequest)
        
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor.App.darkGray
        activityIndicator.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // If the user clicks a link that doesn't belong to the selected wiki,
        // we open it outside of the app
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix(prefix),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                print("Open it locally")
                activityIndicator.startAnimating()
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
