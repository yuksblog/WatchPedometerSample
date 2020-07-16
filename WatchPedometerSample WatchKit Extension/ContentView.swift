//
//  ContentView.swift
//  WatchPedometerSample WatchKit Extension
//
//  Created by 今井幸宣 on 2020/07/16.
//  Copyright © 2020 yukinobu.imai. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var pedometer = MyPedometer()
    
    var body: some View {
        VStack {
            if self.pedometer.isWalking {
                Text("WALKING")
            } else {
                Text("STOPPED")
            }
            Text("\(self.pedometer.count)")
            Button(action: {
                if !self.pedometer.isStarted {
                    self.pedometer.start()
                } else {
                    self.pedometer.stop()
                }
            }) {
                if !self.pedometer.isStarted {
                    Text("スタート")
                } else {
                    Text("ストップ")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
