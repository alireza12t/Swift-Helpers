//
//  ValidationHelper.swift
//  carpino-passenger-ios-swift
//
//  Created by negar on 98/Dey/14 AP.
//  Copyright © 1398 carpino corp. All rights reserved.
//

import UIKit

class ValidationHelper: NSObject {

    class func validateCellPhone(phone: String) -> (Bool, String) {
        let phoneWithZeroRegEx = "[0][9][0-9]{9}"
        let phoneNoZeroRegEx = "[9][0-9]{9}"

        let phoneWithZeroTest = NSPredicate(format: "SELF MATCHES %@", phoneWithZeroRegEx)
        let phoneNoZeroTest = NSPredicate(format: "SELF MATCHES %@", phoneNoZeroRegEx)

        if phoneWithZeroTest.evaluate(with: phone) || phoneNoZeroTest.evaluate(with: phone) {
            return (true, "")
        }
        return (false, StringHelper.InvalidInputErrors.getCellphone())
    }

    class func validateVerificationCode(verificationCode: String) -> (Bool, String) {
        let verificationCodeRegEx = "[0-9]{6}"

        let verificationCodeTest = NSPredicate(format: "SELF MATCHES %@", verificationCodeRegEx)

        if verificationCodeTest.evaluate(with: verificationCode) {
            return (true, "")
        }
        return (false, StringHelper.InvalidInputErrors.getVerificationCode())
    }

    class func validateName(name: String) -> (Bool, String) {
        let engNameRegEx = "[A-Za-z ]{3,}"
        let nameRegEx = "([-.]*\\s*[-.]*\\p{Arabic}*[-.]*\\s*)*[-.]*"

        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let engNameTest = NSPredicate(format: "SELF MATCHES %@", engNameRegEx)
        if nameTest.evaluate(with: name) || engNameTest.evaluate(with: name) {
            if name.count > 2 {
                return(true, "")
            }
        }
        return (false, StringHelper.InvalidInputErrors.getName())
    }

    class func validateEmail(email: String) -> (Bool, String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: email) {
            return (true, "")
        }
        return (false, StringHelper.InvalidInputErrors.getEmail())
    }

    class func validateAddress(address: String) -> (Bool, String) {
        let engAddressRegEx = "[A-Z0-9a-z ]{3,}"
        let addressRegEx = "([-.]*\\s*[-.]*\\p{Arabic}*[-.]*\\s*)*[-.]*"

        let addressTest = NSPredicate(format: "SELF MATCHES %@", addressRegEx)
        let engAddressTest = NSPredicate(format: "SELF MATCHES %@", engAddressRegEx)

        if addressTest.evaluate(with: address) || engAddressTest.evaluate(with: address) {
            if address.count > 9 {
                return (true, "")
            }
        }
        return (false, StringHelper.InvalidInputErrors.getAddress())
    }

}

