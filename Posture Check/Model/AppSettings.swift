//
//  AppSettings.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 9/22/22.
//

import Combine
import Foundation
import SwiftUI

@MainActor class AppSettings: ObservableObject {
    @Published var isNewUser: Bool {
        didSet {
            if let encoded = try? JSONEncoder().encode(isNewUser) {
                UserDefaults.standard.set(encoded, forKey: Keys.isNewUser)
            }
        }
    }
    
    @Published var dateInstalled: Date {
        didSet {
            if let encoded = try? JSONEncoder().encode(dateInstalled){
                UserDefaults.standard.set(encoded, forKey: Keys.dateInstalled)
            }
        }
    }
    
    //    @Published var appAccent: Color {
    //        didSet {
    //            if let encoded = try? JSONEncoder().encode(appAccent) {
    //                UserDefaults.standard.set(encoded, forKey: Keys.appAccent)
    //            }
    //        }
    //    }
    
    @Published var activeFrom: DateComponents {
        didSet {
            if let encoded = try? JSONEncoder().encode(activeFrom) {
                UserDefaults.standard.set(encoded, forKey: Keys.activeFrom)
            }
        }
    }
    
    @Published var activeUpTo: DateComponents {
        didSet {
            if let encoded = try? JSONEncoder().encode(activeUpTo) {
                UserDefaults.standard.set(encoded, forKey: Keys.activeUpTo)
            }
        }
    }
    
    init() {
        let userDefaults = UserDefaults.standard
        
        guard let savedIsNewUser = userDefaults.data(forKey: Keys.isNewUser),
              let savedDateInstalled = userDefaults.data(forKey: Keys.dateInstalled),
              let savedActiveFrom = userDefaults.data(forKey: Keys.activeFrom),
              let savedActiveUpTo = userDefaults.data(forKey: Keys.activeUpTo)
        else {
            // Giving defaults values to the UserDefault
         

            var activeFromTemp = DateComponents()
            activeFromTemp.hour = 8
            activeFromTemp.minute = 0
            
            var activeUpToTemp = DateComponents()
            activeUpToTemp.hour = 17
            activeUpToTemp.minute = 0
            
            
            self.isNewUser = true
            self.dateInstalled = Date.now
            //        self.appAccent = UserDefaults.standard.object(forKey: Keys.appAccent) as? Color ?? .indigo
            self.activeFrom = activeFromTemp
            self.activeUpTo = activeUpToTemp
            
            print("User Defaults Ready")
            
            UserDefaults.standard.synchronize()
            return
        }
        
        let decoder = JSONDecoder()
        
        let decodedIsNewUserActive = try! decoder.decode(Bool.self, from: savedIsNewUser)
        self.isNewUser = decodedIsNewUserActive
        
        
        let decodedDateInstalled = try! decoder.decode(Date.self, from: savedDateInstalled)
        self.dateInstalled = decodedDateInstalled
        
        
        let decodedActiveFrom = try! decoder.decode(DateComponents.self, from: savedActiveFrom)
        self.activeFrom = decodedActiveFrom
        
        
        let decodedActiveUpTo = try! decoder.decode(DateComponents.self, from: savedActiveUpTo)
        self.activeUpTo = decodedActiveUpTo
        
        print("User Defaults Ready")
    }
}
