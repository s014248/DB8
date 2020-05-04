import Foundation
import UIKit

/*private let reuseIdentifier = "HomeMenu"*/

class LeaveController: UIViewController{
    
    // MARK: - Properties
    
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        let label = UILabel.init()
        label.frame = CGRect(x: 45.0, y: 250.0, width: 313.0, height: 52.0)
        label.text = "Are you sure you want to exit the match?"
        /*label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.darkGray.cgColor*/
        self.view.addSubview(label)
        
        let button = UIButton.init(type: .system)
        button.frame = CGRect(x: 150.0, y: 450.0, width: 100.0, height: 52.0)
        button.setTitle("Leave", for: .normal)
        button.layer.borderWidth = 5.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.backgroundColor = UIColor.darkGray.cgColor
        /*button.titleLabel?.textColor = UIColor.white*/
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 15.0
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
  /*func setUpButton(){
        was gonna do button constraints
    }*/
    
    @objc func buttonClicked(){
        print("left match")
        /*let homeMenu = HomeMenu()*/
        /*let a = (navigationController?.popViewController(animated: true))*/
        /*_ = navigationController?.popViewController(animated: true)*/
        /*present(homeMenu, animated: true, completion: nil)*/
        //going back to HomeMenu
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let homeView  = sampleStoryBoard.instantiateViewController(withIdentifier: "HomeMenu") as! MenuViewController
        self.present(homeView, animated: true, completion: nil)
        
        
    }
    
    
    // MARK: - Selectors
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    
    func configureUI(){
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationItem.title = "Exit Match?"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "stack").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
    
}
