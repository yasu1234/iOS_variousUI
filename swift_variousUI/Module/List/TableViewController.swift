import UIKit

class TableViewController: UIViewController {
    @IBOutlet private weak var tableView: TableView!
    
    private let interactor = TableViewInteractor()
    private let userList = ["John", "Don", "Anne", "Frank", "Tom", "Kuma", "Norman", "Sho"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI

extension TableViewController {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        interactor.configure(with: tableView)
        interactor.setUsers(userList: userList)
    }
}

extension TableViewController: StoryboardInstance {
    static func newInstance() -> TableViewController {
        let controller = UIStoryboard(
            name:TableViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(withIdentifier: TableViewController.identifer())
        as! TableViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "List"
    }
    
    static func identifer() -> String {
        return String(describing: TableViewController.self)
    }
}
