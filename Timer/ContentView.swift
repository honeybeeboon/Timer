//
//  ContentView.swift
//  Timer
//
//  Created by 下澤一輝 on 2019/07/27.
//  Copyright © 2019 下澤一輝. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @State private var hour: Int = 0
    var hours : [Int] = ([Int])(0...23)
    @State private var minute = 0
    var minutes : [Int] = ([Int])(0...59)
    @State private var second = 0
    var seconds : [Int] = ([Int])(0...59)
    @State private var didTap: Bool = false
    @State private var didStart: Bool = false
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0){
                HStack(spacing: 0){
                    if !self.didTap {
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
                    }else{
                        timerView(hour: self.hour, minute: self.minute, second: self.second)
                            .padding(.top, geometry.size.height/4)
                            .position(x: geometry.size.width/2,y:geometry.size.height/4)
                    }
                }
                HStack(spacing: geometry.size.width-180){
                    Button(action: {}) {
                        Text("キャンセル")
                            .color(Color.black)
                            .font(.body)
                            .frame(width: 90.0, height: 90.0)
                            .background(Color.gray,cornerRadius: Length(100))
                            .tapAction {
                                self.hour = 0
                                self.minute = 0
                                self.second = 0
                                if self.didTap{
                                    self.didTap.toggle()
                                }
                        }
                    }
                    Button(action: {}) {
                        if !self.didStart {
                            Text("開始")
                                .color(Color.black)
                                .font(.largeTitle)
                                .frame(width: 90.0, height: 90.0)
                                .background(Color.green ,cornerRadius: Length(100))
                                .tapAction {
                                    self.didStart.toggle()
                                    self.didTap.toggle()
                                    
                            }
                        }else{
                            Text("停止")
                                .color(Color.black)
                                .font(.largeTitle)
                                .frame(width: 90.0, height: 90.0)
                                .background(Color.yellow ,cornerRadius: Length(100))
                                .tapAction {
                                    self.didStart.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}
struct timerView : View {
    var hour: Int
    var minute: Int
    var second: Int
    var body: some View {
        Text("\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", second))")
            .font(Font.custom("name-of-font", size: 80))
        
    }
}
//timerView(hour: self.hour, minute: self.minute, second: self.second)
//    .padding(.top, geometry.size.height/4)

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
