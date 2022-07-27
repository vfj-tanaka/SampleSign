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
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindInputStream()
        bindOutputStream()
    }
    
    private func bindInputStream() {
        
        self.viewModel = SignUpViewModel(
            input: (
                userNameTextField.rx.text.orEmpty.asDriver(),
                mailTextField.rx.text.orEmpty.asDriver(),
                passTextField.rx.text.orEmpty.asDriver(),
                confirmTextField.rx.text.orEmpty.asDriver()
            )
        )
        
        viewModel.validationResult.drive { validationResult in
            
            self.registerButton.isEnabled = validationResult.isValidated
            
        }.disposed(by: disposeBag)

    }
    
    private func bindOutputStream() {
        
    }
    
    @IBAction private func register(_ sender: Any) {
    }
    
    @IBAction private func gotoSignIn(_ sender: Any) {
    }
}
