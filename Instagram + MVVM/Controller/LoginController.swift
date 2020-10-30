//
//  LoginController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/29.
//

import UIKit

class LoginController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }

    
    private var viewModel = LoginViewModel()
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Instagram_logo_white")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5), for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.setHeight(50)
        button.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton : UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(normalString: "Forgot your password?", borderString: "Get help signing it")
        return button
    }()
    
    private let signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(normalString: "Don't gave an account?", borderString: "Sign Up")
        button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: 액션
    
    @objc func showSignUp(){
        navigationController?.pushViewController(SignUpController(), animated: true)
    }
    
    @objc func textDidChange(sender:UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }else{
            viewModel.password = sender.text
        }
        updateUI()
    }
    @objc func tapLoginButton(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to log user in\(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    func configureUI(){
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        //black으로 바꾸면 statusBar자동으로 하얀색으로 바뀜
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.setDimensions(height: 80, width: 120)
        logoImageView.anchor(top:view.safeAreaLayoutGuide.topAnchor,paddingTop: 12)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top:logoImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop:32 ,paddingLeft: 32, paddingRight:32)
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.anchor(top:loginButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 32,paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(signUpButton)
        signUpButton.centerX(inView: view)
        signUpButton.anchor(bottom:view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


//MARK: 입력형식에 맞게 업데이트 formUpdateProtocol
extension LoginController : formUpdateProtocol {
    func updateUI() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formValid
    }
}
