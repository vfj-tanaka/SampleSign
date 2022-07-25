//
//  SignUpViewModel.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import Foundation
import RxSwift
import RxCocoa

protocol signUpInput {
    var userNameTextObserver: AnyObserver<String> { get }
    var mailTextObserver: AnyObserver<String> { get }
    var passTextObserver: AnyObserver<String> { get }
    var confirmTextObserver: AnyObserver<String> { get }
    var confirmValidation: AnyObserver<Bool> { get }
}

protocol signUpOutput {
    
}

final class SignUpViewModel: signUpInput, signUpOutput {
    
    private let disposeBag = DisposeBag()
    
    private let _userNameText = PublishRelay<String>()
    lazy var userNameTextObserver: AnyObserver<String> = .init { event in
        guard let e = event.element else { return }
        self._userNameText.accept(e)
    }
    
    private let _mailText = PublishRelay<String>()
    lazy var mailTextObserver: AnyObserver<String> = .init { event in
        guard let e = event.element else { return }
        self._mailText.accept(e)
    }
    
    private let _passText = PublishRelay<String>()
    lazy var passTextObserver: AnyObserver<String> = .init { event in
        guard let e = event.element else { return }
        self._passText.accept(e)
    }
    
    private let _confirmText = PublishRelay<String>()
    lazy var confirmTextObserver: AnyObserver<String> = .init { event in
        guard let e = event.element else { return }
        self._confirmText.accept(e)
    }
    
    private let _confirmValidation = PublishRelay<Bool>()
    lazy var confirmValidation: AnyObserver<Bool> = .init { event in
        guard let e = event.element else { return }
        self._confirmValidation.accept(e)
    }
    
    init() {
        
    }
}
