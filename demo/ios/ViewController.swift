import UIKit
import GLKit
import sdk_ios_sdk

/**
 * View controller of the sample application
 */
class ViewController: UIViewController {
    var customView: CustomView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        customView = CustomView.init(frame: UIScreen.main.bounds)
        self.view = customView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
