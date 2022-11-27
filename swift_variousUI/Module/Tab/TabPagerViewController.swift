import Parchment
import TTGSnackbar
import UIKit

class TabPagerViewController: UIViewController {
    private var pagingViewController: PagingViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension TabPagerViewController {
    private func setupUI() {
        setupTab()
        setupSnackBar()
    }
    
    private func setupTab() {
        let firstViewController = UIViewController()
        firstViewController.title = "First"
        let secondViewController = UIViewController()
        secondViewController.title = "Second"
        
        let pagingViewController = PagingViewController(viewControllers: [
            firstViewController,
            secondViewController
        ])
        
        self.pagingViewController = pagingViewController
        
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        // select cell's underline color
        pagingViewController.indicatorColor = UIColor.green
        pagingViewController.selectedTextColor = UIColor.green
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setupSnackBar() {
        let snackbar = TTGSnackbar(
            message: "TTGSnackbarTTGSnackbarTTGSnackbarTTGSnackbarTTGSnackbarTTGSnackbar !",
            duration: .middle
        )
        snackbar.cornerRadius = 10
        snackbar.backgroundColor = UIColor.green
        snackbar.actionTextColor = UIColor.white
        snackbar.actionTextFont = UIFont.boldSystemFont(ofSize: 15)
        snackbar.actionTextNumberOfLines = 2
        snackbar.animationType = .slideFromTopBackToTop
        snackbar.show()
    }
}

extension TabPagerViewController: StoryboardInstance {
    static func newInstance() -> TabPagerViewController {
        let controller = UIStoryboard(name:TabPagerViewController.storyboardName(), bundle: nil).instantiateViewController(withIdentifier: TabPagerViewController.identifer()) as! TabPagerViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Tab"
    }
    
    static func identifer() -> String {
        return String(describing: TabPagerViewController.self)
    }
}
