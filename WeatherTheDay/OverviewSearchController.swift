import UIKit
import Material

class OverviewSearchController: SearchBarController {
    private var menuButton: IconButton!
    private var moreButton: IconButton!
    
    open override func prepare() {
        super.prepare()
        prepareMenuButton()
        prepareMoreButton()
        prepareStatusBar()
        prepareSearchBar()
    }
    
    private func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
    }
    
    private func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreVertical)
    }
    
    private func prepareStatusBar() {
        statusBarStyle = .lightContent
    }
    
    private func prepareSearchBar() {
        searchBar.leftViews = [menuButton]
        searchBar.rightViews = [moreButton]
    }
}

