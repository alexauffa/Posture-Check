//
//  WelcomeView.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 10/21/22.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage(Keys.isNewUser) var isNewUser: Bool = true
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                VStack(spacing: 5) {
                    Image("Posture Check App Icon")
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .frame(width: 150, height: 150)
                                    
                    Text("Welcome to Posture Check!")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Text("Where tracking your posture is fun.")
                        .font(.subheadline.weight(.light))
                        .multilineTextAlignment(.center)
                }
                .frame(height: geometry.size.height * 0.25)
                VStack(spacing: 50) {
                    
                    Spacer()
                    
                    FeatureView(featureIcon: "bell.badge",
                                featureName: "Receive Exercise Reminders",
                                featureDescription: "Having reminders help you create a healthy habit.")
                    .foregroundColor(.red)
                    
                    FeatureView(featureIcon: "gamecontroller",
                                featureName: "Unlock Badges from your exercise",
                                featureDescription: "Exercising every day unlock streaks.")
                    .foregroundColor(.green)
                    
                    FeatureView(featureIcon: "heart.text.square",
                                featureName: "Help the research of having a good posture",
                                featureDescription: "Help UPR students recover data about Tech-Neck issues.")
                    .foregroundColor(.yellow)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 30)
                
                Button("Get Started") {
                    isNewUser = false
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                
            }
            .padding([.top, .bottom], 25)
        
        }
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.largeTitle.weight(.bold))
            .foregroundColor(.white)
    }
}

struct FeatureView: View {
    var featureIcon: String
    var featureName: String
    var featureDescription: String
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: featureIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(featureName)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(featureDescription)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
