//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 27/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommentsTableViewController: UITableViewController, CommentsTableViewCellDelegate, StoryTableViewCellDelegate,
LoginViewControllerDelegate{
    
    var story: Story!
    var comments = [Comment]()
    var isLoadFinished = false
    let loginSegue = "loginSegue"
    weak var delegate: CommentsTableViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 119
        tableView.rowHeight = UITableViewAutomaticDimension
        self.loadComment(story)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoadFinished ? (comments.count + 1) : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 0 ? "StoryCell" : "CommentCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as UITableViewCell!
        
        if let storyCell = cell as? StoryTableViewCell{
            storyCell.configureWithStory(story, isCommentEnable: false)
            storyCell.delegate = self
            storyCell.selectionStyle = .none
            return storyCell
        }else {
            let commentCell = cell as! CommentsTableViewCell
            if isThereComments() {
                let comment = comments[indexPath.row - 1]
                commentCell.configureWithComment(comment)
                commentCell.delegate = self
            }
            return commentCell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == loginSegue {
            let toView = segue.destination as! LoginUIViewController
            toView.delegate = self
        }
    }
    
    func commentTableViewCellDidTouchUpvote(_ cell: CommentsTableViewCell, sender: Any) {
        print("comment upvote")
        if let _ = LocalStore.getToken(), let userId = LocalStore.getUserId() {
            let indexPath = tableView.indexPath(for: cell)
            if let index = indexPath {
                let comment = comments[index.row - 1]
                DNService.upvote(comment: comment, userId: userId, completion: { res in
                    if let _ = res?["comment_upvotes"][0]["id"].string {
                        cell.likeComment()
                    }else{
                        cell.unlikeComment()
                    }
                })
            }
        }else {
            performSegue(withIdentifier: loginSegue, sender: self)
        }
    }
    
    func storyTableViewCellDidTouchUpvote(_ cell: StoryTableViewCell, sender: Any) {
        if let _ = LocalStore.getToken() {
            print("teste")
        }else {
            performSegue(withIdentifier: loginSegue, sender: self)
        }
    }
    
    func storyTableViewCellDidTouchComment(_ cell: StoryTableViewCell, sender: Any) {
        
    }
    
    //MARK: delegate LoginUIViewController
    func loginViewControllerDidLogin(_ controller: LoginUIViewController) {
        delegate?.commentTableViewLogin(self)
    }
    
    //MARK: private functions
    private func isThereComments() -> Bool {
        return comments.count > 0
    }
    
    private func loadComment(_ story: Story){
        self.view.showLoading()
        
            if story.commentsIds.count == 0 {
                self.isLoadFinished = true
                self.view.hideLoading()
            }
            
            for commentId in story.commentsIds {
                DNService.comment(byId: commentId.string!, completionHandler: { (JSON) in
                    let commentJSON = JSON["comments"][0]
                    let userId = commentJSON["links"]["user"].string!
                    
                    DNService.profile(byId: userId, completionHandler: { (JSON) -> () in
                        let profile = Profile(userJSON: JSON["users"])
                        let comment = Comment(jsonComment: commentJSON, profile: profile)
                        self.comments.append(comment)
                        
                        if(self.comments.count == story.commentsIds.count){
                            self.isLoadFinished = true
                            self.tableView.reloadData()
                            self.view.hideLoading()
                            self.refreshControl?.endRefreshing()
                        }
                    })
                })
        }
    }
}


protocol CommentsTableViewDelegate : class {
    func commentTableViewLogin(_ controller: CommentsTableViewController)
}
