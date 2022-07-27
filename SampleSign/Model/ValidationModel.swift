//
//  ValidationModel.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/27.
//

import Foundation
import UIKit

enum ValidationResult {
    
    case ok, blankError, confirmError
    
    var isValidated: Bool {
        
        switch self {
        case .ok: return true
        case .blankError, .confirmError: return false
        }
    }
    
    var text: String {
        
        switch self {
        case .ok: return "登録可能です。"
        case .blankError: return "空欄があります。"
        case .confirmError: return "パスワードが確認用と一致しません。"
        }
    }
    
    var color: UIColor {
        
        switch self {
        case .ok: return .green
        case .blankError, .confirmError: return .red
        }
    }
}

final class ValidationModel {
    //[String]の中に空文字があればfalse
    func blankValidation(text: [String]) -> Bool {
        
        for text in text {
            if text.isEmpty {
                return false
            }
        }
        return true
    }
    // パスワードと確認用が一致してなかったらfalse
    func confirmValidation(pass: String, confirm: String) -> Bool {
        
        return pass == confirm
    }
}
