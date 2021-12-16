import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpNameTextField: UITextField!
    @IBOutlet weak var signUpIdTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpVerifyPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        
        [signUpNameTextField, signUpIdTextField, signUpPasswordTextField, signUpVerifyPasswordTextField].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.black.cgColor
            $0?.layer.cornerRadius = 10
        }
        
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
    }
}
