//
//  NearByListViewController.swift
//  Stardust
//
//  Created by shikata hiroshi on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import UIKit
import FirebaseStorage

class NearByListViewController: UITableViewController {

    var nearPersons:[Person] = []
    var myTopics:[Topic] = []
    var iconImages:[String:UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NearByListCell.nib, forCellReuseIdentifier: NearByListCell.cellIdentifier)
        tableView.tableFooterView = UIView()
        
        dummyData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearPersons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = nearPersons[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NearByListCell.cellIdentifier) as! NearByListCell
        
        cell.personNameLabel.text = person.name
        cell.twitterAccountNameLabel.text = person.twitterId
        
        for topic in person.interests {
            
            let topicLabel = UILabel()
            topicLabel.text = "RxSwift"
            cell.topicLabelStacView.addArrangedSubview(topicLabel)
        }
        
        cell.personIconImageView.image = UIImage.init(named: "dummyPerson")
        
        if let image = iconImages[person.twitterId] {
            cell.personIconImageView.image = image
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let person = nearPersons[indexPath.row]
        
        if iconImages[person.twitterId] != nil {
            return
        }
        
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://stardustswift-1c8c5.appspot.com")
        let riversRef = storageRef.child("images/3538619.png")
        riversRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
            if let imageData = data {
                let image = UIImage.init(data: imageData)
                self.iconImages[person.twitterId] = image
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    func dummyData() {
        
        nearPersons = [
            Person.init(twitterId: "TwitterTest1",name: "Test ABCD",imagePath: "",interests: []),
            Person.init(twitterId: "TwitterTest2",name: "Test ABCD",imagePath: "",interests: []),
            Person.init(twitterId: "TwitterTest3",name: "Test ABCD",imagePath: "",interests: []),
            Person.init(twitterId: "TwitterTest4",name: "Test ABCD",imagePath: "",interests: []),
            Person.init(twitterId: "TwitterTest5",name: "Test ABCD",imagePath: "",interests: []),
            Person.init(twitterId: "TwitterTest6",name: "Test ABCD",imagePath: "",interests: []),
        ]
    }
    
    
}
