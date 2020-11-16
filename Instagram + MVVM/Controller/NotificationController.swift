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
        }
    }
}

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NotificationCell
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        return cell
    }
}
