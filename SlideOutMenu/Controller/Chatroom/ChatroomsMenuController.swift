//
//  ChatroomsMenuController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 23/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class ChatroomsMenuController: UITableViewController {
    
    private let chatroomGroups = [
        ["general", "introductions"],
        ["jobs"],
        ["Brian Voong", "Steve Jobs", "Tim Cook", "Barack Obama"]
    ]
    
    private var filteredResults = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredResults = chatroomGroups
        
        tableView.backgroundColor = .purple
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.2078431373, blue: 0.3843137255, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = section == 0 ? "UNREADS" : section == 1 ? "Channels" : "Direct messages"
        let label = ChatroomHeaderLabel()
        label.text = text
        label.textColor = UIColor.init(white: 0.8, alpha: 0.6)
        label.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.2078431373, blue: 0.3843137255, alpha: 1)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredResults.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatroomMenuCell(style: .default, reuseIdentifier: nil)
        cell.titleText = filteredResults[indexPath.section][indexPath.row]
        return cell
    }
    
    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ChatroomsMenuController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredResults = chatroomGroups
            reloadTableView()
            return
        }
        
        filteredResults = chatroomGroups.map({ (group) -> [String] in
            return group.filter{ $0.lowercased().contains(searchText.lowercased()) }
        })
        
        reloadTableView()
    }
    
}

