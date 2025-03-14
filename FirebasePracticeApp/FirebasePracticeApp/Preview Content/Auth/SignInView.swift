//
//  SignInView.swift
//  FirebasePracticeApp
//
//  Created by 俺の MacBook Air on 2025/03/14.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("メールアドレス", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("パスワード", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("サインイン") {
                    viewModel.signIn(email: email, password: password)
                }
                
                if viewModel.isAuthenticated {
                    // ログイン後のページに遷移
                    HelloPage(viewModel: viewModel)
                }
                
                // 新規登録画面への遷移ボタン
                NavigationLink(destination: SignUpView(viewModel: viewModel)) {
                    Text("アカウント作成")
                        .padding(.top, 16)
                }
                // パスワードのリセットページへ移動する
                NavigationLink(destination: ResetPasswordView(viewModel: viewModel)) {
                    Text("パスワードを忘れた方")
                        .padding(.top, 16)
                }
            }
        }
    }
}

#Preview {
    SignInView(viewModel: AuthViewModel())
}
