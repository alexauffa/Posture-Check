//
//  NotificationRoadBlockView.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 10/2/22.
//

import SwiftUI

struct NotificationRoadBlockView: View {
    @EnvironmentObject var notifications: Notifications
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image(systemName: "bell")
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
                .foregroundColor(.red)
                .padding(.top)
            
            Text("This app requires the use of notifications to work. Please allow the use of notifications.")
                .font(.title)
            
            Spacer()
            
            Button("Allow") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .onReceive(timer) { _ in
            notifications.requestForAuthorization()
        }
    }
}

struct NotificationRoadBlockView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationRoadBlockView()
    }
}
