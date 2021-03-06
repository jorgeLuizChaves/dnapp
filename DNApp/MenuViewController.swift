//
//  MenuViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 25/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

class MenuViewController: UIViewController, UITextViewDelegate, LoginViewControllerDelegate {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var dialogView: DesignableView!
    weak var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginLabel.text = isLogged() ? "Logout" : "Login"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func topButtonDidTouch(_ sender: Any) {
        delegate?.menuViewControllerDidTouchTop(self)
        closeButtonDidTouch(sender)
    }
    
    @IBAction func recentButtonDidTouch(_ sender: Any) {
        delegate?.menuViewControllerDidTouchRecent(self)
        closeButtonDidTouch(sender)
    }
    
    
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        if isLogged() {
            LocalStore.deleteToken()
            LocalStore.deleteUserId()
            LocalStore.deleteUpvotes()
            LocalStore.deleteCommentUpvotes()
            
            closeButtonDidTouch(sender)
            delegate?.menuViewControllerDidTouchLogout(self)
        }else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            let toView = segue.destination as! LoginUIViewController
            toView.delegate = self
        }
    }
    
    func loginViewControllerDidLogin(_ controller: LoginUIViewController) {
        delegate?.menuViewControllerDidTouchLogout(self)
        closeButton.sendActions(for: .touchUpInside)
        
    }
    
    
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        dialogView.animation = "fall"
        dialogView.animate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func isLogged() -> Bool {
        if LocalStore.getToken() != nil {
            return true
        }
        return false
    }

}

protocol MenuViewControllerDelegate: class {
    func menuViewControllerDidTouchTop(_ controller: MenuViewController)
    func menuViewControllerDidTouchRecent(_ controller: MenuViewController)
    func menuViewControllerDidTouchLogout(_ controller: MenuViewController)
}
