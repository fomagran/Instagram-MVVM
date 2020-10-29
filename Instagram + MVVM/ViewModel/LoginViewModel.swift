//
//  LoginViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/29.
//

import UIKit

protocol formUpdateProtocol {
    func updateUI()
}

protocol AuthentificationProtocol {
    var formValid:Bool {get}
    var buttonBackgroundColor:UIColor {get}
    var buttonTitleColor:UIColor {get}
}

struct LoginViewModel:AuthentificationProtocol {
    var email:String?
    var password:String?
    
    var formValid:Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor : UIColor {
        return formValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor : UIColor {
        return formValid ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.5)
    }
}

struct SignUpViewModel:AuthentificationProtocol {
    
    var email:String?
    var password:String?
    var fullname:String?
    var username:String?
    
    var formValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor : UIColor {
        return formValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor : UIColor {
        return formValid ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.5)
    }
}
