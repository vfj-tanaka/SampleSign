//
//  Firebase.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

final class Firebase {
    
    private static let auth = Auth.auth()
    private static let db = Firestore.firestore()
    private static let decoder = Firestore.Decoder()
    
    static func registerAuth(email: String, password: String, completion: @escaping (Result<String, Error>) -> ()) {
        
        auth.createUser(withEmail: email, password: password) { res, err in
            
            if let err = err {
                print("認証情報の保存に失敗しました。\(err)")
                completion(.failure(err))
                return
            }
            
            guard let uid = res?.user.uid else { return }
            completion(.success(uid))
        }
    }
    
    static func emailAuth(email: String, completion: @escaping (_ err: Error?) -> ()) {
        
        auth.languageCode = "ja_JP"
        auth.currentUser?.sendEmailVerification { err in
            if let err = err {
                print("認証メールの送信に失敗しました。\(err)")
                completion(err)
                return
            }
            
            completion(nil)
        }
    }
    
    static func registerUser(email: String, username: String, profileImageFileName: String, profileImage: String, uid: String, completion: @escaping (_ err: Error?) -> ()) {
        
        let docDate: [String : Any] = ["email": email, "username": username, "uid": uid, "createdAt": Timestamp()]
        db.collection("users").document(uid).setData(docDate) { err in
            
            if let err = err {
                print("Firestoreへの保存に失敗しました。\(err)")
                completion(err)
                return
            } else {
                
                completion(nil)
            }
        }
    }
    
    static func loginAuth(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        auth.signIn(withEmail: email, password: password) { _, err in
            let isEmailVerified = auth.currentUser?.isEmailVerified ?? true
            if let err = err {
                print("ログインに失敗しました。\(err)")
                completion(.failure(err))
                return
            } else if !isEmailVerified {
                print("メールアドレスが認証されていません。")
                completion(.success(false))
                return
            }
            completion(.success(true))
        }
    }
}
