//
//  FieldValidator.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import UIKit

typealias ValidateResult = (isValidated: Bool, error: Error?)

enum FieldType: String {
    case email = "email"
    case password = "password"
    case empty
    case matching = "matching"
}

class FieldValidator {
    
    enum EmailError: LocalizedError {
        case empty
        case invalid
        
        var errorDescription: String? {
            switch self {
            case .empty: return "Enter email"
            case .invalid: return "Invalid email"
            }
        }
    }
    
    enum PasswordError: LocalizedError {
        case empty
        case count
        
        var errorDescription: String? {
            switch self {
            case .empty: return "Enter password"
            case .count: return "Minimum 8 digits"
            }
        }
    }
    
    enum MatchingError: LocalizedError {
        case empty
        case different
        
        var errorDescription: String? {
            switch self {
            case .empty: return "Field is empty"
            case .different: return "Fields are not matching"
            }
        }
    }
    
    enum Error: LocalizedError {
        case custom(String)
        case invalid
        
        var errorDescription: String? {
            switch self {
            case .custom(let reason): return reason
            case .invalid: return "Invalid characters"
            }
        }
    }
    
    static func validate(text: String, confirmText: String? = nil, as fieldType: FieldType) -> ValidateResult {
        switch fieldType {
        case .email:
            return validate(email: text)
        case .password:
            return validate(password: text)
        case .empty:
            return validateEmpty(text: text)
        case .matching:
            return validateMatching(field: text, confirmField: confirmText)
        }
    }
    
    private static func validateEmpty(text: String) -> ValidateResult {
        guard text != "" else {
            return (false, Error.custom("This field is mandatory"))
        }
        return (true, nil)
    }
    
    private static func validate(email: String) -> ValidateResult {
        guard email != "" else {
            return (false, EmailError.empty)
        }
        guard email.isEmailValid() else {
            return (false, EmailError.invalid)
        }
        return (true, nil)
    }
    
    private static func validate(password: String) -> ValidateResult {
        guard password != "" else {
            return (false, PasswordError.empty)
        }
        guard password.count > 5 else {
            return (false, PasswordError.count)
        }
        return (true, nil)
    }
    
    private static func validateMatching(field: String, confirmField: String?) -> ValidateResult {
        guard !field.isEmpty, confirmField != nil, !confirmField!.isEmpty else {
            return (false, MatchingError.empty)
        }
        guard field == confirmField else {
            return (false, MatchingError.different)
        }
        return (true, nil)
    }
}


// MARK: String extension
// Those methods are used only in field validator
private extension String {
    
    func isEmailValid() -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{2,64}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isUsernameValid() -> Bool {
        let usernameRegEx = "^([a-zA-Z0-9_]+).?([a-zA-Z0-9_]+)$"
        let usernameTest = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        return usernameTest.evaluate(with: self)
    }
}


