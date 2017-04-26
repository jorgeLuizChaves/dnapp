//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 25/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell") as! StoryTableViewCell
        
        let story = data[indexPath.row]
        cell.delegate = self
        cell.configureWithStory(story as AnyObject)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "WebSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: Events Touches
    
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }

    @IBAction func menuButtonDidTouch(_ sender: Any) {
        
        performSegue(withIdentifier: "menuSegue", sender: self)
        
    }
    
    // MARK: StoryTableViewCellDelegate
    func storyTableViewCellDidTouchUpvote(_ cell: StoryTableViewCell, sender: Any) {
        //TODO: Implement Upvote
    }
    
    func storyTableViewCellDidTouchComment(_ cell: StoryTableViewCell, sender: Any) {
        performSegue(withIdentifier: "commentsSegue", sender: cell)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
