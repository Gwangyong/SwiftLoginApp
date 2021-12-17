import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idTextField.becomeFirstResponder()
        
        // nextButton이 눌리지 않도록.
        loginButton.isEnabled = false
        idTextField.delegate = self
        passwordTextField.delegate = self
        
        
        [idTextField, passwordTextField].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.black.cgColor
            $0?.layer.cornerRadius = 10
        }
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 20
    }
    
    
    // 버튼을 누르면 id와 password에 들어가서 getUserInformation 함수에 매개변수로 받도록.
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if let id = self.idTextField.text, let password = self.passwordTextField.text {
            self.getUserInformation(id: id, password: password)
            self.view.endEditing(true)
        }
    }

    
    // Segue로 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondVC = segue.destination as? MainViewController else { return }
        secondVC.data = self.idTextField.text
        self.idTextField.text = "학번"
        self.passwordTextField.text = "비밀번호"
    }
    
    
    // MARK: - POST 요청으로 로그인 시도
    func getUserInformation(id: String, password: String) {
        let param = ["id" : id, "password" : password]
        let paramData = try? JSONSerialization.data(withJSONObject: param, options: [])
        
        let url = URL(string: "https://83c1d5ce-61a5-4d74-93a5-acbb1117c669.mock.pstmn.io/testapi/second")
        
        var request = URLRequest(url: url!)
        request.httpBody = paramData
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            guard let json = try? decoder.decode(ResponseData.self, from: data) else { return }
            print(json)

            DispatchQueue.main.async {
                if let e = error {
                    self.errorMessageLabel.text = e.localizedDescription
                }
                
            }
            
        }.resume()
    }
    
}

// Delegate 사용
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // 텍스트 작성이 끝났을 경우,
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Email과 Password가 비어있지 않으면, nextButton 버튼이 활성화되도록
        let isEmailEmpty = idTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        loginButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
