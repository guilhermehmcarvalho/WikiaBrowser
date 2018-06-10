//
//  WikisTableViewController+Table.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 10/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit

extension WikisTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wikiItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WikiTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? WikiTableViewCell else {
                                                        fatalError("Unexpected Index Path")
        }
        
        cell.configureWith(wikiItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wikia = wikiItems[indexPath.row]
        let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
        
        if let wikiaLink = wikia.url?.replacingOccurrences(of: "http://", with: "https://"),
            let url = URL(string: wikiaLink) {
            viewController.url = url
            viewController.title = wikia.name
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        guard let isRefreshing = refreshControl?.isRefreshing else {
            fatalError("No refresh control")
        }
        
        if indexPath.row == wikiItems.count - 1 && !isRefreshing {
            self.getWikiItems()
        }
    }
    
}
