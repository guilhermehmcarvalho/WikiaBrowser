//
//  WikisTableViewController.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import DropDown

class WikisTableViewController: UIViewController {
    
    // MARK: - Variables
    
    let service = WikiService()
    var wikiItems: [WikiaItem] = []
    var page = 0
    let dropdown = DropDown()
    var langButton: UIBarButtonItem!
    var selectedLanguage: Language = .all
    weak var tableView: UITableView!
    
    // Flag if there is a pending request
    fileprivate var isLoading = false
    // Flag if current items on display are already from cached data
    fileprivate var cached = false

    var refreshControl: UIRefreshControl? {
        get {return self.tableView.refreshControl }
        set { tableView.refreshControl = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Top Wikis"
        
        self.configureLangButton()
        self.configureTableView()
        
        service.delegate = self
        
        getWikiItems()
    }
    
    // MARK: - private
    
    private func configureTableView() {
        self.view = UITableView(frame: CGRect.zero, style: .plain)
        self.tableView = self.view as? UITableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.register(UINib(nibName: "WikiTableViewCell", bundle: nil),
                                forCellReuseIdentifier: WikiTableViewCell.reuseIdentifier)
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshWikiItems(_:)), for: .valueChanged)
        refreshControl?.tintColor = UIColor.App.darkGray
    }
    
    @objc func refreshWikiItems(_ sender: Any?) {
        // Fetch Weather Data
        page = 0
        getWikiItems()
    }
    
    // MARK: - Public
    
    func getWikiItems() {
        if !isLoading {
            service.getTopWikis(page: page, language: selectedLanguage)
            refreshControl?.beginRefreshing()
            print("page \(page)")
            refreshControl?.beginRefreshing()
            isLoading = true
        }
    }
}

// MARK: - WikiServiceDelegate

extension WikisTableViewController: WikiServiceDelegate {
    
    func requestDidComplete(_ items: [WikiaItem]) {
        if page == 0 {
            self.wikiItems = items
        } else {
            self.wikiItems.append(contentsOf: items)
        }
        
        page += 1
        isLoading = false
        cached = false
        refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    func requestDidComplete(cachedItems: [WikiaItem], failure: ServiceFailureType) {
        print("requestDidComplete fail \(failure)")
        if !cached {
            self.wikiItems = cachedItems
            self.tableView.reloadData()
        }
        refreshControl?.endRefreshing()
        isLoading = false
        cached = true
    }
}
