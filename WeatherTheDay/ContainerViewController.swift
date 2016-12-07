import Foundation
import UIKit


class ContainerViewController : UIViewController {
    @IBOutlet weak var container: UIView!
    
    var viewController : UIViewController!
    
    
    override func viewDidLoad() {
        loadChildViewController("Overview")
    }
    
    func loadChildViewController(_ name: String) {
        removeChildViewController()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: name)
        viewController.view.frame = container.frame
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    func removeChildViewController() {
        if let viewController = viewController {
            viewController.willMove(toParentViewController: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
        }
    }
    
    func unwindTo(segue: UIStoryboardSegue, name: String) {
        if let controller = segue.destination as? ContainerViewController {
            controller.loadChildViewController(name)
        }
    }
    
    
    @IBAction func unwindToOverview(segue: UIStoryboardSegue) {
        unwindTo(segue: segue, name: "Overview")
    }
    
    @IBAction func unwindToHourly(segue: UIStoryboardSegue) {
        unwindTo(segue: segue, name: "Hourly")
    }
    
    @IBAction func unwindToWeekly(segue: UIStoryboardSegue) {
        unwindTo(segue: segue, name: "Weekly")
    }
    
//    @IBAction override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let identifier = segue.identifier == nil ? "Overview" : segue.identifier!
//        
//        if let subview = container.subviews.last {
//            subview.removeFromSuperview()
//        }
//        
//        for scene in ["Overview", "Hourly", "Weekly"] {
//            if identifier.hasSuffix(scene) {
//                loadChildViewController(scene)
//                break;
//            }
//        }
//        
//    }

}
