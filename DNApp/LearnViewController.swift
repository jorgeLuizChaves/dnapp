//
//  LearnViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 16/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

class LearnViewController: UIViewController {
    
    @IBOutlet weak var bookImageView: SpringImageView!
    
    @IBOutlet weak var dialogView: DesignableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        dialogView.animate()
    }
    
    
    @IBAction func learnButtonDidTouch(_ sender: UIButton) {
        bookImageView.animation = "pop"
        bookImageView.animate()
    }
    
    @IBAction func closeButtonDidTouch(_ sender: UIButton) {
        dialogView.animation = "fall"
        
        dialogView.animateNext {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
