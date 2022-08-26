//
//  SignUpViewModel.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel: NSObject {
    
    struct Input {
        let mailTextDriver: Driver<String>
        let passTextDriver: Driver<String>
        let userNameTextDriver: Driver<String>
        let confirmTextDriver: Driver<String>
        
        let registerTrigger: PublishSubject<Void>
    }
    
    struct Output {
        let validationResult: Driver<ValidationResult>
        let registerResult: Driver<(isSuccessed: Bool, message: String)>
    }
    
    private let disposeBag = DisposeBag()
    private var email: String?
    private var password: String?
    private var userName: String?
    
    override init() {}
    
    func transform(input: Input) -> Output {
        
        let validationModel = ValidationModel()
        
        // 空欄がないかのバリデーション
        let blankValidation: Driver<Bool> = Driver.combineLatest(
            input.mailTextDriver,
            input.passTextDriver,
            input.userNameTextDriver,
            input.confirmTextDriver
        ) { mail, pass, userName, confirm in
            self.email = mail
            self.password = pass
            self.userName = userName
            return validationModel.blankValidation(text: [mail, pass, userName, confirm])
        }
        
        // パスワードが確認用と一致しているかのバリデーション
        let confirmValidation: Driver<Bool> = Driver.combineLatest(
            input.passTextDriver,
            input.confirmTextDriver
        ) { pass, confirm in
            return validationModel.confirmValidation(pass: pass, confirm: confirm)
        }
        
        // バリデーション結果
        let validationResult: Driver<ValidationResult> = Driver.combineLatest(
            blankValidation,
            confirmValidation
        ) { blankValidation, confirmValidation in
            if !blankValidation {
                return .blankError
            } else if !confirmValidation {
                return .confirmError
            } else {
                return .ok
            }
        }
        
        //Register process
        let registerResult: Driver<(isSuccessed: Bool, message: String)> = input.registerTrigger.asObservable().map { _ in
            
            return self.doRegister(mail: self.email, password: self.password, userName: self.userName)
            
        }.asDriver(onErrorJustReturn: (isSuccessed: false, message: ""))
        
        
        return Output(validationResult: validationResult, registerResult: registerResult)
    }
    
    private func doRegister(mail: String?, password: String?, userName: String?) -> (isSuccessed: Bool, message: String) {
        //request API or Firebase .... and return result like below
        if let mail = mail, let password = password, let userName = userName {
            var uid = ""
            Firebase.registerAuth(email: mail, password: password) { result in
                
                switch result {
                case .success(let uidString):
                    uid = uidString
                    print("Authの登録に成功しました")
                case .failure:
                    print("Authの登録に失敗しました")
                    return
                }
                
                Firebase.registerUser(email: mail, userName: userName, uid: uid) { err in
                    
                    if err != nil {
                        print("ユーザーの登録に失敗しました")
                        return
                    }
                    
                    Firebase.emailAuth(email: mail) { err in
                        
                        if err != nil {
                            print("認証メールの送信に失敗しました")
                            return
                        }
                    }
                }
            }
        }
        return (isSuccessed: true, message: "This is messsage")
    }
}
