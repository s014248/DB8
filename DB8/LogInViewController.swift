import UIKit
import Firebase
class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    /*@IBOutlet weak var LoginButton: UIButton!
    
    @IBAction func loginUN(_ sender: Any) {
    }
    
    @IBAction func loginP(_ sender: Any) {
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        
        emailAddressTextField.becomeFirstResponder()
        logInButton.isEnabled = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if emailAddressTextField.isFirstResponder{
            passwordTextField.becomeFirstResponder()
        }
            
        else {
            passwordTextField.resignFirstResponder()
            logInButton.isEnabled = true
        }
        
    
         
        
        return true
    }
    @IBAction func logInButtonTouchedUp(_ sender: Any) {
        print("sadasada")
        guard let email = emailAddressTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (user, error)             in
            if error == nil && user != nil{
                self.dismiss(animated: false, completion: nil)
                print("yayay")
            }
            else{
                print(error!.localizedDescription)
            }
        }
    }
    

}
