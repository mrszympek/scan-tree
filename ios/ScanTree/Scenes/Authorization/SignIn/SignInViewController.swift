//  Created by Kamil Zajac on 01/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol SignInDisplayLogic: class {
    func displaySingleTextFieldValidated(viewModel: SignIn.SingleValidation.ViewModel)
    func displayValidationError(viewModel: SignIn.FormValidation.ViewModel)
    func displaySignInSuccess()
    func displaySignInFailure(viewModel: SignIn.Authorize.ViewModel)
    func displayProgressView()
}

class SignInViewController: UIViewController, SignInDisplayLogic {

    // MARK: Outlets

    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: Properties

    var interactor: SignInBusinessLogic?
    var router: (NSObjectProtocol & SignInRoutingLogic & SignInDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: View customization

    private func setupView() {
        view.addGradient()
    }

    // MARK: Actions

    private func signInWithEmail() {
        let request = SignIn.FormValidation.Request(
            email: emailTextField.text!,
            password: passwordTextField.text!
        )
        interactor?.signInWithEmail(request: request)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        signInWithEmail()
    }
    
    // MARK: Display logic

    func displaySingleTextFieldValidated(viewModel: SignIn.SingleValidation.ViewModel) {
        switch viewModel.textFieldType {
        case .email:
            emailTextField.showValidationResult(viewModel.error)
        case .password:
            passwordTextField.showValidationResult(viewModel.error)
        }
    }
    
    func displayValidationError(viewModel: SignIn.FormValidation.ViewModel) {
        emailTextField.showValidationResult(viewModel.emailError)
        passwordTextField.showValidationResult(viewModel.passwordError)
    }
    
    func displaySignInSuccess() {
        dismissProgress()
        emailTextField.success()
        passwordTextField.success()
        router?.navigateToApp(animated: true)
    }
    
    func displaySignInFailure(viewModel: SignIn.Authorize.ViewModel) {
        showError(viewModel.error)
    }
    
    func displayProgressView() {
        showProgress()
    }
    
}

// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        (textField as? UnderlinedTextField)?.success()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            signInWithEmail()
            resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let request = SignIn.SingleValidation.Request(
            textFieldType: textField == emailTextField ? .email : .password,
            text: textField.text!
        )
        interactor?.validateSingleTextField(request: request)
    }
}
