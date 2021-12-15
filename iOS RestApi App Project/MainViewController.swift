import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.isNavigationBarHidden = true
        
        welcomeLabel.text = """
        님
        환영합니다.
        """
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}


