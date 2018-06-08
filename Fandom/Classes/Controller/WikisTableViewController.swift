//
//  WikisTableViewController.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit

class WikisTableViewController: UITableViewController {
    
    // MARK: - Variables
    
    let service = WikiService()
    var wikiItems: [WikiaItem] = []
    var page = 1
    var loadingItems = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTitle()
        tableView.register(UINib(nibName: "WikiTableViewCell", bundle: nil),
                           forCellReuseIdentifier: WikiTableViewCell.reuseIdentifier)
        service.delegate = self
        loadingItems = true
        service.getTopWikis()
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
        if indexPath.row == wikiItems.count - 1 && !loadingItems {
            page += 1
            service.getTopWikis(page: page)
            print("page \(page)")
        }
    }
    
}

// MARK: - WikiServiceDelegate

extension WikisTableViewController: WikiServiceDelegate {
    
    func requestDidComplete(_ items: [WikiaItem]) {
        loadingItems = false
        self.wikiItems.append(contentsOf: items)
        self.tableView.reloadData()
    }
    
    func requestDidComplete(cachedItems: [WikiaItem], failure: ServiceFailureType) {
        print("requestDidComplete fail \(failure)")
        loadingItems = false
        //self.wikiItems = cachedItems
        self.tableView.reloadData()
    }
}
