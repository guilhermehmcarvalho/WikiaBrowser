//
//  WikisTableViewController.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import DropDown

class WikisTableViewController: UITableViewController {
    
    // MARK: - Variables
    
    fileprivate let service = WikiService()
    fileprivate var wikiItems: [WikiaItem] = []
    var page = 0
    let dropdown = DropDown()
    var langButton: UIBarButtonItem!
    var selectedLanguage: Language = .all
    
    // Flag if there is a pending request
    fileprivate var isLoading = false
    // Flag if current items on display are already from cached data
    fileprivate var cached = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTitle()
        self.configureLangButton()
        
        tableView.register(UINib(nibName: "WikiTableViewCell", bundle: nil),
                           forCellReuseIdentifier: WikiTableViewCell.reuseIdentifier)
        service.delegate = self
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshWikiItems(_:)), for: .valueChanged)
        
        getWikiItems()
    }
    
    // MARK: - private
    
    private func configureTitle() {
        if let font = UIFont(name: "Rubik-Regular", size: 20) {
            let atributes = [NSAttributedStringKey.font: font]
            self.navigationController?.navigationBar.titleTextAttributes = atributes
        }
        self.navigationController?.navigationBar.barTintColor = UIColor.App.darkGray
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Top Wikis"
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wikiItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WikiTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? WikiTableViewCell else {
                fatalError("Unexpected Index Path")
        }

        cell.configureWith(wikiItems[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wikia = wikiItems[indexPath.row]
        if let wikiaLink = wikia.url, let url = URL(string: wikiaLink) {
            UIApplication.shared.open(url)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        guard let isRefreshing = refreshControl?.isRefreshing else {
            fatalError("No refresh control")
        }
        
        if indexPath.row == wikiItems.count - 1 && !isRefreshing {
            self.getWikiItems()
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
