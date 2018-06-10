//
//  MainViewController.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 10/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import Parchment

class MainViewController: UIViewController {
    
    var wikis: WikisTableViewController! {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "table")
            as? WikisTableViewController else {
            fatalError("Could not find view controller")
        }
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pagingViewController = PagingViewController<FilterItem>()
        pagingViewController.infiniteDataSource = self
        pagingViewController.delegate = self
        pagingViewController.textColor = UIColor.black
        
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        
        pagingViewController.didMove(toParentViewController: self)
        pagingViewController.select(pagingItem: FilterItem(title: "A"))
    }
}

extension MainViewController: PagingViewControllerInfiniteDataSource {
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>,
                                 viewControllerForPagingItem: T) -> UIViewController
        where T: PagingItem, T: Comparable, T: Hashable {
        return wikis
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>,
                                 pagingItemBeforePagingItem pagingItem: T) -> T?
        where T: PagingItem, T: Comparable, T: Hashable {
        return FilterItem(title: "a") as? T
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>,
                                 pagingItemAfterPagingItem pagingItem: T) -> T?
        where T: PagingItem, T: Comparable, T: Hashable {
        return FilterItem(title: "a") as? T
    }
}

struct FilterItem: PagingItem, Hashable, Comparable {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var hashValue: Int {
        return title.hashValue
    }
    
    static func == (lhs: FilterItem, rhs: FilterItem) -> Bool {
        return lhs.title == rhs.title
    }
    
    static func < (lhs: FilterItem, rhs: FilterItem) -> Bool {
        return lhs.title < rhs.title
    }
}

extension MainViewController: PagingViewControllerDelegate {
    
    // We want the size of our paging items to equal the width of the
    // city title. Parchment does not support self-sizing cells at
    // the moment, so we have to handle the calculation ourself. We
    // can access the title string by casting the paging item to a
    // PagingTitleItem, which is the PagingItem type used by
    // FixedPagingViewController.
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>,
                                 widthForPagingItem pagingItem: T, isSelected: Bool) -> CGFloat? {
        guard let item = pagingItem as? FilterItem else { return 0 }
        
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: pagingViewController.menuItemSize.height)
        let attributes = [NSAttributedStringKey.font: pagingViewController.font]
        
        let rect = item.title.boundingRect(with: size,
                                           options: .usesLineFragmentOrigin,
                                           attributes: attributes,
                                           context: nil)
        
        let width = ceil(rect.width) + insets.left + insets.right
        
        if isSelected {
            return width * 1.5
        } else {
            return width
        }
    }
    
}
