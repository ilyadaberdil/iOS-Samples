//
//  Room.swift
//  SwiftUI-Sample
//
//  Created by Berdil İlyada Karacam on 8.06.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct Room: Identifiable {
    var id = UUID()
    var name: String
    var capacity: Int
    var hasVideo: Bool = false
    
    var imageName: String { return "ninja" }
    var thumbnailName: String { return "geek" }
}

#if DEBUG
let testData = [
    Room(name: "1", capacity: 6, hasVideo: true),
    Room(name: "2", capacity: 5, hasVideo: true),
    Room(name: "3", capacity: 4, hasVideo: true),
    Room(name: "4", capacity: 3, hasVideo: false),
    Room(name: "5", capacity: 2, hasVideo: false),
    Room(name: "6", capacity: 1, hasVideo: false)
]
#endif
