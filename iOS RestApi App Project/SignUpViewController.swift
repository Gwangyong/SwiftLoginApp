import UIKit

class SignUpViewController: UIViewController {
    
    var essentialFieldList = [UITextField]()
    
    @IBOutlet weak var signUpNameTextField: UITextField!
    @IBOutlet weak var signUpIdTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpVerifyPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.isNavigationBarHidden = false
        
        [signUpNameTextField, signUpIdTextField, signUpPasswordTextField, signUpVerifyPasswordTextField].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.black.cgColor
            $0?.layer.cornerRadius = 10
        }
        essentialFieldList = [signUpNameTextField, signUpIdTextField, signUpPasswordTextField, signUpVerifyPasswordTextField]
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        // 위에 viewDidLoad() 에서 정의해준 essentialFieldList, 필수 정의 항목에 있는 것들 다 있는지 확인하면서 각 함수들로 확인, 에러 Alert
        for field in essentialFieldList {
            if !isFilled(field) {
                signUpAlert(field)
                break
            }
        }
        
        func isFilled(_ textField: UITextField) -> Bool {
            guard let text = textField.text, !text.isEmpty else {
                return false
            }
            return true
        }
        
        // 비어있는 곳이 있을때 나오는 Alert 종류들
        func signUpAlert(_ field: UITextField) {
            DispatchQueue.main.async {
                var title = ""
                switch field {
                case self.signUpNameTextField:
                    title = "이름을 입력해주세요."
                case self.signUpIdTextField:
                    title = "아이디를 입력해주세요"
                case self.signUpPasswordTextField:
                    title = "비밀번호를 입력해주세요."
                case self.signUpVerifyPasswordTextField:
                    title = "비밀번호를 확인해주세요."
                default:
                    title = "Error"
                }
                let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .cancel) { (action) in
                    
                }
                
                controller.addAction(okAction)
                self.present(controller, animated: true, completion: nil)
            }
        }
        
        // 비밀번호가 일치하는지 passwordAlert 함수로 이동해서 확인
        guard let password = signUpPasswordTextField.text, let passwordCheck = signUpVerifyPasswordTextField.text, password == passwordCheck else {
            passwordAlert(title: "비밀번호가 일치하지 않습니다.")
            return
        }
        
        showInfoAlert(with: "회원가입이 완료되었습니다.")
        
        // 위에 코드들의 오류 Alert이 아닌, 전부 통과된 확인 Alert
        func showInfoAlert(with title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    // 회원가입이 되고 확인을 누르고 난 후, completion handler를 사용해 RootViewController로 이동
                    self.navigationController?.popToRootViewController(animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
        func passwordAlert(title: String) {
            DispatchQueue.main.async {
                let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                let okAlert = UIAlertAction(title: "확인", style: .cancel) { (action) in
                    
                }
                
                controller.addAction(okAlert)
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}
