import UIKit
import Firebase
import FirebaseFirestore

class CreateEventViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func createButtonClicked(_ sender: UIButton) {
        guard titleTextField.text!.count >= 2 && descriptionTextField.text!.count >= 2 else {
            Helping.showError(text: "Please, fill title label with 3 or plus symbols and try again later.", label: errorLabel, textFields: [titleTextField, descriptionTextField])
            return
        }
        let database = Firestore.firestore()
        let email = defaults.string(forKey: "email")
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        let date = timeFormatter.string(from: datePicker.date)
        
        database.collection("events").addDocument(data: [
            "title": titleTextField.text!,
            "description": descriptionTextField.text!,
            "date": date,
            "email": email!
        ]) { (error) in
            if error != nil {
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Error: database isn't working now. Please, try agalater"
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    @IBAction func reloadButtonClicked(_ sender: UIButton) {
    }
}
