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
    var imagePicker : UIImagePickerController?
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
        var firebasecontent = "ddd"
        if (joe==1){
            firebasecontent = "Negative"
        }
        else{
            firebasecontent = "Positive"
        }
        let data: [String: Any] = [
            "content": firebasecontent
        ]
        let fakedata: [String: Any] = [
            "content": "empty"
        ]
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
                
               // stance = "positive"
            }
        }
       /* Firestore.firestore().collection("test").document("positive").getDocument { (document, error) in
            if let document = document, document.exists {
                stance = "negative"
            }
        }
        if (stance=="bob"){
            var joe = Int.random(in: 1..<3)
            if (joe==1){
                Firestore.firestore().collection("test").document("negative").setData(data)
                stance = "positive"
            }
            if (joe==2){
                Firestore.firestore().collection("test").document("positive").setData(data)
                stance = "negative"
            }
        }
        else{
            
        }*/
            /*self.messagesCollectionView.scrollToBottom()
            
        })*/
        let seconds = 0.0001
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.performSegue(withIdentifier: "seguetime", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        let secondViewController = segue.destination as! MatchingViewController

        // set a variable in the second view controller with the String to pass
        secondViewController.receivedString = stance
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
