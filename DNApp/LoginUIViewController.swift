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
    @IBOutlet weak var emailImageView: SpringImageView!
    @IBOutlet weak var passwordImageView: SpringImageView!
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    weak var delegate : LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginButtonDidTouch(_ sender: DesignableButton) {
        sender.animation = "pop"
        sender.force = 0.1
        sender.animate()
        if let login = emailTextField.text, let password = passwordTextField.text {
            DNService.loginWithEmail(login: login, password: password) { (jsonToken) in
                if let token = jsonToken {
                    let tokenString = String(token)
                    LocalStore.saveToken(tokenString!)
                    DNService.me(byToken: tokenString!, completionHandler: { jsonUser in
                        print(jsonUser?.rawValue ?? "vazio")
                            let userId = jsonUser?["id"].rawValue as! String
                            let upvotes = jsonUser?["links"]["upvotes"].rawValue as! [String]
                            LocalStore.saveUserId(userId)
                            LocalStore.saveUpvotes(upvotes)
                    })
                    self.delegate?.loginViewControllerDidLogin(self)
                    self.dismiss(animated: true, completion: nil)
                }else {
                    self.errorLogin()
                }
            }
        }
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

protocol LoginViewControllerDelegate: class {
    func loginViewControllerDidLogin(_ controller: LoginUIViewController)
}
