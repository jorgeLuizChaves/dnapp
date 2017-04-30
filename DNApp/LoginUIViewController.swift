//
//  LoginUIViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 14/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

class LoginUIViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    @IBOutlet weak var passwordImageView: SpringImageView!
    @IBOutlet weak var emailImageView: SpringImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonDidTouch(_ sender: DesignableButton) {
        
        self.errorLogin()
        
    }
    
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        dialogView.animation = "zoomOut"
        dialogView.animate()
    }
    
    
    private func errorLogin() {
        dialogView.animation = "shake"
        dialogView.animate()
    }
    
    //MARK: TextView Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailImageView.image = UIImage(named: "icon-mail-active")
            emailImageView.animate()
        } else {
            emailImageView.image = UIImage(named: "icon-mail")
        }
        
        if textField == passwordTextField {
            passwordImageView.image = UIImage(named: "icon-password-active")
            passwordImageView.animate()
        } else {
            passwordImageView.image = UIImage(named: "icon-password")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailImageView.image = UIImage(named: "icon-mail")
        passwordImageView.image = UIImage(named: "icon-password")
    }
}
