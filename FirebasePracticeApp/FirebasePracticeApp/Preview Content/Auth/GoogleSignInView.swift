//
//  GoogleSignInView.swift
//  FirebasePracticeApp
//
//  Created by 俺の MacBook Air on 2025/03/15.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct GoogleSignInView: View {
    
    // GoogleAuthメソッド
    private func googleAuth() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        // 現在の画面に表示するViewControllerを取得
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // GoogleSignInの設定
        GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { user, error in
            if let error = error {
                print("GIDSignInError: \(error.localizedDescription)")
                return
            }
            
            // user.authentication から idToken と accessToken を取得
            guard let user = user else { return }
            let authentication = user.authentication
            
            // idToken と accessToken は必ず存在する前提で扱います
            let idToken = authentication.idToken
            let accessToken = authentication.accessToken
            
            // Firebase認証用の資格情報を作成
            let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "", accessToken: accessToken)
            
            // Firebaseでログイン
            self.login(credential: credential)
        }
    }
    
    // Firebaseへのログイン処理
    private func login(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("SignInError: \(error.localizedDescription)")
                return
            }
            print("ログイン成功！")
        }
    }
    
    var body: some View {
        Button(action: {
            googleAuth()
        }, label: {
            Text("GoogleアカウントでLogin")
        })
    }
}

#Preview {
    GoogleSignInView()
}
