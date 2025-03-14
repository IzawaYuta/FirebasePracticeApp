//
//  ResetPasswordView.swift
//  FirebasePracticeApp
//
//  Created by 俺の MacBook Air on 2025/03/14.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email: String = ""
    @State private var isShowMessage = false
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if isShowMessage {
                Text("送信完了！受信ボックスを確認してね。")
            }
            TextField("メールアドレス", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("送信") {
                isShowMessage = true
                viewModel.resetPassword(email: email)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isShowMessage = false
                }
            }
            
        }
    }
}

#Preview {
    ResetPasswordView(viewModel: AuthViewModel())
}
