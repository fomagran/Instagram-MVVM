//
//  SignUpController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/29.
//

import UIKit

class SignUpController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
        updateUI()
    }
    
    private var viewModel = SignUpViewModel()
    
    private let plusButton : UIButton = {
        //Button에 type을 붙여야 tintColor가 바뀜
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapPlusButton), for: .touchUpInside)
        return button
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
    
    private let fullnameTextField:UITextField = CustomTextField(placeholder: "Fullname")
    private let usernameTextField:UITextField = CustomTextField(placeholder: "Username")
    
    private let signUpButton : UIButton = {
       let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5), for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(50)
        button.isEnabled = false
        return button
    }()
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(normalString: "Already have an account", borderString: "Log in")
        button.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        return button
    }()
    
    @objc func showLogin(){
        navigationController?.popViewController(animated: true)
    }
    @objc func tapPlusButton(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func textDidChange(sender:UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }else if sender == passwordTextField{
            viewModel.password = sender.text
        }else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        }else{
            viewModel.username = sender.text
        }
        updateUI()
    }
    
    func configureUI(){
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(plusButton)
        plusButton.anchor(top:view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        plusButton.centerX(inView: view)
        plusButton.setDimensions(height: 140, width: 140)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,fullnameTextField,usernameTextField,signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top:plusButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop:32 ,paddingLeft: 32, paddingRight:32)
        
     
        view.addSubview(loginButton)
        loginButton.centerX(inView: view)
        loginButton.anchor(bottom:view.safeAreaLayoutGuide.bottomAnchor)
    }
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


//MARK: 입력형식에 맞게 업데이트 formUpdateProtocol
extension SignUpController : formUpdateProtocol {
    func updateUI() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formValid
    }
}

extension SignUpController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        plusButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        plusButton.layer.borderWidth = 2
        plusButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        plusButton.layer.cornerRadius = plusButton.frame.width/2
        plusButton.layer.masksToBounds = true
        dismiss(animated: true, completion: nil)
    }
}

