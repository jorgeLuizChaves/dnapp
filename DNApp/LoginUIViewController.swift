//
//  LoginUIViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 14/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

class LoginUIViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
}
