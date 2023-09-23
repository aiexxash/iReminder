import UIKit
import FirebaseAuth
import Firebase

class LogInViewController: UIViewController {
    @IBOutlet weak var createNewAccountButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    static var logInError: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        let error = Helping.checkTextFields(errorLabel: errorLabel, nicknameField: emailTextField,passwordField: passwordTextField)
         
        guard error == nil else {
            Helping.showError(text: error!, label: errorLabel, textFields:
                                [emailTextField,passwordTextField])
            return
        }
         
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        if error != nil {
            Helping.showError(text: error!.localizedDescription, label: self.errorLabel, textFields: [self.emailTextField, self.passwordTextField])
        }
        else {
            let destVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "EventsViewController") as!EventsViewController
            destVC.userEmail = self.emailTextField.text
            self.navigationController?.setViewControllers([destVC], animated: true)
            }
        }
    }
    @IBAction func createButtonClicked(_ sender: UIButton) {
        let signUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
