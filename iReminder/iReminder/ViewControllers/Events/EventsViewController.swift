import UIKit
import Firebase

class EventsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet var dateButtons: [UIButton]!
    @IBOutlet weak var table: UICollectionView!
    var requests: [Request] = []
    let defaults = UserDefaults.standard
    
    // ----------------------------- VIEW DID LOAD --------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        table.delegate = self
        table.dataSource = self
        
        
        
        title = "Events"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", image: UIImage(systemName: "plus.circle.fill"), target: self, action: #selector(addEventPressed))
        
        var config  = UIButton.Configuration.gray()
        
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
            // 1
            var outgoing = incoming
            // 2
              outgoing.font = UIFont.systemFont(ofSize: 10)
            // 3
            return outgoing
          }
        for dateButton in dateButtons {
            dateButton.configuration = config
        }
    }
    
    // ----------------------------- FUNCTIONS -----------------------------
    
    @objc func addEventPressed(){
        let createEventVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController
        self.navigationController?.pushViewController(createEventVC, animated: true)
    }
    
    func getData(){
        let email = defaults.string(forKey: "email")
        let database = Firestore.firestore()
        database.collection("events").whereField("email", isEqualTo: email!).getDocuments() { (snapshot, error) in
                if error != nil {
                    print(String(describing: error))
                } else {
                    if let snapshot = snapshot {
                        DispatchQueue.main.async {
                            self.requests = snapshot.documents.map { d in
                                return Request(id: d.documentID, email: d["email"] as? String ?? "error@test.com", title: d["title"] as? String ?? "title", description: d["description"] as? String ?? "description", due: d["due"] as? String ?? "due")
                            }
                            self.table.reloadData()
                        }
                    }
                }
            }
        }
    
    // ----------------------------- COLLECTION VIEW -----------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requests.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // ----------- VARIABLES -----------
        let database = Firestore.firestore()
        let request = requests[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EventsCollectionViewCell
        
        // ----------- CELL STYLING -----------
        
        cell?.layer.cornerRadius = 5.0
        cell?.layer.masksToBounds = false
        cell?.layer.shadowRadius = 8.0
        cell?.layer.shadowColor = UIColor.black.cgColor
        cell?.layer.shadowOpacity = 0.25
        cell?.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // ----------- CELL LABELS -----------
        let email = defaults.string(forKey: "email")
        database.collection("cars").whereField("email", isEqualTo: email!).getDocuments() { (querySnapshot, err) in
                if err != nil {
                    let ac = UIAlertController(title: "Error", message: "Can't load cars data.", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                } else {
                    cell?.titleLabel.text = request.title
                    cell?.descriptionLabel.text = request.description
                    cell?.dueLabel.text = request.due
            }
        }
        
        return cell!
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 130)
    }
}

