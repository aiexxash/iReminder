import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var logInAccountButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func createButtonClicked(_ sender: UIButton) {
    }
    @IBAction func logInAccountButtonClicked(_ sender: UIButton) {
        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        self.navigationController?.pushViewController(logInVC, animated: true)
    }
}
