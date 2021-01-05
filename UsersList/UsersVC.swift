//
//  UsersVC.swift
//  UsersList
//
//  Created by Anna Sibirtseva on 04/01/2021.
//

import UIKit

class UsersVC: UITableViewController {
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.city
        return cell
    }
}

//MARK:  - Networking
    
extension UsersVC {
    func getUsers() {
        let baseUrl = "https://jsonplaceholder.typicode.com/"
        guard let usersUrl = URL(string: (baseUrl + "users")) else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: usersUrl) { (data, response, error) in
            if let response = response  as? HTTPURLResponse{
                print(response.statusCode)
            }
            
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else { return }
                    var users = [User]()
                    for user in json {
                        guard
                            let name = user["name"] as? String,
                            let address = user["address"] as? [String : Any],
                            let city = address["city"] as? String
                        else { return }
                        
                        let user = User(name: name, address: address, city: city)
                        users.append(user)
                    }
                    self.users = users
                    //UI element tableView must be reloaded on main thread, while data fetching was sent on background thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        dataTask.resume()
    }
}
