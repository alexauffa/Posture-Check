//
//  AppDelegate.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 10/20/22.
//

import Foundation
import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          // request for the permission
          let center = UNUserNotificationCenter.current()
          center.delegate = self
          center.getNotificationSettings(completionHandler: { settings in
            if settings.authorizationStatus == .authorized  {
                print("permission granted")
            }
         })
         return true
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    /** Handle notification when the app is in background */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response:
    UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
  
        let userInfo = response.notification.request.content.userInfo
        let exerciseName = userInfo["exerciseName"]
        
        let user = User()
        
        if response.notification.request.content.categoryIdentifier == Constants.categoryIdentifier {
            switch response.actionIdentifier {
                
            case Constants.completeExerciseAction:
                if let exercise = user.exercises.exercises.first(where: {
                    $0.name == exerciseName as! String ?? ""
                }) {
                    user.markAsDone(exercise)
                }
                
//            case Constants.viewGifAction:
//                if let exercise = user.exercises.exercises.first(where: {
//                    $0.name == exerciseName as! String ?? ""
//                }) {
//                    let viewController = UIHostingController(rootView: ExerciseDetailView(exercise: exercise, isPresentedFromNotification: true)
//                        .environmentObject(User()))
//                    let mainVC = UIApplication.shared.keyWindow?.rootViewController
//                    mainVC!.present(viewController, animated: true)
//                }
    
            default:
                if let exercise = user.exercises.exercises.first(where: {
                    $0.name == exerciseName as! String ?? ""
                }) {
                    let viewController = UIHostingController(rootView: ExerciseDetailView(exercise: exercise, isPresentedFromNotification: true)
                        .environmentObject(user))
                    let mainVC = UIApplication.shared.keyWindow?.rootViewController
                    mainVC!.present(viewController, animated: true)
                }
            }
        }
        completionHandler()
    }
    
    /** Handle notification when the app is in foreground */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
             willPresent notification: UNNotification,
             withCompletionHandler completionHandler:
                @escaping (UNNotificationPresentationOptions) -> Void) {
       
        // handle the notification here..
        print("Notification received with app active")
    }
}
