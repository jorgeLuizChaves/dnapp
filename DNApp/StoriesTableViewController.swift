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

class StoriesTableViewController: UITableViewController,
        StoryTableViewCellDelegate, MenuViewControllerDelegate, LoginViewControllerDelegate,
CommentsTableViewDelegate{
    
    @IBOutlet weak var loginBarButtonItem: UIBarButtonItem!
    
    let webSegue = "WebSegue"
    let menuSegue = "menuSegue"
    let loginSegue = "loginSegue"
    let commentSegue = "commentsSegue"
    let storyCellIdentifier = "StoryCell"
    let transitionManager = TransitionManager()
    
    
    var section = ""
    var isFirstTime = true
    var stories: [Story] = []
    var userStory: JSON! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutLoginValidation()
        
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
    }
    
    // MARK: Table View Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyCellIdentifier) as! StoryTableViewCell
        
        let story = stories[indexPath.row]
        cell.delegate = self
        cell.configureWithStory(story)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: webSegue, sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Delegate LoginViewController
    func loginViewControllerDidLogin(_ controller: LoginUIViewController) {
         loadStories("", page: 1)
        view.showLoading()
    }
    
    // MARK: Events Touches
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: loginSegue, sender: self)
    }

    @IBAction func menuButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: menuSegue, sender: self)
    }
    
    // MARK: StoryTableViewCellDelegate
    func storyTableViewCellDidTouchUpvote(_ cell: StoryTableViewCell, sender: Any) {
        if let token = LocalStore.getToken(), let userId = LocalStore.getUserId() {
            let indexPath = tableView.indexPath(for: cell)!
            let story = stories[indexPath.row]
            DNService.upvoteStoryWithId(story, userId: userId, token: token, completion: { (res) in
                    if let upvoteId = res?["upvotes"][0]["id"].string {
                        LocalStore.addStoryUpvotes(upvoteId: upvoteId)
                        cell.upvoteButton.setImage(UIImage(named: "icon-upvote-active"), for: .normal)
                        cell.upvoteButton.setTitle(String(story.voteCount + 1), for: .normal)
                    }
                })
        }else {
            performSegue(withIdentifier: loginSegue, sender: self)
        }
    }
    
    func storyTableViewCellDidTouchComment(_ cell: StoryTableViewCell, sender: Any) {
        performSegue(withIdentifier: commentSegue, sender: cell)

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
    
    func menuViewControllerDidTouchLogout(_ controller: MenuViewController) {
        view.showLoading()
        loadStories("", page: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == commentSegue {
            let toView = segue.destination as! CommentsTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let story = stories[indexPath.row]
            toView.delegate = self
            toView.story = story
        }
        
        if segue.identifier == webSegue {
            let toView = segue.destination as! WebViewController
            let indexPath = sender as! IndexPath
            let story = stories[indexPath.row]
            toView.url = story.storyUrl
            
            UIApplication.shared.isStatusBarHidden = true
            toView.transitioningDelegate = transitionManager
        }
        
        if segue.identifier == menuSegue {
            let toView = segue.destination as! MenuViewController
            toView.delegate = self
        }
        
        if segue.identifier == loginSegue {
            let toView = segue.destination as! LoginUIViewController
            toView.delegate = self
        }
    }
    
    func commentTableViewLogin(_ controller: CommentsTableViewController) {
        self.layoutLoginValidation()
    }
    
    func layoutLoginValidation() {
        if let _ = LocalStore.getToken() {
            loginBarButtonItem.title = ""
            loginBarButtonItem.isEnabled = false
        }else {
            loginBarButtonItem.title = "Login"
            loginBarButtonItem.isEnabled = true
        }
    }
    
    func loadStories(_ section: String, page: Int) {
        
        layoutLoginValidation()
        
        self.stories = []
        self.tableView.reloadData()
        DNService.storiesForSection(section, page: page) { (JSON) -> () in
            self.userStory = JSON["stories"]
            let storiesJson = self.userStory.array ?? []
            for storyJSON in storiesJson {
                if(self.stories.count < JSON["stories"].array!.count){
                    let userId = storyJSON["links"]["user"].string ?? ""
                    DNService.profile(byId: userId, completionHandler: { (JSON) -> () in
                        let profile = Profile(userJSON: JSON["users"])
                        let story = Story(story: storyJSON, profile: profile)
                        self.stories.append(story)
                        
                        if(self.stories.count == self.userStory!.count){
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
