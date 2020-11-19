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
            self.checkIfUserFollowed()
        }
    }
    
    func checkIfUserFollowed() {
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
//MARK: UITableViewDelegate
extension NotificationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserService.fetchUser(uid: notifications[indexPath.row].uid) { (user) in
            let controller = MyPageController(user:user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

//MARK:NotificationCellDelegate

extension NotificationController:NotificationCellDelegate {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String) {
        UserService.follow(uid: uid) { (_) in
            cell.viewModel?.notification.isUserFollowed.toggle()
        }
       
    }
    
    func cell(_ cell: NotificationCell, wantsToUnfollow uid: String) {
        UserService.unfollow(uid: uid) { (_) in
            cell.viewModel?.notification.isUserFollowed.toggle()
        }
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        PostService.fetchPost(withPostId: postId) { (post) in
            let controller = MainController(collectionViewLayout: UICollectionViewFlowLayout())
            controller.post = post
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}
