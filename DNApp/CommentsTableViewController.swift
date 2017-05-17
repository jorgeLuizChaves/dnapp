//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by Jorge Luiz on 27/04/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommentsTableViewController: UITableViewController {
    
    var story: Story!
    var comments = [Comment]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(story)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.loadComment(story)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (comments.count + 1)
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 0 ? "StoryCell" : "CommentCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as UITableViewCell!
        
        if let storyCell = cell as? StoryTableViewCell{
            storyCell.configureWithStory(story)
            return storyCell
        }else {
            let commentCell = cell as! CommentsTableViewCell
            if comments.count > 0 {
                let comment = comments[indexPath.row - 1]
                commentCell.configureWithComment(comment)
            }
            return commentCell
        }
    }
    
    private func loadComment(_ story: Story){
        self.view.showLoading()
        
            if story.commentsIds.count == 0 {
                self.view.hideLoading()
            }
            
            for commentId in story.commentsIds {
                DNService.comment(byId: commentId.string!, completionHandler: { (JSON) in
                    print("user: \(JSON["comments"][0]["links"]["user"])")
                    let commentJSON = JSON["comments"][0]
                    let userId = commentJSON["links"]["user"].string!
                    
                    DNService.profile(byId: userId, completionHandler: { (JSON) -> () in
                        let profile = Profile(userJSON: JSON["users"])
                        let comment = Comment(jsonComment: commentJSON, profile: profile)
                        self.comments.append(comment)
                        
                        if(self.comments.count == story.commentsIds.count){
                            self.tableView.reloadData()
                            self.view.hideLoading()
                            self.refreshControl?.endRefreshing()
                        }
                    })
                })
        }
    }

}
