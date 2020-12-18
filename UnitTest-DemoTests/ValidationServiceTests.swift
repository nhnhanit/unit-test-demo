//
//  ValidationServiceTests.swift
//  UnitTest-DemoTests
//
//  Created by Nguyen Hong Nhan on 12/18/20.
//

@testable import UnitTest_Demo
import XCTest

class ValidationServiceTests: XCTestCase {
    
    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    
    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    // MARK: - Valid Username
    func test_is_valid_username() throws {
        XCTAssertNoThrow(try validation.validateUsername("kilo loco"))
    }
    
    func test_username_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_too_short() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername("loc")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_too_long() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let username = "very long user name1"
        
        XCTAssertTrue(username.count == 20)
        
        XCTAssertThrowsError(try validation.validateUsername(username)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    // MARK: - Valid Password
    func test_is_valid_password() throws {
        XCTAssertNoThrow(try validation.validatePassword("password1q1q"))
    }
    
    func test_password_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_password_too_short() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("loc")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_password_too_long() throws {
        let expectedError = ValidationError.passwordTooLong
        var error: ValidationError?
        let password = "very long password 1q1q1q"
        
        //XCTAssertTrue(password.count == 20)
        
        XCTAssertThrowsError(try validation.validatePassword(password)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }


}
