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
    @Published var dateInstalled: Date
    @Published var activeFrom: DateComponents
    @Published var activeUpTo: DateComponents
    
    init() {
        let userDefaults = UserDefaults.standard
        
        guard let savedDateInstalled = userDefaults.data(forKey: Keys.dateInstalled),
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
            
            self.dateInstalled = Date.now
            self.activeFrom = activeFromTemp
            self.activeUpTo = activeUpToTemp
            save()
            print("User Defaults Ready")
            return
        }
        
        let decoder = JSONDecoder()
        
        let decodedDateInstalled = try! decoder.decode(Date.self, from: savedDateInstalled)
        self.dateInstalled = decodedDateInstalled
        
        
        let decodedActiveFrom = try! decoder.decode(DateComponents.self, from: savedActiveFrom)
        self.activeFrom = decodedActiveFrom
        
        
        let decodedActiveUpTo = try! decoder.decode(DateComponents.self, from: savedActiveUpTo)
        self.activeUpTo = decodedActiveUpTo
        
        print("User Defaults Ready")
    }
    
    func setActiveHours(from date: DateComponents) {
        objectWillChange.send()
        
        activeFrom = date
        save()
    }
    
    func setActiveHours(upTo date: DateComponents) {
        objectWillChange.send()
        
        activeUpTo = date
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        let userDefaults = UserDefaults.standard
        
        do {
            let encodedDateInstalled = try encoder.encode(dateInstalled)
            userDefaults.set(encodedDateInstalled, forKey: Keys.dateInstalled)
            
            let encodedActiveFrom = try encoder.encode(activeFrom)
            userDefaults.set(encodedActiveFrom, forKey: Keys.activeFrom)
            
            let encodedActiveUpTo = try encoder.encode(activeUpTo)
            userDefaults.set(encodedActiveUpTo, forKey: Keys.activeUpTo)
        } catch {
            fatalError("Error saving app settings...")
        }
    }
}
