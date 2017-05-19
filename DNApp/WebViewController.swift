//
//  WebViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 25/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

class WebViewController: UIViewController, UIWebViewDelegate {

    let oneSecond = 1.0
    let isToRepeat = true
    
    var url: String!
    var hasFinishedLoading = false
    @IBOutlet weak var webView: UIWebView!
    

    
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let targetURL = URL(string: url)
        let request = URLRequest(url: targetURL!)
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        hasFinishedLoading = false
        updateProgress()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        delay(delay: oneSecond) { [weak self] in
            if let _self = self {
                _self.hasFinishedLoading = true
            }
        }
    }
    
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    func updateProgress() {
        if progressView.progress >= 1 {
            progressView.isHidden = true
        } else {
            
            if hasFinishedLoading {
                progressView.progress += 0.002
            } else {
                if progressView.progress <= 0.3 {
                    progressView.progress += 0.004
                } else if progressView.progress <= 0.6 {
                    progressView.progress += 0.002
                } else if progressView.progress <= 0.9 {
                    progressView.progress += 0.001
                } else if progressView.progress <= 0.94 {
                    progressView.progress += 0.0001
                } else {
                    progressView.progress = 0.9401
                }
            }
            
            delay(delay: 0.008) { [weak self] in
                if let _self = self {
                    _self.updateProgress()
                }
            }
    
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        UIApplication.shared.isStatusBarHidden = false
        dismiss(animated: true, completion: nil)
    }
}
