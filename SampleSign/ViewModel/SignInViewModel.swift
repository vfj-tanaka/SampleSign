//
//  SignInViewModel.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import Foundation
import RxSwift
import RxCocoa

protocol signInInput {
    var mailTextObserver: AnyObserver<String> { get }
    var passTextObserver: AnyObserver<String> { get }
}

protocol signInOutput {
    
}

final class SignInViewModel: signInInput, signInOutput {
    
    private let disposeBag = DisposeBag()
    
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
    
    init() {
        
    }
}
