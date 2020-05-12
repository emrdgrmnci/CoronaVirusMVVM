//
//  NetworkReachability.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 15.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import Reachability

class NetworkReachability {

   private let internetReachability : Reachability?
   var isReachable : Bool = false

   init() {

       self.internetReachability = try? Reachability.init()
       do{
           try self.internetReachability?.startNotifier()
           NotificationCenter.default.addObserver(self, selector: #selector(self.handleNetworkChange), name: .reachabilityChanged, object: internetReachability)
       }
       catch {
        print("could not start reachability notifier")
       }
   }

   @objc private func handleNetworkChange(notify: Notification) {

       let reachability = notify.object as! Reachability
       if reachability.connection != .unavailable {
           self.isReachable = true
       }
       else {
           self.isReachable = false
       }
       print("Internet Connected : \(self.isReachable)") 
   }
}
