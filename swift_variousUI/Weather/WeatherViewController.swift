//
//  WeatherViewController.swift
//  swift_variousUI
//
//  Created by kuma on 2020/10/18.
//  Copyright © 2020 kuma. All rights reserved.
//

import UIKit

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
