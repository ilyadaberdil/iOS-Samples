//
//  UserDefault+Extension.swift
//  UserDefaults
//
//  Created by Berdil İlyada Karacam on 31.03.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setSwitchIsOpen(isOnList: [String]) {
        set(isOnList, forKey: "IS_OPEN")
    }
    
    func getSwitchIsOpen() -> [String]? {
        guard let isOnList = array(forKey: "IS_OPEN") as? [String] else { return nil }
        return isOnList
    }
    
    
    func setSelectedName(name: String) {
        set(name, forKey: "NAME" )
    }
    
    func getSelectedName() -> String? {
        guard let name = string(forKey: "NAME") else { return nil }
        return name
    }
}
