//
//  WebViewController+Navigation.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 11/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import WebKit

extension WebViewController: WKNavigationDelegate {
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
                return
            }
        }
        
        connectionBanner?.dismiss()
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        connectionBanner?.dismiss()
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showNoConnectionBanner()
    }
}
