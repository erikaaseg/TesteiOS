//
//  String+ext.swift
//  Platform
//
//  Created by Erika Segatto on 19/03/18.
//  Copyright © 2018 evologica. All rights reserved.
//

import Foundation

extension String {

    
    func asInt() -> Int? {
        if let number = self.asNumber() {
            return Int(exactly: number)
        }
        return nil
    }
    
    func asNumber() -> NSNumber? {
        let numFormatter = NumberFormatter()
        numFormatter.decimalSeparator = "."
        if let number = numFormatter.number(from: self){
            return number
        }
        numFormatter.decimalSeparator = ","
        return numFormatter.number(from: self)
    }
    
    
    // MARK: String Format
    public func formatAsPhone() -> String {
        let cleanString = String(self.formatAsNumeric().prefix(11))
        
        switch cleanString.count {
        case 11: return cleanString.applyMask(mask: "(**) *****-****")
        default: return cleanString.applyMask(mask: "(**) ****-****")
        }
    }
    
    func formatAsNumeric() -> String {
        return self.replacingOccurrences(of:"[^0-9]", with: "", options: .regularExpression)
    }
    
    
    private func applyMask(mask: String) -> String {
        var result = ""
        
        var maskIndex = mask.startIndex
        var selfIndex = self.startIndex
        
        while selfIndex.encodedOffset != self.endIndex.encodedOffset {
            if mask[maskIndex] == "*" {
                result.append(self[selfIndex])
                selfIndex = self.index(after: selfIndex)
            } else {
                result.append(mask[maskIndex])
            }
            maskIndex = mask.index(after: maskIndex)
            if maskIndex.encodedOffset == mask.endIndex.encodedOffset {
                result.append(String(self.suffix(from: selfIndex)))
                return result
            }
        }
        
        return result
    }
    
    // MARK: is Valid
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let formatedPhoneFormat = "\\([0-9]{2}\\) ?[0-9]{4,5}-[0-9]{4}"
        let unformatedPhoneFormat = "[0-9]{10,11}"
        let predicate = NSPredicate(format: "SELF MATCHES %@ OR SELF MATCHES %@", formatedPhoneFormat, unformatedPhoneFormat)
        return predicate.evaluate(with: self)
    }
    
}
