import SwiftUI

struct SignupView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword: Bool = false
    @State private var acceptedTerms: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create an Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            // First Name and Last Name Fields
            Group {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 20)
            
            // Username with Availability Placeholder
            VStack(alignment: .leading, spacing: 5) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                
                Text("Username is already taken")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal, 20)
                    .opacity(username == "existingUser" ? 1 : 0) // Example check
            }
            
            // Phone Number with Formatting
            TextField("Phone Number (xxx-xxx-xxxx)", text: $phoneNumber)
                .keyboardType(.phonePad)
                .onChange(of: phoneNumber) { newValue in
                    phoneNumber = formatPhoneNumber(newValue)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Email Field
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Password Field with Show/Hide Toggle and Strength Indicator
            VStack(alignment: .leading, spacing: 5) {
                ZStack(alignment: .trailing) {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .padding()
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                
                Text(passwordStrengthMessage())
                    .font(.caption)
                    .foregroundColor(passwordStrengthColor())
                    .padding(.horizontal, 20)
            }
            
            // Confirm Password Field
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Terms and Conditions Toggle
            Toggle("I accept the Terms and Conditions", isOn: $acceptedTerms)
                .padding(.horizontal, 20)
            
            // Sign Up Button
            Button(action: {
                // Add sign-up functionality here
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isFormValid() ? Color.green : Color.gray)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
            }
            .disabled(!isFormValid())
            
            Spacer()
            
            // Navigation Link to Log In
            HStack {
                Text("Already have an account?")
                NavigationLink(destination: Text("LoginView")) { // Replace with your actual LoginView
                    Text("Log In")
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    // MARK: - Helper Functions

    private func formatPhoneNumber(_ number: String) -> String {
        let digits = number.filter { "0123456789".contains($0) }
        let formatted = digits.prefix(10)
        
        if formatted.count > 6 {
            return String(formatted.prefix(3)) + "-" + String(formatted.dropFirst(3).prefix(3)) + "-" + String(formatted.dropFirst(6))
        } else if formatted.count > 3 {
            return String(formatted.prefix(3)) + "-" + String(formatted.dropFirst(3))
        }
        return String(formatted)
    }
    
    private func passwordStrengthMessage() -> String {
        if password.count >= 8 && password.rangeOfCharacter(from: .uppercaseLetters) != nil && password.rangeOfCharacter(from: .decimalDigits) != nil {
            return "Strong Password"
        } else if password.count >= 6 {
            return "Weak Password"
        } else {
            return "Very Weak Password"
        }
    }
    
    private func passwordStrengthColor() -> Color {
        switch passwordStrengthMessage() {
        case "Strong Password":
            return .green
        case "Weak Password":
            return .orange
        default:
            return .red
        }
    }
    
    private func isFormValid() -> Bool {
        return !firstName.isEmpty && !lastName.isEmpty && !username.isEmpty &&
            phoneNumber.count == 12 && email.contains("@") && password == confirmPassword &&
            password.count >= 6 && acceptedTerms
    }
}

// For preview
#Preview {
    SignupView()
}
