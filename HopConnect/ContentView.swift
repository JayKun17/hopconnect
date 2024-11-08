//
//  ContentView.swift
//  HopConnect
//
//  Created by Sanjay Kunwar on 11/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var carOffset: CGFloat = -300 // Start off-screen on the left
    @State private var scooterOffset: CGFloat = 300 // Start off-screen on the right
    @State private var showContent: Bool = false
    @State private var navigateToLogin: Bool = false // State for navigation
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Welcome text at the top
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 50)
                    
                    // Animated Car and Scooter in the middle
                    HStack {
                        Image(systemName: "car.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                            .offset(x: carOffset) // Apply offset to move it from the left
                            .animation(.easeOut(duration: 1).delay(0.3), value: carOffset) // Animate car
                        
                        Spacer()
                        
                        Image(systemName: "scooter")
                            .font(.system(size: 60))
                            .foregroundStyle(.green)
                            .offset(x: scooterOffset) // Apply offset to move it from the right
                            .animation(.easeOut(duration: 1).delay(0.3), value: scooterOffset) // Animate scooter
                    }
                    .padding(.horizontal, 30)
                    
                    // HopConnect message at the bottom
                    if showContent {
                        VStack(spacing: 20) {
                            Text("HopConnect")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                            
                            Text("We’re glad you’re back! Your all-in-one rideshare and rental solution.")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal, 20)
                        .transition(.opacity) // Add fade-in effect
                    }
                }
            }
            .onAppear {
                // Trigger animations when view appears
                carOffset = 0 // Move car to center
                scooterOffset = 0 // Move scooter to center
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showContent = true // Show HopConnect message after a delay
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateToLogin = true // Navigate to login after a short delay
                }
            }
            // Navigation Link to LoginView
            .background(
                NavigationLink("", destination: LoginView(), isActive: $navigateToLogin)
                    .hidden() // Hide the link text
            )
        }
    }
}

// For Xcode 15 previews
#Preview {
    ContentView()
}
