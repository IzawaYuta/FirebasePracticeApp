//
//  SignUpView.swift
//  FirebasePracticeApp
//
//  Created by 俺の MacBook Air on 2025/03/14.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Sign Up") {
                viewModel.signUp(email: email, password: password)
            }
            
            if viewModel.isAuthenticated {
                // ログイン後のページに遷移
                if viewModel.isAuthenticated {
                    HelloPage(viewModel: viewModel)
                }
                
            }
        }
    }
}

#Preview {
    SignUpView(viewModel: AuthViewModel())
}
