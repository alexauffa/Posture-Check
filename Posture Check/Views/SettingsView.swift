//
//  SettingsView.swift
//  Posture Check
//
//  Created by Gamalier Rodriguez Delgado.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State var from: Date
    @State var UpTo: Date
    
    var postureReminders: Int {
        return Notifications().maxNotificationAllowedBetween(from, and: UpTo, type: .postureReminder)
    }
    
    var exerciseReminders: Int {
        return Notifications().maxNotificationAllowedBetween(from, and: UpTo, type: .exerciseReminder)
    }
    
    var restReminders: Int {
        return Notifications().maxNotificationAllowedBetween(from, and: UpTo, type: .restReminder)
    }
    
    init() {
        let appSettings = AppSettings()
        _from = State(initialValue: Calendar.autoupdatingCurrent.date(from: appSettings.activeFrom) ?? Date.now)
        _UpTo = State(initialValue: Calendar.autoupdatingCurrent.date(from: appSettings.activeUpTo) ?? Date.now)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.primary)
                
                Text("Active Hours")
                    .font(.title)

                Form {
                    Section {
                        DatePicker("Starting from", selection: $from, displayedComponents: .hourAndMinute)
                    }
                    
                    Section {
                        DatePicker("Ending at", selection: $UpTo, displayedComponents: .hourAndMinute)
                    } footer: {
                        Text("At this configuration you will receive:\n")
                        +
                        Text("\(postureReminders) Posture Reminders\n")
                        +
                        Text("\(exerciseReminders) Exercises Reminders\n")
                        +
                        Text("\(restReminders) Rest Reminders\n")
                    }
                }
            }
            .navigationTitle(Text("Settings"))
        }
        .onChange(of: from) { newValue in
            let dateComponents = Calendar.autoupdatingCurrent.dateComponents([.hour, .minute], from: from)
            appSettings.setActiveHours(from: dateComponents)
            
            Task {
                await Notifications().generateNotifications()
            }
        }
        .onChange(of: UpTo) { newValue in
            let dateComponents = Calendar.autoupdatingCurrent.dateComponents([.hour, .minute], from: UpTo)
            appSettings.setActiveHours(upTo: dateComponents)
            
            Task {
                await Notifications().generateNotifications()
            }
        }
    }
}

struct SettingsRowView: View {
    var title: String
    var systemImageName: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemImageName)
            Text (title)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppSettings())
    }
}
