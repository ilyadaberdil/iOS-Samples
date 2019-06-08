//
//  ContentView.swift
//  SwiftUI-Sample
//
//  Created by Berdil İlyada Karacam on 8.06.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObjectBinding var roomStore = RoomStore(rooms: testData)
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Header"), footer: Text("Footer")) {
                    Button(action: addRoom) {
                        Text("Add New Room")
                    }
                }
                
                Section(header: Text("Header"), footer: Text("Footer")) {
                    
                    ForEach(roomStore.rooms) { room in
                        RoomCell(room: room)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                .background(Color.clear)
            }
            .navigationBarTitle(Text("Rooms"))
            .navigationBarItems(trailing: EditButton())
            .listStyle(.grouped)
        }
    }
    func addRoom() {
        roomStore.rooms.append(.init(name: "New Room", capacity: 1995))
    }
    
    func delete(at offset: IndexSet) {
        guard let intindex = Array(offset).first else { return }
        roomStore.rooms.remove(at: intindex)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        guard let sourceIndex = Array(source).first else { return }
        roomStore.rooms.insert(roomStore.rooms.remove(at: sourceIndex), at: destination)
    }
}
struct RoomCell : View {
    let room: Room
    
    var body: some View {
        return NavigationButton(destination: RoomDetail(room: room)) {
            Image(room.thumbnailName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text(room.name)
                Text("\(room.capacity) people")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(roomStore: RoomStore(rooms: testData))
    }
}
#endif
