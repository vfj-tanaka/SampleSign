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
    
    private let viewModel = SignInViewModel()
    private lazy var input: signInInput = viewModel
    private lazy var output: signInOutput = viewModel
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindInputStream()
        bindOutputStream()
    }
    
    private func bindInputStream() {
        
        let mailTextObsavable = mailTextField.rx.text
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged().filterNil().filter { $0.isNotEmpty }
        let passTextObsavable = passTextField.rx.text
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged().filterNil().filter { $0.isNotEmpty }
        
        mailTextObsavable.bind(to: input.mailTextObserver).disposed(by: disposeBag)
        passTextObsavable.bind(to: input.passTextObserver).disposed(by: disposeBag)
    }
    
    private func bindOutputStream() {
        
    }
    
    @IBAction private func login(_ sender: Any) {
    }
    
    @IBAction private func gotoSignUp(_ sender: Any) {
    }
}
