import UIKit

class TableViewInteractor: NSObject {
    weak var tableView: TableView?

    private var userList: Array<String>?
    
    func configure(with tableView: TableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView = tableView
    }
    
    func setUsers(userList: Array<String>) {
        self.userList = userList
        
        // completion reload finish
        tableView?.performBatchUpdates({
            self.tableView?.reloadData()
        }) { (finished) in
            print("Reload Finished")
        }
    }
}


extension TableViewInteractor: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let userList = userList else {
            return 0
        }
        
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        
        guard let userList = userList else {
            return cell!
        }
        
        let tableCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TableCellTableViewCell.self)
        ) as! TableCellTableViewCell
        
        tableCell.user = userList[indexPath.row]
        
        cell = tableCell
        
        return cell!
    }
}


extension TableViewInteractor: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let destructAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            completionHandler(true)
        }
        destructAction.backgroundColor = .red
        destructAction.image = UIImage(named: "icon_kuma")
        let configuration = UISwipeActionsConfiguration(actions: [destructAction])
        
        return configuration
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
