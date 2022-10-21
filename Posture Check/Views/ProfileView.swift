//
//  ProfileView.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 8/29/22.
//

// MARK: File Description
/*
 This view will be responsible for displaying user profiles details like day in study, level and achievements.
 */

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user: User
    @State private var isShowingSettings = false
    @State private var isShowingPostureCheckUI = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var currentLeague: String {
        switch user.XP {
        case 0..<5:
            return "New User"
        case 5..<72:
            return "Journey Starter"
        case 72..<126:
            return "Bronze"
        case 126..<252:
            return "Silver"
        case 252..<590:
            return "Gold"
        case 590..<720:
            return "Diamond"
        case 720..<840:
            return "Sapphire"
        case 840...:
            return "Platinum"
        default:
            return "New User"
        }
    }
    
    var currentLeagueMaxXp: Double {
        switch user.XP {
        case 0..<5:
            return 5.0
        case 5..<72:
            return 72.0
        case 72..<126:
            return 126.0
        case 126..<252:
            return 252.0
        case 252..<590:
            return 590.0
        case 590..<720:
            return 720.0
        case 720..<840:
            return 840.0
        case 840...:
            return 840.0
        default:
            return 4.0
        }
    }
    
//    var dateProgress: String {
//        let installedDate = settings.dateInstalled
//        let targetDate = installedDate.modifyDateFor(days: 45)
//        
//        return String(Calendar(identifier: .chinese).numberOfDaysBetween(installedDate, and: targetDate))
//    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                                .frame(width: 100, height: 100)
                                .padding(5)
                                .overlay(content: {
                                    Circle()
                                        .stroke(lineWidth: 5)
                                    
                                })
                                .offset(y: 5)
                            
                            VStack {
                                HStack {
                                    Text("User stats")
                                        .font(.callout)
                                        .bold()
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("League: ")
                                    +
                                    Text(currentLeague)
                                        .bold()
                                    
                                    Spacer()
                                }
                                
                                VStack(spacing: 10) {
                                    
                                    
                                    if #available(iOS 16.0, *) {
                                        Gauge(value: 1.0 / 45.0) {
                                            HStack {
                                                Text("Day 1 of 45")
                                                Spacer()
                                            }
                                        }
                                        .padding(.top)
                                        .accentColor(.indigo)
                                        
                                    } else {
                                        // Fallback on earlier versions
                                        ProgressBar(value: .constant(0.5))
                                            .frame(maxHeight: 15)
                                    }
                                    
                                    if #available(iOS 16.0, *) {
                                        Gauge(value: (Double(user.XP) / currentLeagueMaxXp)) {
                                            HStack {
                                                Text("Current xp: ")
                                                +
                                                Text("\(user.XP)")
                                                    .bold()
                                                Spacer()
                                            }
                                        }
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                                .padding(.bottom)
                            }
                        }
                        .frame(height: geometry.size.height * 0.25)
                        .padding(.horizontal)
                        
                        Divider()
                        //                            .frame(height: 15)
                        
                        VStack {
                            HStack {
                                Text("Achievements")
                                    .font(.title)
                                Spacer()
                            }
                            
                            ScrollView(showsIndicators: false) {
                                ForEach(user.achievements.achievements, id: \.id) { achievement in
                                    AchievementView(achievement: achievement)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                Button {
                    isShowingSettings = true
                } label: {
                    Image (systemName: "gear")
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
        }
    }
    
}

struct AchievementView: View {
    var achievement: Achievement
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    if achievement.isAchieved {
                        VStack {
                            Image(systemName: achievement.symbol)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(achievement.symbolColor)
                                .frame(width: 100, height: 100)
                            
                            Text("Obtained on")
                            Text(achievement.dateAchieved!.formatted(date: .numeric, time: .omitted))
                                .font(.caption.bold())
                        }
                    } else {
                        VStack {
                            Image(systemName: achievement.symbol)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(achievement.symbolColor)
                                .frame(width: 100, height: 100)
                                .overlay(content: {
                                    Circle()
                                        .foregroundColor(.white.opacity(0.8))
                                        .frame(width: 115,height: 115)
                                    // Check Color Scheme
                                    //                  .foregroundColor(.black.opacity(0.8))
                                })
                            
                            Text("Not Obtained")
                                .font(.caption.bold().italic())
                                .foregroundColor(.red)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text(achievement.name)
                            .font(.title)
                        
                        Text(achievement.description)
                            .font(.subheadline)
                            .padding(.top)
                        
                        
                    }
                }
                Spacer()
            }
            .padding(.vertical)
            Divider()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(User())
    }
}
