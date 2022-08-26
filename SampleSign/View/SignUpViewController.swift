//
//  SignUpViewController.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

final class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passTextField: UITextField!
    @IBOutlet private weak var confirmTextField: UITextField!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    
    private var viewModel: SignUpViewModel!
    private var registerTrigger = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        
        self.viewModel = SignUpViewModel()
        let input = SignUpViewModel.Input(
            mailTextDriver: mailTextField.rx.text.orEmpty.asDriver(),
            passTextDriver: passTextField.rx.text.orEmpty.asDriver(),
            userNameTextDriver: userNameTextField.rx.text.orEmpty.asDriver(),
            confirmTextDriver: confirmTextField.rx.text.orEmpty.asDriver(),
            registerTrigger: registerTrigger
        )
        
        let output = self.viewModel.transform(input: input)
        output.validationResult.drive { validationResult in
            self.registerButton.isEnabled = validationResult.isValidated
            self.statusLabel.text = validationResult.text
            self.statusLabel.textColor = validationResult.color
        }
        .disposed(by: disposeBag)
        
        //Register
        output.registerResult.drive { isSuccess, messsage in
            if isSuccess {
                //register success
                print("register success")
            }
            else{
                //register fail
                print("register fail")
            }
        }.disposed(by: disposeBag)
        
    }
    
    @IBAction private func register(_ sender: Any) {
        
        registerTrigger.onNext(())
    }
    
    @IBAction private func gotoSignIn(_ sender: Any) {
    }
}
