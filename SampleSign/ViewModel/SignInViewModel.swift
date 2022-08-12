//
//  SignInViewModel.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewModel: NSObject {
    
    struct Input {
        let mailTextDriver: Driver<String>
        let passTextDriver: Driver<String>
        
        let loginTrigger: PublishSubject<Void>
    }
    
    struct Output {
        let validationResult: Driver<ValidationResult>
        let loginResult: Driver<(isSuccessed: Bool, message: String)>
    }
    
    private let disposeBag = DisposeBag()
    private var email: String?
    private var password: String?
    
    override init() {}
    
//    func transform(input: Input) -> Output {
//
//        let validationModel = ValidationModel()
//        // 空欄がないかのバリデーション
//        let blankValidation: Driver<Bool> = Driver.combineLatest(
//            input.mailTextDriver,
//            input.passTextDriver
//        ) { mail, pass in
//            self.email = mail
//            self.password = pass
//            return validationModel.blankValidation(text: [mail, pass])
//        }
//
//        let validationResult: Driver<ValidationResult> = Driver.combineLatest(
//            blankValidation
//        ) { blankValidation in
//            if !blankValidation {
//                return .blankError
//            } else {
//                return .ok
//            }
//        }
//
//    let loginResult: Driver<(isSuccessed: Bool, message: String)> = input.loginTrigger.asObservable().map { _ in
//
//        return self.doLogin(mail: self.email, password: self.password)
//
//    }.asDriver(onErrorJustReturn: (isSuccessed: false, message: ""))
//
//
//    return Output(validationResult: validationResult, loginResult: loginResult)
//}
//    private func doLogin(mail: String?, password: String?) -> (isSuccessed: Bool, message: String) {
//        //request API or Firebase .... and return result like below
//        if let mail = mail, let password = password {
//            print("--email : " + mail)
//            print("--pass : " + password)
//        }
//        return (isSuccessed: true, message: "This is messsage")
//    }
}
