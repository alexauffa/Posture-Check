//
//  ExerciseDetailView.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 8/29/22.
//

// MARK: File Description
/*
 This view will be responsible for displaying exercise animated image (gif) and describing how to do the exercise.
 */

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    @State var isPresentedFromNotification = false
    @EnvironmentObject var user: User
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                GifImage(exercise.name)
                    .frame(height: geometry.size.height * 0.35)
            
                Text(exercise.name)
                    .font(.largeTitle.bold())
                
                Divider()
                
                HStack {
                    Text("Directions")
                        .font(.title2)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    Text(exercise.description)
                        .padding(.horizontal)
                }
                
                Group {
                    if isPresentedFromNotification {
                        Button("Mark as completed") {
                            isPresentedFromNotification = false
                            user.markAsDone(exercise)
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding(.bottom)
        }
            .navigationTitle(exercise.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExerciseDetailView(exercise: Exercises().exercises[6], isPresentedFromNotification: true)
                .environmentObject(User())
        }
    }
}
