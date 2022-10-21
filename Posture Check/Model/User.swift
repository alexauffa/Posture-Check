//
//  User.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 10/8/22.
//
import SwiftUI

@MainActor class User: ObservableObject {
    @Published var exercises: Exercises
    @Published var achievements: Achievements
    @Published private (set) var XP: Int
    
    // add last date logged
    let savePath = FileManager.documentsDirectory.appendingPathComponent(Keys.userXP)
     
    func checkIfEligibleForNewExercise() {
        if exercises.isDailyExerciseAlreadyDone {
            exercises.unlockNewExercise()
        }
    }
    
    func markAsDone(_ exercise: Exercise) {
        objectWillChange.send()
        XP += exercise.xp
        exercises.markAsDone(exercise)
        achievements.checkIfAnyAchievementIsAchievableWith(XP)
        checkIfEligibleForNewExercise()
        save()
    }
    
    init() {
        do {
            exercises = Exercises()
            achievements = Achievements()
            let data = try Data(contentsOf: savePath)
            XP = try JSONDecoder().decode(Int.self, from: data)
        } catch {
            XP = 0
            save()
        }
    }
    
    func save() {
        do {
            let encodedXP = try JSONEncoder().encode(XP)
            try encodedXP.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            fatalError("Error saving XP.")
        }
    }
}
