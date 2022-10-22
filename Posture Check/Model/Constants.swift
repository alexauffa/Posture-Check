//
//  Constants.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 10/12/22.
//

import Foundation

struct Constants {
    // In seconds
    static let postureReminderOffset = 1_500.00
    static let exerciseReminderOffset = 3_660.00
    static let restReminderOffset = 13_200.00
    
    static let postureRemindersTitles = ["Posture Reminder",
                                         "Hey, watch your posture!",
                                         "Please, improve your posture"]
    
    static let exercisesRemindersTitles = ["Exercise time 🧘🏻‍♂️",
                                           "Let's get ready to stretch! 🤸",
                                           "Time for an exercise session! 🏃"]
    
    static let restReminderTitles = ["Rest Reminder 💤",
                                     "Time for a break 😮‍💨",
                                     "You've earned yourself a break 💪"]
    
    static let dailyRemindersTitles = ["Research Questionnaire Reminder"]
    
    static let postureRemindersDescriptions = ["Maintain the phone at eye level to avoid tech neck syndrome",
                                               "A good stance and posture reflect a proper state of mind",
                                               "Having a good posture reduces neck and back pain."]
    
    static let exercisesRemindersDescription = ["Long press to mark as completed"]
    
    static let restReminderDescription = ["A rest of 20 minutes is recommended for this period of usage",
                                          "Make sure you get at least 15 to 20 minutes of rest.",
                                          "It's important to rest after doing exercises, take a 15 to 20 minute break."]
    
    static let dailyRemindersDescriptions = ["This help us with our research. Thank You!"]
    
    static let activeFrom = DateComponents.init(hour: 8, minute: 0)
    static let activeUpTo = DateComponents.init(hour: 17, minute: 0)
    
    // Notification Actions
    static let categoryIdentifier = "exerciseCategory"
    static let completeExerciseAction = "COMPLETE_EXERCISE"
//    static let viewGifAction = "VIEW_GIF_ACTION"
}
