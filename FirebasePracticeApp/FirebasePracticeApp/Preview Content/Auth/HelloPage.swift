//
//  HelloPage.swift
//  FirebasePracticeApp
//
//  Created by 俺の MacBook Air on 2025/03/14.
//

import SwiftUI

// ログイン後の画面
struct HelloPage: View {
    var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Hello, you're logged in!")
                .font(.title)
                .padding()
            Button("Log Out") {
                // ログアウトしてログイン画面へ遷移する
                viewModel.signOut()
            }
        }
    }
}

#Preview {
    HelloPage(viewModel: AuthViewModel())
}
