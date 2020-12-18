//
//  ViewController.swift
//  UnitTest-Demo
//
//  Created by Nguyen Hong Nhan on 12/18/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let dummyDatabase = [User(username: "kilo loco", password: "password1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        do {
            guard
                let username = usernameTextField.text,
                let password = passwordTextField.text
            else { throw ValidationError.invalidValue }
            
            guard username.count > 3 else { throw ValidationError.usernameTooShort }
            guard username.count < 20 else { throw ValidationError.usernameTooLong }
            guard password.count >= 8 else { throw ValidationError.passwordTooShort }
            guard password.count < 20 else { throw ValidationError.passwordTooLong }
            
            
            // Login to database...
            if let user = dummyDatabase.first(where: { user in
                user.username == username && user.password == user.password
            }) {
                presentAlert(with: "You successfully logged in as \(user.username)")
                
            } else {
                throw LoginError.invalidCredentials
            }
            
        } catch {
            present(error)
        }
    }
}

extension ViewController {
    enum ValidationError: LocalizedError {
        case invalidValue
        case passwordTooLong
        case passwordTooShort
        case usernameTooLong
        case usernameTooShort
        
        var errorDescription: String? {
            switch self {
            case .invalidValue:
                return "You have entered an invalid value."
            case .passwordTooLong:
                return "Your password is too long."
            case .passwordTooShort:
                return "Your password is too short."
            case .usernameTooLong:
                return "Your username is too long."
            case .usernameTooShort:
                return "Your username is too short."
            }
        }
    }
    
    enum LoginError: LocalizedError {
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Incorrect username or password. Please try again."
            }
        }
    }
}
