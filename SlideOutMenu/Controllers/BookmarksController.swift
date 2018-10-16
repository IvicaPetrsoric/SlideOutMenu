//
//  BookmarksController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 16/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class BookmarksController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        // usually go for:
//        tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        
        cell.textLabel?.text = "Bookmark: \(indexPath.row)"
        return cell
    }

}
