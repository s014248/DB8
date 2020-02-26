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
class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker : UIImagePickerController?
   /* @IBOutlet weak var imageView: UIImageView!*/
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
