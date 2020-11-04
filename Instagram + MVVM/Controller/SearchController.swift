//
//  SearchController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//
import UIKit

private let reuseIdentifier = "SearchCell"
class SearchController: UITableViewController {
    
    
    //MARK: Properties
    private var users = [User]()
    private var filteredUsers = [User]()
    private var searchController = UISearchController(searchResultsController: nil)
    private var isSearchMode:Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    //MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchUsers()
    }
    
    
    
    //MARK:Helpers
    func configure() {
        view.backgroundColor = .white
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    func fetchUsers(){
        UserService.fetchUsers { (users) in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
}

//MARK: Delegate
extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user =  isSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = MyPageController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
    }
}

//MARK: DataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchMode ? filteredUsers.count : users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SearchCell
        let user =  isSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = SearchViewModel(user: user)
        return cell
    }
}

//MARK:UISearchResultsUpdatingDelegate
//검색어가 바뀔때마다 업데이트됨
extension SearchController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        guard  let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter({$0.username.contains(searchText.lowercased()) || $0.fullname.contains(searchText.lowercased())})
        tableView.reloadData()
    }
}

