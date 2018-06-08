//
//  WikisTableViewController.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit

class WikisTableViewController: UITableViewController, WikiServiceDelegate {
    
    let service = WikiService()
    var wikiItems: [WikiaItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTitle()
        tableView.register(UINib(nibName: "WikiTableViewCell", bundle: nil),
                           forCellReuseIdentifier: WikiTableViewCell.reuseIdentifier)
        service.delegate = self
        service.getTopWikis()
    }
    
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
    
    func requestDidComplete(_ items: [WikiaItem]) {
        self.wikiItems = items
        print(items)
        self.tableView.reloadData()
    }
    
    func requestDidComplete(cachedItems: [WikiaItem], failure: ServiceFailureType) {
        self.wikiItems = cachedItems
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
