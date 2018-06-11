//
//  WebViewController.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 10/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import WebKit
import NotificationBannerSwift

class WebViewController: UIViewController {

    // MARK: - Variables
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var webView = WKWebView()
    internal var url: URL!
    var connectionBanner: NotificationBanner?
    
    var prefix: String {
        guard let prefix = url?.absoluteString else {
            fatalError("Could not get url prefix")
        }
        return prefix
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.url != nil else {
            fatalError("no URL was defined")
        }
        
        self.view.addSubview(webView)
        self.view.addSubview(activityIndicator)
        
        configWebView()
        configBackButton()
        configActivityIndicator()
        
        webView.load(NSURLRequest(url: url) as URLRequest)
        activityIndicator.startAnimating()
    }
    
    // MARK: - Private
    
    private func configWebView() {
        webView.frame = view.frame
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.allowsBackForwardNavigationGestures = false
        webView.navigationDelegate = self
    }
    
    private func configActivityIndicator() {
        activityIndicator.color = UIColor.App.darkGray
        activityIndicator.hidesWhenStopped = true
    }
    
    private func configBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(customGoBack))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.hidesBackButton = false
    }
    
    @objc func customGoBack(sender: UIButton) {
        if self.webView.canGoBack {
            self.webView.goBack()
            self.webView.reload()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func refreshPage() {
        let refresh: URL! = self.webView.url ?? self.url
        let request = NSURLRequest(url: refresh) as URLRequest
        webView.load(request)
        self.connectionBanner?.dismiss()
        self.activityIndicator.startAnimating()
    }
    
    // MARK: - Public
    
    func showNoConnectionBanner() {
        connectionBanner = NotificationBanner(title: "No internet connection",
                                              subtitle: "Press to retry", style: .warning)
        connectionBanner?.onTap = { self.refreshPage() }
        connectionBanner?.autoDismiss = false
        connectionBanner?.show(bannerPosition: .bottom)
    }
}
