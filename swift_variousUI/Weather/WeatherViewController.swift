//
//  WeatherViewController.swift
//  swift_variousUI
//
//  Created by kuma on 2020/10/18.
//  Copyright © 2020 kuma. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension WeatherViewController: StoryboardInstance {

    static func newInstance() -> WeatherViewController {
        let controller = UIStoryboard(name:WeatherViewController.storyboardName(), bundle: nil).instantiateViewController(withIdentifier: WeatherViewController.identifer()) as! WeatherViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Weather"
    }
    
    static func identifer() -> String {
        return String(describing: WeatherViewController.self)
    }
    
}

extension WeatherViewController: SwipeMenuViewDataSource {
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        <#code#>
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        <#code#>
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        <#code#>
    }
}
