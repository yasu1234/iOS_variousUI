import UIKit

public protocol XibInstace {
    
    static func identifer() -> String
}

public protocol StoryboardInstance: XibInstace {
    
    static func storyboardName() -> String
}
