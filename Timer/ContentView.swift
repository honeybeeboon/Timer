//
//  ContentView.swift
//  Timer
//
//  Created by 下澤一輝 on 2019/07/27.
//  Copyright © 2019 下澤一輝. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @State private var hour = 0
    var hours : [Int] = ([Int])(0...23)
    @State private var minute = 0
    var minutes : [Int] = ([Int])(0...59)
    @State private var second = 0
    var seconds : [Int] = ([Int])(0...59)
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0){
                HStack{
                    VStack{
                        Picker(selection: self.$hour, label: Text("hours")){
                            ForEach(self.hours) { hour in
                                Text("\(hour)")
                            }
                            }
                            .frame(width: geometry.size.width / 3)
                            .clipped()
                        Text("時間")
                    }
                    VStack{
                        Picker(selection: self.$minute, label: Text("minutes")){
                            ForEach(self.minutes) { minute in
                                Text("\(minute)")
                            }
                            }
                            .frame(width: geometry.size.width / 3)
                            .clipped()
                        Text("分")
                    }
                    VStack{
                        Picker(selection: self.$second, label: Text("seconds")){
                            ForEach(self.seconds) { second in
                                Text("\(second)")
                            }
                            }
                            .frame(width: geometry.size.width / 3)
                            .clipped()
                        Text("秒")
                    }
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
