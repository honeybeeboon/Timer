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
    @State private var didShow: Bool = false
    @State private var didStart: Bool = false
    @State private var didStop: Bool = false
    //    private var timer: Timer?
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            if !self.didStop {
                self.timeUpdate(self.hour * 60 * 60 + self.minute * 60 + self.second)
            }
        }
    }
    var body: some View {
        GeometryReader { geometry in
   
                VStack(spacing: 0){
                    HStack(spacing: 0){
                        if !self.didShow {
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
                                .position(x: geometry.size.width/2,y:geometry.size.height/10)
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
                                    self.timer.invalidate()
                                    self.didStop.toggle()
                                    self.hour = 0
                                    self.minute = 0
                                    self.second = 0
                                    if self.didShow && self.didStart{
                                        self.didShow.toggle()
                                        self.didStart.toggle()
                                    } else if self.didShow && !self.didStart{
                                        self.didShow.toggle()
                                    }
                                    
                                    
                            }
                            }.position(x:90,y: geometry.size.height / 10)
                        Button(action: {}) {
                            if !self.didStart && !self.didShow{
                                Text("開始")
                                    .color(Color.black)
                                    .font(.largeTitle)
                                    .frame(width: 90.0, height: 90.0)
                                    .background(Color.green ,cornerRadius: Length(100))
                                    .tapAction {
                                        if self.didStop {
                                            self.didStop.toggle()
                                        }
                                        if self.hour + self.minute + self.second != 0 {
                                            _ = self.timer
                                            self.didStart.toggle()
                                            self.didShow.toggle()
                                        }
                                        
                                }
                            }else if self.didStart && self.didShow{
                                Text("停止")
                                    .color(Color.black)
                                    .font(.largeTitle)
                                    .frame(width: 90.0, height: 90.0)
                                    .background(Color.red ,cornerRadius: Length(100))
                                    .tapAction {
                                        self.didStop.toggle()
                                        self.timer.invalidate()
                                        self.didStart.toggle()
                                }
                            }else if !self.didStart && self.didShow{
                                Text("再開")
                                    .color(Color.black)
                                    .font(.largeTitle)
                                    .frame(width: 90.0, height: 90.0)
                                    .background(Color.yellow ,cornerRadius: Length(100))
                                    .tapAction {
                                        self.didStop.toggle()
                                        self.didStart.toggle()
                                }
                            }
                            }.position(y: geometry.size.height/10)
                    }
                    
            }
        }
    }
    
    private func timeUpdate(_ times: Int){
        let timeSeconds = times - 1
        if timeSeconds <= 0 {
            second = 0
            self.timer.invalidate()
        } else {
            if timeSeconds % 2 == 0 {
                
            }
            
            if timeSeconds > 3599 {
                hour = Int(timeSeconds / (60 * 60))
                if timeSeconds - hour * 60 * 60 > 59{
                    minute = Int((timeSeconds - hour * 60 * 60) / 60)
                    second = Int((timeSeconds - hour * 60 * 60) % 60)
                }
            } else {
                minute = Int(timeSeconds / 60)
                second = Int(timeSeconds % 60)
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

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
