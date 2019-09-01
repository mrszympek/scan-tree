//  Created by Kamil Zajac on 01/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol SignInPresentationLogic {
    func presentSingleTextFieldValidated(response: SignIn.SingleValidation.Response)
    func presentValidationError(response: SignIn.FormValidation.Response)
    func presentSignInSuccess()
    func presentSignInFailure(response: SignIn.Authorize.Response)
    func presentProgressView()
}

class SignInPresenter: SignInPresentationLogic {
    // MARK: Properties
    
    weak var viewController: SignInDisplayLogic?
    
    // MARK: Presentation Logic
    
    func presentSingleTextFieldValidated(response: SignIn.SingleValidation.Response) {
        let viewModel = SignIn.SingleValidation.ViewModel(
            error: response.error?.localizedDescription,
            textFieldType: response.textFieldType
        )
        viewController?.displaySingleTextFieldValidated(viewModel: viewModel)
    }
    
    func presentValidationError(response: SignIn.FormValidation.Response) {
        let viewModel = SignIn.FormValidation.ViewModel(
            emailError: response.emailError?.localizedDescription,
            passwordError: response.passwordError?.localizedDescription
        )
        viewController?.displayValidationError(viewModel: viewModel)
    }
    
    func presentSignInSuccess() {
        viewController?.displaySignInSuccess()
    }
    
    func presentSignInFailure(response: SignIn.Authorize.Response) {
        let viewModel = SignIn.Authorize.ViewModel(error: response.error.localizedDescription)
        viewController?.displaySignInFailure(viewModel: viewModel)
    }
    
    func presentProgressView() {
        viewController?.displayProgressView()
    }
}
