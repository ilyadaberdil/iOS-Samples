//
//  RoomStore.swift
//  SwiftUI-Sample
//
//  Created by Berdil İlyada Karacam on 8.06.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI
import Combine

class RoomStore : BindableObject {
    
    var didChange = PassthroughSubject<Void, Never>()

    var rooms: [Room] {
        didSet { didChange.send(()) }
    }
    
    init(rooms: [Room]) {
        self.rooms = rooms
    }
    
}
