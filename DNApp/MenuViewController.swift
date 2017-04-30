//
//  MenuViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 25/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

class MenuViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: MenuViewControllerDelegate?


    @IBOutlet weak var dialogView: DesignableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        dialogView.animation = "fall"
        dialogView.animate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

protocol MenuViewControllerDelegate: class {
    func menuViewControllerDidTouchTop(_ controller: MenuViewController)
    func menuViewControllerDidTouchRecent(_ controller: MenuViewController)
}
