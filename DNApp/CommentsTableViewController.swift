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
    var comments = [JSON]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(story)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.loadComment(story)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count + 1
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 0 ? "StoryCell" : "CommentCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as UITableViewCell!
        
        if let storyCell = cell as? StoryTableViewCell{
//            storyCell.configureWithStory(story, user: user)
            return storyCell
        }else {
            let commentCell = cell as! CommentsTableViewCell
            if comments.count > 0 {
                let comment = comments[indexPath.row - 1]["comments"][0]
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
//                    self.comments.append(JSON)
//                    if(self.comments.count == story["links"]["comments"].array?.count){
//                        self.tableView.reloadData()
//                        self.view.hideLoading()
//                        self.refreshControl?.endRefreshing()
//                    }
                })
        }
    }

}
