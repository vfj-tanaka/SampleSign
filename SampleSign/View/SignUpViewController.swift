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
    
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passTextField: UITextField!
    @IBOutlet private weak var confirmTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let viewModel = SignUpViewModel()
    private lazy var input: signUpInput = viewModel
    private lazy var output: signUpOutput = viewModel
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindInputStream()
        bindOutputStream()
    }
    
    private func bindInputStream() {
        
        let mailTextObsavable = mailTextField.rx.text
            .subscribe(on: MainScheduler.instance).distinctUntilChanged().filterNil().filter { $0.isNotEmpty }
        let passTextObsavable = passTextField.rx.text
            .subscribe(on: MainScheduler.instance).distinctUntilChanged().filterNil().filter { $0.isNotEmpty }
        let confirmTextObsavable = confirmTextField.rx.text
            .subscribe(on: MainScheduler.instance).distinctUntilChanged().filterNil().filter { $0.isNotEmpty }
        
        
        mailTextObsavable.bind(to: input.mailTextObserver).disposed(by: disposeBag)
        passTextObsavable.bind(to: input.passTextObserver).disposed(by: disposeBag)
        confirmTextObsavable.bind(to: input.confirmTextObserver).disposed(by: disposeBag)
    }
    
    private func bindOutputStream() {
        
    }
    
    @IBAction private func register(_ sender: Any) {
    }
    
    @IBAction private func gotoSignIn(_ sender: Any) {
    }
}
