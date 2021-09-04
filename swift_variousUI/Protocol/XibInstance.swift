//
//  XibInstance.swift
//  swift_variousUI
//
//  Created by kuma on 2020/10/18.
//  Copyright © 2020 kuma. All rights reserved.
//

import UIKit

public protocol XibInstace {
    
    static func identifer() -> String
}

public protocol StoryboardInstance: XibInstace {
    
    static func storyboardName() -> String
}
