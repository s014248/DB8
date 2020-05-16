//
//  ViewController.swift
//  SpinningWheel
//
//  Created by Boris Kohler (student LM) on 2/26/20.
//  Copyright © 2020 Boris Kohler (student LM). All rights reserved.
//

import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage

class RandomTopicViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var wheel: UIPickerView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var stanceLabel: UILabel!
    //babababa
    var topics = [String]()
    var ran = false
    var receivedString = "empty2"
    var receivedTopic = -987654
    override func viewDidLoad() {
        super.viewDidLoad()
        stanceLabel.text = "Your Stance: \(receivedString)"
        topics = ["Is water wet?", "Was it fair for harambe to be killed?", "Fractions or Decimals?", "Should school start times be later?", "Should Debate Teams be considered a sport?", "Should the SAT go away?", "Did Thanos have the right idea?", "Is it acceptable to put milk before cereal?", "Popeyes or Chick Fil A?", "Do laugh tracks make shows better?", "Pineapple on pizza?", "Cat or dogs?", "What's more attractive: money or personality?", "Star wars or star trek?", "Sunny side up or scrambled eggs?", "Burgers or Hot Dogs?", "Apple or Android?", "Beach or pools?", "Are Video Games good or bad for health?", "Is college worth it?", "Anime or cartoons?", "Pepperoni or plain pizza?", "Summer or Winter", "Marvel or DC?", "Monopoly or UNO?", "Biking or Skiing?"]
        
        resultLabel.text = ""
        resultLabel.adjustsFontSizeToFitWidth = true
        
        wheel.delegate = self
        wheel.dataSource = self
        
        
    }
    
    func randomNum() -> Int {
        return Int.random(in: 0..<topics.count)
    }
    
    
    @IBAction func spinPressed(_ sender: Any) {
        wheel.selectRow(receivedTopic, inComponent: 0, animated: true)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1,options: .curveEaseOut, animations: {}, completion: { finished in UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {}, completion: nil)})
        
        resultLabel.text = topics[wheel.selectedRow(inComponent: 0)]
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row]
    }
    
    
    @IBAction func goToMatchPressed(_ sender: Any) {
        ran = false
        var data: [String: Any] = [
            "content": "hssa",
            "id": "sjkas",
            "senderID": "asdf",
            "senderName": "oiyoiyoiy"
        ]
        delete(collection: Firestore.firestore().collection("Chats").document("joseph").collection("thread"), batchSize: 500)
        Firestore.firestore().collection("Chats").document("joseph").collection("thread").addDocument(data: data, completion: { (error) in
            
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            
        })
        var datab: [String: Any] = [
            "content": "hssaasd",
            "id": "sjkasdfas",
            "senderID": "asasdfdf",
            "senderName": "oiyoiasdfyoiy"
        ]
        Firestore.firestore().collection("Chats").document("joseph").collection("thread").addDocument(data: datab, completion: { (error) in
                   
                   if let error = error {
                       print("Error Sending message: \(error)")
                       return
                   }
                   
               })
        print("ahuhu")
        let seconds = 0.33
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.performSegue(withIdentifier: "seguetime3", sender: nil)
        }
    }
    func delete(collection: CollectionReference, batchSize: Int = 100) {
        print("bbbbbbbbbb")
        if (ran){
            return
        }
    // Limit query to avoid out-of-memory errors on large collections.
    // When deleting a collection guaranteed to fit in memory, batching can be avoided entirely.
        collection.limit(to: batchSize).getDocuments { (docset, error) in
      // An error occurred.
            let docset = docset

            let batch = collection.firestore.batch()
            docset?.documents.forEach { batch.deleteDocument($0.reference) }

            batch.commit {_ in
                self.ran = true
                self.delete(collection: collection, batchSize: batchSize)
            }
            print("jjaaj")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        let secondViewController = segue.destination as! ChatViewController

        // set a variable in the second view controller with the String to pass
        secondViewController.receivedString = receivedString
        secondViewController.receivedTopic = topics[receivedTopic]
    }
}

