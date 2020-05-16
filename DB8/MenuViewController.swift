//
//  ProfileViewController.swift
//  FirebaseAuthentication
//
//  Created by Alexander Zhang (student LM) on 2/10/20.
//  Copyright © 2020 Alexander Zhang (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import SwiftUI
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage
import Foundation

class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var stance = "bob"
    var topic = -9876
    var imagePicker : UIImagePickerController?
    var topicslist = ["Is water wet?", "Was it fair for harambe to be killed?", "Fractions or Decimals?", "Should school start times be later?", "Should Debate Teams be considered a sport?", "Should the SAT go away?", "Did Thanos have the right idea?", "Is it acceptable to put milk before cereal?", "Popeyes or Chick Fil A?", "Do laugh tracks make shows better?", "Pineapple on pizza?", "Cat or dogs?", "What's more attractive: money or personality?", "Star wars or star trek?", "Sunny side up or scrambled eggs?", "Burgers or Hot Dogs?", "Apple or Android?", "Beach or pools?", "Are Video Games good or bad for health?", "Is college worth it?", "Anime or cartoons?", "Pepperoni or plain pizza?", "Summer or Winter", "Marvel or DC?", "Monopoly or UNO?", "Biking or Skiing?"]
   /* @IBOutlet weak var imageView: UIImageView!*/
    //let contentView = ChatContentView()
  //  var chatController = OldChatViewController()
    
    /*@IBSegueAction func goToChat(_ coder: NSCoder) -> UIViewController? {
       // return UIHostingController(coder: coder, rootView: contentView.environmentObject(chatController))
        
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        /*imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        imagePicker = UIImagePickerController()
        imagePicker?.allowsEditing = true
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.delegate = self*/
    }
    

    @IBAction func EnterMatchTouchedUp(_ sender: Any) {
        print("QWERPQWYETWIQUEPTWYEQUTUEIWQTY")
        var joe = Int.random(in: 1..<3)
        var joejoe = Int.random(in: 0..<topicslist.count)
        var firebasecontent = "ddd"
        var newtopic = -1234
        if (joe==1){
            firebasecontent = "Negative"
        }
        else{
            firebasecontent = "Positive"
        }
        newtopic = joejoe
        let data: [String: Any] = [
            "content": firebasecontent
        ]
        let fakedata: [String: Any] = [
            "content": "empty"
        ]
        let noobdata : [String: Any] = [
            "topicaloo": newtopic
        ]
        let noobfakedata : [String: Any] = [
            "topicaloo": -9876
        ]
        
        Firestore.firestore().collection("test").document("joseph").getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()/*.map(String.init(describing:)) ?? "nil"*/
                if let givenstance = dataDescription?["topicaloo"] as? Int{
                    if (givenstance == -9876){
                        self.topic = newtopic
                        Firestore.firestore().collection("test").document("joseph").setData(noobdata)
                    }
                    else{
                        self.topic = givenstance
                        Firestore.firestore().collection("test").document("joseph").setData(noobfakedata)
                    }
                }
            }
        }
        Firestore.firestore().collection("test").document("a").getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()/*.map(String.init(describing:)) ?? "nil"*/
                if let givenstance = dataDescription?["content"] as? String{
                    if (givenstance=="Positive"){
                        self.stance = "Positive"
                        Firestore.firestore().collection("test").document("a").setData(fakedata)
                    }
                    else if (givenstance=="Negative"){
                        self.stance = "Negative"
                        Firestore.firestore().collection("test").document("a").setData(fakedata)
                    }
                    else{
                        if (firebasecontent == "Negative"){
                            self.stance = "Positive"
                            Firestore.firestore().collection("test").document("a").setData(data)
                        }
                        else{
                            self.stance = "Negative"
                            Firestore.firestore().collection("test").document("a").setData(data)
                        }
                    }
                }
            }
        }
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.performSegue(withIdentifier: "seguetime", sender: nil)
        }
    }//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        let secondViewController = segue.destination as! MatchingViewController

        // set a variable in the second view controller with the String to pass
        secondViewController.receivedString = stance
        secondViewController.receivedTopic = topic
    }
    /*@IBAction func changeImageTouchedUp(_ sender: UIButton) {
        self.present(imagePicker!, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    func uploadProfilePicture(_ image: UIImage, _ completion: @escaping((_ url:URL?) -> ())){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let storage = Storage.storage().reference().child("user/\(uid)")
        guard let image = imageView?.image, let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        storage.putData(imageData, metadata: StorageMetadata()){
            (metaData, error) in
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = pickedImage
            uploadProfilePicture(pickedImage) {url in}
        }
        imagePicker?.dismiss(animated: true, completion: nil)
    }*/
    
    
     // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */
    
}
