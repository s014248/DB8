import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var signUpUN: UITextField!
    @IBOutlet weak var signUpEA: UITextField!
    @IBOutlet weak var signUpP: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        signUpUN.delegate = self
        signUpEA.delegate = self
        signUpP.delegate = self
        signUpUN.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if signUpUN.isFirstResponder{
            signUpEA.becomeFirstResponder()
        }
            
        else if signUpEA.isFirstResponder{
            signUpP.becomeFirstResponder()
        }
        
        else {
            signUpP.resignFirstResponder()
            signUpButton.isEnabled = true
        }
        
    
         
        
        return true
    }
    @IBAction func signUpButtonTouched(_ sender: UIButton) {
        print("ajjsjs")
        guard let userName = signUpUN.text else{return}
        guard let email = signUpEA.text else{return}
        guard let password = signUpP.text else{return}
        
        Auth.auth().createUser(withEmail: email, password: password){ user, error in
            if let _ = user {
                print("user created")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = userName
                changeRequest?.commitChanges(completion: { (error) in
                    print("couldn't change name")
                })
            }
            else{
                print(error.debugDescription)
            }
        }

        
    }
    //DO SAME THING FOR LOGINVIEWCONTROLLER!!!
}
