import UIKit

class MainTabBarController: UITabBarController {
    enum TabType: Int, CaseIterable {
        case collection
        case tabPager
        case segment
        
        func controllerInstance() -> UIViewController? {
            switch self {
            case .collection:
                let controller = CollectionViewController.newInstance()
                controller.title = "Collection"
                return controller
            case .tabPager:
                let controller = TabPagerViewController.newInstance()
                controller.title = "TabPager"
                return controller
            case .segment:
                let controller = SegmentViewController.newInstance()
                controller.title = "Segment"
                return controller
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension MainTabBarController {
    private func setupUI() {
        setupTab()
    }
    
    private func setupTab() {
        var tabBarController = [UIViewController]()
        
        for tabType in TabType.allCases {
            let controller = tabType.controllerInstance()
            
            if let controller = controller {
                let navigationController = UINavigationController(rootViewController: controller)
                tabBarController.append(navigationController)
            }
        }
        
        viewControllers = tabBarController
    }
}
