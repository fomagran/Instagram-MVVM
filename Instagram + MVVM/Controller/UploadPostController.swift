//
//  UploadPostController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/09.
//

import UIKit

class UploadPostController: UIViewController {
    
    //MARK:Properties
    
    var currentUser:User?
    
    weak var delegate:UploadPostControllerDelegate?
    
    var selectedImage:UIImage? {
        didSet { photoImageView.image = selectedImage}
    }
    
    private let photoImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var captionTextView : InputTextView = {
       let textView = InputTextView()
        textView.placeholderText = "Enter caption..."
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    
    private let countLabel:UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    
    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        view.addSubview(photoImageView)
        photoImageView.anchor(top:view.safeAreaLayoutGuide.topAnchor,paddingTop: 8)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top:photoImageView.bottomAnchor,left: view.leftAnchor,right:view.rightAnchor,paddingTop: 16,paddingLeft: 12,paddingRight: 12,height: 64)
        
        view.addSubview(countLabel)
        countLabel.anchor(bottom:captionTextView.bottomAnchor,right: view.rightAnchor,paddingBottom: -8,paddingRight: 12)
    }
    
    //MARK: Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Share", style:.done,target: self, action: #selector(didTapShare))
    }
    
    func checkMaxLength(_ textView:UITextView) {
        if textView.text.count > 100 {
            textView.deleteBackward()
        }
    }
    
    //MARK Actions
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapShare() {
        guard let image = selectedImage else { return }
        guard let caption = captionTextView.text else { return }
        guard let user = currentUser else { return }
        showLoader(true)
        PostService.uploadPost(caption: caption, image: image,user: user ) { (error) in
            if let error = error {
                print("DEBUG:Failed to upload post with error\(error.localizedDescription)")
            }
            self.showLoader(false)
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
    
}

//MARK: UITextViewDelegate
extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        countLabel.text = "\(count)/100"
    }
}
