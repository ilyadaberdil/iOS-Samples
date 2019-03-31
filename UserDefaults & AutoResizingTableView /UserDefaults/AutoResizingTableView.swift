//
//  AutoResizingTableView.swift
//  UserDefaults
//
//  Created by Berdil İlyada Karacam on 31.03.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import Foundation
import UIKit

class AutoSizingTableView : UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
