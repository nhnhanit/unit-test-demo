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
    
    private let validation: ValidationService
    
    init(validation: ValidationService) {
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        do {
            
            let username = try validation.validateUsername(usernameTextField.text)
            let password = try validation.validatePassword(passwordTextField.text)
            
            
//            guard
//                let username = usernameTextField.text,
//                let password = passwordTextField.text
//            else { throw ValidationError.invalidValue }
//
//            guard username.count > 3 else { throw ValidationError.usernameTooShort }
//            guard username.count < 20 else { throw ValidationError.usernameTooLong }
//            guard password.count >= 8 else { throw ValidationError.passwordTooShort }
//            guard password.count < 20 else { throw ValidationError.passwordTooLong }
            
            
            // Login to database...
            if let user = dummyDatabase.first(where: { user in
                user.username == username && user.password == password
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
