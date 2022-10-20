//
//  Achievement.swift
//  Posture Check
//
//  Created by Juancarlos Moldes on 9/28/22.
//
import SwiftUI

class Achievement: Codable, Equatable, Identifiable {
    
    var id = UUID()
    let name: String
    let description: String
    var isAchieved: Bool
    var dateAchieved: Date?
    let xpRequired: Int
    let type: AchievementType
    
    var symbol: String {
        switch type {
        case .journeyStarter:
           return "backpack"
                
        case .bronze, .silver, .gold:
            return "medal"
                
        case .diamond:
            return "diamond"
                
        case .sapphire:
            return "diamond.lefthalf.filled"
                
        case .platinum:
            return "diamond.inset.filled"
                
        }
        
    }
    
    var symbolColor: Color {
        switch type {
        case .journeyStarter:
            return .red
        case .bronze:
            return .brown
        case .silver:
            return .gray
        case .gold:
            return .yellow
        case .diamond, .sapphire, .platinum:
            return .cyan
        }
    }
    
    init(id: UUID = UUID(), name: String, description: String, isAchieved: Bool, dateAchieved: Date? = nil, xpRequired: Int, type: AchievementType) {
        self.id = id
        self.name = name
        self.description = description
        self.isAchieved = isAchieved
        self.dateAchieved = dateAchieved
        self.xpRequired = xpRequired
        self.type = type
    }
    
    enum AchievementType: Codable {
        case journeyStarter, bronze, silver, gold, diamond ,sapphire, platinum
    }
    
    static func == (lhs: Achievement, rhs: Achievement) -> Bool {
        lhs.id == rhs.id
    }
    
    var objDescription: String {
        return """
        id: \(id)
        name: \(name)
        description: \(description)
        isAchieved: \(isAchieved)
        """
    }
    
    static var example: Achievement {
        Achievement(name: "The Posture Checker", description: "This achievement is not real and only for testing.", isAchieved: false, xpRequired: 1000, type: .journeyStarter)
    }
}

@MainActor class Achievements: ObservableObject {
    @Published private(set) var achievements: [Achievement]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent(Keys.achievements)
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            achievements = try JSONDecoder().decode([Achievement].self, from: data)
        } catch {
            achievements = Achievements.fillAchievements()
            save()
        }
    }
    
    static func fillAchievements() -> [Achievement] {
        return [
            Achievement(name: "Journey Starter", description: "For starting your journey of improving your posture.", isAchieved: false, xpRequired: 5, type: .journeyStarter),
            Achievement(name: "Bronze", description: "Achievable by gaining at least 72 xp", isAchieved: false, xpRequired: 72, type: .bronze),
            Achievement(name: "Silver", description: "Achievable by gaining at least 126 xp", isAchieved: false, xpRequired: 126, type: .silver),
            Achievement(name: "Gold", description: "Achievable by gaining at least 252 xp", isAchieved: false, xpRequired: 252, type: .gold),
            Achievement(name: "Diamond", description: "Achievable by gaining at least 590 xp", isAchieved: false, xpRequired: 590, type: .diamond),
            Achievement(name: "Sapphire", description: "Achievable by gaining at least 720 xp", isAchieved: false, xpRequired: 720, type: .sapphire),
            Achievement(name: "Platinum", description: "Achievable by gaining at least 840 xp", isAchieved: false, xpRequired: 840, type: .platinum)
        ]
    }
    
    func markAsAchieved(_ achievement: Achievement) {
        guard let index = achievements.firstIndex(of: achievement) else {
            fatalError("Couldn't find the achievement!")
        }
        
        objectWillChange.send()
        achievements[index].isAchieved = true
        achievements[index].dateAchieved = Date.now
        save()
    }
    
    func checkIfAnyAchievementIsAchievableWith(_ xp: Int) {
        for achievement in achievements {
            if achievement.xpRequired <= xp && !achievement.isAchieved {
            markAsAchieved(achievement)
            }
        }
    }
    
    func save() {
        do {
            let encodedAchievements = try JSONEncoder().encode(achievements)
            try encodedAchievements.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            fatalError("Error saving achievements")
        }
    }
}
