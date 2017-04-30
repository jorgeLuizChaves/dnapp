//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 25/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring
import SwiftyJSON

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate {
    
    
    let transitionManager = TransitionManager()
    var stories: JSON! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        loadStories("", page: 1)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell") as! StoryTableViewCell
        
        let story = stories[indexPath.row]
        cell.delegate = self
        cell.configureWithStory(story as JSON)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "WebSegue", sender: indexPath)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentsSegue" {
            let toView = segue.destination as! CommentsTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let story = stories[indexPath.row] as JSON
            toView.story = story
        }
        
        if segue.identifier == "WebSegue" {
            let toView = segue.destination as! WebViewController
            let indexPath = sender as! IndexPath
            let story = stories[indexPath.row] as JSON
            toView.url = story["url"].string!
            
            UIApplication.shared.isStatusBarHidden = true
            toView.transitioningDelegate = transitionManager


        }
    }
    
    func loadStories(_ section: String, page: Int) {
        DNService.storiesForSection(section, page: page) { (JSON) -> () in
            self.stories = JSON["stories"]
            self.tableView.reloadData()
        }
    }

}
