//
//  ContentView.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 8/27/22.
//

// MARK: File Description
/*
 Host all views of app Posture Check enclosed in a TabView.
 Each ObservedObject will be pass as environment object to avoid repetition an object passing in views initializers.
 */

import SwiftUI
import BackgroundTasks

struct ContentView: View {
    @AppStorage(Keys.hasNotificationsEnabled) var hasNotificationsEnabled: Bool = false
    @AppStorage(Keys.isNewUser) var isNewUser: Bool = true
    @StateObject var appSettings = AppSettings()
    @EnvironmentObject var user: User
    @StateObject var notifications = Notifications()
    @StateObject var questionnaires = Questionnaires()

    var body: some View {
        if isNewUser {
            WelcomeView()
        } else {
            Group {
                if hasNotificationsEnabled {
                    AppTabView()
                } else {
                    NotificationRoadBlockView()
                }
            }
            .environmentObject(user)
            .environmentObject(notifications)
            .environmentObject(appSettings)
            .environmentObject(questionnaires)
            .onAppear {
                notifications.requestForAuthorization()
                
                Task {
                    await print(UNUserNotificationCenter.current().pendingNotificationRequests())
            }
                questionnaires.unlockQuestionnairesPending()
                user.checkIfEligibleForNewExercise()
                user.achievements.checkIfAnyAchievementIsAchievableWith(user.XP)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
