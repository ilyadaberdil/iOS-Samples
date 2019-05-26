//
//  ViewController.swift
//  TableViewLazyLoading
//
//  Created by Berdil İlyada Karacam on 13.04.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: Enums
    enum SectionType {
        case indicatorSection
        case sampleDataSection
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.register(IndicatorTableViewCell.self, forCellReuseIdentifier: IndicatorTableViewCell.classForCoder().description())
            tableView.sectionHeaderHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableView.automaticDimension
            
            refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
            refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh!!")
            
            refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
    }

    
    // MARK: Variables-Constants
    private var refreshControl = UIRefreshControl()
  
    var myList: [String] = [] //sample data
    let sectionList: [SectionType] = [
       // .indicatorSection, //for update data -- Alternative for RefreshControl
        .sampleDataSection, //for sample data
        .indicatorSection] //for load more data
    
    var shouldLoad: Bool = false
    var shouldUpdate: Bool = false
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lazy Loading"
        appendItemsIntoList(itemCount: 20)
    }
    
    
    // MARK: Helper Functions
    func appendItemsIntoList(itemCount: Int) {
        let count = myList.count
        for i in 1...itemCount {
            myList.append("Sample Item \(count + i)")
        }
    }
    
    func loadMoreData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.appendItemsIntoList(itemCount: 10)
            self.shouldLoad = false
            self.tableView.reloadData()
        }
    }
    
    @objc func updateData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.myList = self.myList.map({ (text) -> String in
                guard let index = self.myList.firstIndex(of: text) else { return ""}
                return "Updated Sample Item \(index + 1)"
            })
           // self.shouldUpdate = false -- Alternative for RefreshControl
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
}

//MARK: TableViewDelegate Extension
extension ViewController: UITableViewDelegate {
    
}

//MARK: TableViewDataSource Extensions
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionList[section] {
        case .indicatorSection:
            if shouldUpdate || shouldLoad {
                return 1
            }
        case .sampleDataSection:
            return myList.count
        }
        return 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sectionList[indexPath.section] {
        case .indicatorSection:
            if shouldUpdate || shouldLoad {
                let indicatorCell = IndicatorTableViewCell()
                indicatorCell.startLoadingAnimation()
                return indicatorCell
            }
        case .sampleDataSection:
            let cell = UITableViewCell()
            cell.textLabel?.text = myList[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}

//MARK: ScrollViewDelegate Extensions
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        print("OffsetY: \(offSetY), ContentHeight: \(contentHeight), scrollViewHeight: \(scrollView.frame.height) - \(UIScreen.main.bounds.height - (view.safeAreaInsets.bottom + view.safeAreaInsets.top) )")
        
        // load more data
        if offSetY + scrollView.frame.height > contentHeight {
            if !shouldLoad {
                shouldLoad = true
                tableView.reloadData()
                loadMoreData()
            }
        }
        
        // update data -- Alternative for UIRefreshControl
//        if offSetY < -100 {
//            if !shouldUpdate {
//                shouldUpdate = true
//                tableView.reloadData()
//                updateData()
//            }
//        }
    }
}
