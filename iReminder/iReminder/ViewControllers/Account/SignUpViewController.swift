import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var logInAccountButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemCyan
    }
    @IBAction func createButtonClicked(_ sender: UIButton) {
        let error = Helping.checkTextFields(errorLabel: errorLabel, nicknameField: emailTextField, passwordField: passwordTextField, confirmationField: confirmPasswordTextField)

        guard error == nil else {
            Helping.showError(text: error!, label: errorLabel, textFields: [emailTextField, passwordTextField, confirmPasswordTextField])
            return
        }
                
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if err != nil {
                Helping.showError(text: "Error creating user", label: self.errorLabel, textFields: [])
            }
            
            else {
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["email": email, "uid": result!.user.uid ]) { (error) in
                    if error != nil {
                        Helping.showError(text: "Error saving user data", label: self.errorLabel, textFields: [])
                    }
                }
                let ac = UIAlertController(title: "Success", message: "Your account was successfuly created and now you are free to use it.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default){_ in
                    let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                    destVC.userEmail = email
                    self.navigationController?.setViewControllers([destVC], animated: true)
                })
                self.present(ac, animated: true)
            }
        }
    }
    @IBAction func logInAccountButtonClicked(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
