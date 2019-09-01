//  Created by Kamil Zajac on 01/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol SignInBusinessLogic {
    func validateSingleTextField(request: SignIn.SingleValidation.Request)
    func signInWithEmail(request: SignIn.FormValidation.Request)
}

protocol SignInDataStore {
}

class SignInInteractor: SignInBusinessLogic, SignInDataStore {
    // MARK: Properties
    
    var presenter: SignInPresentationLogic?
    let worker = SignInWorker()

    // MARK: Bussines logic
    
    // MARK: - Validation
    
    func validateSingleTextField(request: SignIn.SingleValidation.Request) {
        func presentOneFieldValidation(error: Error?) {
            let response = SignIn.SingleValidation.Response(
                error: error,
                textFieldType: request.textFieldType
            )
            presenter?.presentSingleTextFieldValidated(response: response)
        }
        
        switch request.textFieldType {
        case .email:
            let emailResult = FieldValidator.validate(text: request.text.lowercased(), as: .empty)
            presentOneFieldValidation(error: emailResult.error)
        case .password:
            let passwordResult = FieldValidator.validate(text: request.text, as: .password)
            presentOneFieldValidation(error: passwordResult.error)
        }
    }
    
    func signInWithEmail(request: SignIn.FormValidation.Request) {
        let emailResult = FieldValidator.validate(text: request.email.lowercased(), as: .empty)
        let passwordResult = FieldValidator.validate(text: request.password, as: .password)
        guard emailResult.isValidated && passwordResult.isValidated else {
            let response = SignIn.FormValidation.Response(
                emailError: emailResult.error,
                passwordError: passwordResult.error
            )
            presenter?.presentValidationError(response: response)
            return
        }
        log.info("Start sign in with email process")
        presenter?.presentSignInSuccess()
//        let parameters: JSON = ["login": request.email.lowercased(), "password": request.password]
//        sendLoginParameters(parameters, isSocialMediaLogin: false)
    }
    
}
