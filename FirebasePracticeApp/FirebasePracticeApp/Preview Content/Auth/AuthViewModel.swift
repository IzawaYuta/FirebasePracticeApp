//
//  AuthViewModel.swift
//  FirebasePracticeApp
//
//  Created by 俺の MacBook Air on 2025/03/14.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    // イニシャライザメソッドを呼び出して、アプリの起動時に認証状態をチェックする
    init() {
        observeAuthChanges()
    }
    
    private func observeAuthChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isAuthenticated = user != nil
            }
        }
    }
    // ログインするメソッド
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if result != nil, error == nil {
                    self?.isAuthenticated = true
                }
            }
        }
    }
    // 新規登録するメソッド
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if result != nil, error == nil {
                    self?.isAuthenticated = true
                }
            }
        }
    }
    // パスワードをリセットするメソッド
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error in sending password reset: \(error)")
            }
        }
    }
    // ログアウトするメソッド
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
