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

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate, MenuViewControllerDelegate {
    
    
    let transitionManager = TransitionManager()
    var stories: [Story] = []
    var isFirstTime = true
    var section = ""
    var userStory: JSON! = []
    var countStories: Int = 0



    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        loadStories("", page: 1)
        
        refreshControl?.addTarget(self, action: #selector(self.refreshStories), for: UIControlEvents.valueChanged)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if isFirstTime {
            view.showLoading()
            isFirstTime = false
        }
        
    }
    
    func refreshStories() {
        loadStories(section, page: 1)
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
        cell.configureWithStory(story)
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
    
    // MARK: Delegate MenuUIViewController
    func menuViewControllerDidTouchTop(_ controller: MenuViewController) {
        section = ""
        view.showLoading()
        loadStories("", page: 1)
        navigationItem.title = "Top Stories"
    }
    
    func menuViewControllerDidTouchRecent(_ controller: MenuViewController) {
        section = "recent"
        view.showLoading()
        loadStories("recent", page: 1)
        navigationItem.title = "Recent Stories"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentsSegue" {
            let toView = segue.destination as! CommentsTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let story = stories[indexPath.row]
            toView.story = story
        }
        
        if segue.identifier == "WebSegue" {
            let toView = segue.destination as! WebViewController
            let indexPath = sender as! IndexPath
            let story = stories[indexPath.row]
            toView.url = story.storyUrl
            
            UIApplication.shared.isStatusBarHidden = true
            toView.transitioningDelegate = transitionManager
        }
        
        if segue.identifier == "menuSegue" {
            let toView = segue.destination as! MenuViewController
            toView.delegate = self
        }
    }
    
    func loadStories(_ section: String, page: Int) {
        DNService.storiesForSection(section, page: page) { (JSON) -> () in
            self.countStories = 0
            self.userStory = JSON["stories"]
            let storiesJson = self.userStory.array ?? []
            for storyJSON in storiesJson {
                if(self.countStories < JSON["stories"].array!.count){
                    let userId = storyJSON["links"]["user"].string ?? ""
                    DNService.profile(byId: userId, completionHandler: { (JSON) -> () in
                        let profile = Profile(userJSON: JSON["users"])
                        let story = Story(story: storyJSON, profile: profile)
                        self.countStories = self.countStories + 1
                        self.stories.append(story)
                        
                        if(self.countStories == self.userStory!.count){
                            self.tableView.reloadData()
                            self.view.hideLoading()
                            self.refreshControl?.endRefreshing()
                        }
                    })
                }
            }
        }
    }
}
