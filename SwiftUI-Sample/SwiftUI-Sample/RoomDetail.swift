//
//  RoomDetail.swift
//  SwiftUI-Sample
//
//  Created by Berdil İlyada Karacam on 8.06.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct RoomDetail : View {
    var room: Room
    @State private var zoomed = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
                Image(room.imageName)
                    .resizable()
                    .aspectRatio(contentMode: zoomed ? .fill : .fit)
                    .tapAction {
                        withAnimation(.spring()) { self.zoomed.toggle() }
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight:
                        0, maxHeight: .infinity)
                    
                .navigationBarTitle(Text(room.name), displayMode: .inline)
            if room.hasVideo && !zoomed {
                Image(systemName: "video.fill")
                    .font(.title)
                    .transition(.move(edge: .top))
                    .padding(.all)
            }
        }
    }
}

#if DEBUG
struct RoomDetail_Previews : PreviewProvider {
    static var previews: some View {
        RoomDetail(room: testData[0])
    }
}
#endif
