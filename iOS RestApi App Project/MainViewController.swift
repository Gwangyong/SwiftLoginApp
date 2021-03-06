import UIKit

class MainViewController: UIViewController {
    var data: String?
    
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.isNavigationBarHidden = true
        
        guard let data = data else { return }
        welcomeLabel.text = """
        \(data)님
        환영합니다.
        """
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}


