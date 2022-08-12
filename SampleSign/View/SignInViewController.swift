//
//  SignInViewController.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

final class SignInViewController: UIViewController {
    
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var viewModel: SignInViewModel!
    private var loginTrigger = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        
        self.viewModel = SignInViewModel()
        
        let input = SignInViewModel.Input(
            mailTextDriver: mailTextField.rx.text.orEmpty.asDriver(),
            passTextDriver: passTextField.rx.text.orEmpty.asDriver(),
            loginTrigger: loginTrigger
        )
        
//        let output = self.viewModel.transform(input: input)
//        output.validationResult.drive { validationResult in
//            self.loginButton.isEnabled = validationResult.isValidated
//        }
//        .disposed(by: disposeBag)
//
//        //login
//        output.loginResult.drive { isSuccess, messsage in
//            if isSuccess {
//                //login success
//                print("login success")
//            }
//            else{
//                //login fail
//                print("login fail")
//            }
//        }.disposed(by: disposeBag)
    }
    
    @IBAction private func login(_ sender: Any) {
        loginTrigger.onNext(())
    }
    
    @IBAction private func gotoSignUp(_ sender: Any) {
    }
}
