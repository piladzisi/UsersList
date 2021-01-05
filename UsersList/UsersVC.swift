//
//  UsersVC.swift
//  UsersList
//
//  Created by Anna Sibirtseva on 04/01/2021.
//

import UIKit

class UsersVC: UITableViewController {
    
    let tempUsers = ["A", "B", "C", "D", "F"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world")
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = tempUsers[indexPath.row]
        cell.textLabel?.text = user
        return cell
    }
}
