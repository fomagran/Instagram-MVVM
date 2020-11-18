//
//  NotificationController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//
import UIKit

private let reuseIdentifier = "Cell"
class NotificationController: UITableViewController {
    
   private  var notifications = [Notification]() {
        didSet { tableView.reloadData()}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchNotifications()
        checkIfUserFolloed()
    }
    
    //MARK: Helper
    func configure(){
        view.backgroundColor = .white
        navigationItem.title = "Notification"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    func fetchNotifications(){
        NotificationService.fetchNotifications { (notifications) in
            self.notifications = notifications
        }
    }
    
    func checkIfUserFolloed() {
        notifications.forEach { (notification) in
            guard notification.type == .follow else {return}
            
            UserService.checkIfUserFolloed(uid: notification.uid) { (isFollowed) in
                if let index = self.notifications.firstIndex(where: {$0.id == notification.id}) {
                    self.notifications[index].isUserFollowed = isFollowed
                }
            }
        }
    }
}

//MARK: UITableViewDataSource
extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NotificationCell
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
}

//MARK:NotificationCellDelegate

extension NotificationController:NotificationCellDelegate {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String) {
        print("DEBUG:follow")
    }
    
    func cell(_ cell: NotificationCell, wantsToUnfollow uid: String) {
        print("DEBUG:unfollow")
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        print("DEBUG:viewpost")
    }
    
    
}
