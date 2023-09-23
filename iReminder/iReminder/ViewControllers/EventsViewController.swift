//
//  ViewController.swift
//  iReminder
//
//  Created by Alex Balla on 21.09.2023.
//

import UIKit

class EventsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var table: UICollectionView!
    var userEmail: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        title = "Events"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", image: UIImage(systemName: "plus.circle.fill"), target: self, action: #selector(addEventPressed))
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200)
        
    }
}

