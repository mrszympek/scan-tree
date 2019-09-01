//  Created by Kamil Zajac on 01/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

enum SignIn {
    enum TextFieldType {
        case email
        case password
    }
    
    enum SingleValidation {
        struct Request {
            let textFieldType: TextFieldType
            let text: String
        }
        
        struct Response {
            let error: Error?
            let textFieldType: TextFieldType
        }
        
        struct ViewModel {
            let error: String?
            let textFieldType: TextFieldType
        }
    }
    
    enum FormValidation {
        struct Request {
            let email: String
            let password: String
        }
        
        struct Response {
            let emailError: Error?
            let passwordError: Error?
        }
        
        struct ViewModel {
            let emailError: String?
            let passwordError: String?
        }
    }
    
    enum Authorize {
        struct Response {
            let error: Error
        }
        
        struct ViewModel {
            let error: String
        }
    }
}
