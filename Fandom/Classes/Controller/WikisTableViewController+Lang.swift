//
//  WikisTableViewController+Lang.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 10/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit

extension WikisTableViewController {
    
    func configureLangButton() {
        langButton = UIBarButtonItem(title: "Lang", style: .plain, target: self, action: #selector(langTapped))
        navigationItem.rightBarButtonItem = langButton
        dropdown.anchorView = langButton
        dropdown.dataSource = Language.allNames
        dropdown.textColor = UIColor.white
        dropdown.backgroundColor = UIColor.App.darkGray
        dropdown.selectionBackgroundColor = UIColor.App.lightGray
        dropdown.width = 80.0
        
        dropdown.selectionAction = {(index: Int, item: String) in
            if let language = Language(rawValue: index) {
                self.selectedLanguage = language
            }
            self.refreshWikiItems(nil)
        }
        
        if let font = UIFont(name: "Rubik-Regular", size: 20) {
            let atributes = [NSAttributedStringKey.font: font]
            self.navigationController?.navigationBar.titleTextAttributes = atributes
            dropdown.textFont = font.withSize(15)
        }
    }
    
    @objc private func langTapped(_ sender: Any) {
        self.dropdown.show()
    }
}
