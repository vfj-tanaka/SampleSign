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
        let userNameTextDriver: Driver<String>
        let mailTextDriver: Driver<String>
        let passTextDriver: Driver<String>
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
    
    override init() {}
    
    func transform(input: Input) -> Output {
        
        let validationModel = ValidationModel()
        
        // 空欄がないかのバリデーション
        let blankValidation: Driver<Bool> = Driver.combineLatest(
            input.userNameTextDriver,
            input.mailTextDriver,
            input.passTextDriver,
            input.confirmTextDriver
        ) { userName, mail, pass, confirm in
            self.email = mail
            self.password = pass
            return validationModel.blankValidation(text: [userName, mail, pass, confirm])
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
        let registerResult: Driver< (isSuccessed: Bool, message: String)> = input.registerTrigger.asObservable().map { _ in
            
            return self.doRegister(mail: self.email, password: self.password)
            
        }.asDriver(onErrorJustReturn: (isSuccessed: false, message: ""))
        
        
        return Output(validationResult: validationResult, registerResult: registerResult)
    }
    
    private func doRegister(mail: String?, password:String?) -> (isSuccessed: Bool,message: String){
        //request API or Firebase .... and return result like below
        if let mail = mail, let password = password {
            print("--email : " + mail)
            print("--pass : " + password)
        }
        return (isSuccessed: true, message: "This is messsage")
    }
}
