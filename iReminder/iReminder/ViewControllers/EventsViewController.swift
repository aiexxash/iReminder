//
//  ViewController.swift
//  iReminder
//
//  Created by Alex Balla on 21.09.2023.
//

import UIKit

class EventsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet var dateButtons: [UIButton]!
    @IBOutlet weak var table: UICollectionView!
    var userEmail: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @objc func addEventPressed(){
        let createEventVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController
        self.navigationController?.pushViewController(createEventVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = false
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 130)
    }
}

