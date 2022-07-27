//
//  SignUpViewModel.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
    
    typealias Input = (
        userNameTextDriver: Driver<String>,
        mailTextDriver: Driver<String>,
        passTextDriver: Driver<String>,
        confirmTextDriver: Driver<String>
    )
    // バリデーション結果
    let validationResult: Driver<ValidationResult>
    // 空欄がないかのバリデーション
    let blankValidation: Driver<Bool>
    // パスワードが確認用と一致しているかのバリデーション
    let confirmValidation: Driver<Bool>
    
    private let disposeBag = DisposeBag()
    
    init(input: Input) {
        
        let validationModel = ValidationModel()
        
        blankValidation = Driver.combineLatest(
            input.userNameTextDriver,
            input.mailTextDriver,
            input.passTextDriver,
            input.confirmTextDriver
        ) { userName, mail, pass, confirm in
            return validationModel.blankValidation(text: [userName, mail, pass, confirm])
        }
        
        confirmValidation = Driver.combineLatest(
            input.passTextDriver,
            input.confirmTextDriver
        ) { pass, confirm in
            return validationModel.confirmValidation(pass: pass, confirm: confirm)
        }
        
        validationResult = Driver.combineLatest(
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
    }
}
