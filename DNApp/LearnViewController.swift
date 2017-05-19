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
    
    let twitterUrl = "http://twitter.com/mengto"
    let designCodeUrl = "https://designcode.io/"
    
    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var bookImageView: SpringImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dialogView.animate()
    }
    
    @IBAction func learnButtonDidTouch(_ sender: UIButton) {
        bookImageView.animation = "pop"
        bookImageView.animate()
        performSegue(withIdentifier: "WebSegue", sender: nil)
    }
    
    @IBAction func twitterButtonDidTouch(_ sender: Any) {
        openURL(twitterUrl)
    }
    
    @IBAction func closeButtonDidTouch(_ sender: UIButton) {
        dialogView.animation = "fall"
        
        dialogView.animateNext {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebSegue" {
            let toView = segue.destination as! WebViewController
            toView.url = designCodeUrl
        }
    }
    
    func openURL(_ url: String) {
        let targetURL = URL(string: url)
        UIApplication.shared.open(targetURL!, options: [:], completionHandler: nil)
    }
}
