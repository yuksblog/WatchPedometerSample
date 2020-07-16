//
//  MyPedometer.swift
//  WatchPedometerSample WatchKit Extension
//
//  Created by 今井幸宣 on 2020/07/16.
//  Copyright © 2020 yukinobu.imai. All rights reserved.
//

import UIKit
import CoreMotion

class MyPedometer: NSObject, ObservableObject {
    
    @Published var isStarted = false
    
    @Published var isWalking = false
    
    @Published var count = 0
    
    let pedometer = CMPedometer()
    
    
    
    func start() {
        
        guard !isStarted else {
            return
        }

        isStarted = true
            
        pedometer.startEventUpdates { (event, error) in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                if event!.type == CMPedometerEventType.pause {
                    self.isWalking = false
                } else {
                    self.isWalking = true
                }
            }
        }
        
        pedometer.startUpdates(from: Date()) { (data, error) in
            guard error == nil else {
                print("error \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                self.count = data?.numberOfSteps as! Int
            }
        }
        
    }
    
    func stop() {
        
        guard isStarted else {
            return
        }
        
        isStarted = false
        
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }
    
}
