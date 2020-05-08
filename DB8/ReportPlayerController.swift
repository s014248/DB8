import Foundation
import UIKit

class ReportPlayerController: UIViewController{
    
       // MARK: - Properties
       
       var label = UILabel()
       
       // MARK: - Init
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        //question label
        
        let question = UILabel.init()
        question.frame = CGRect(x: 37.0, y: 250.0, width: 333.0, height: 52.0)
        question.text = "Are you sure you want to report this player?"
        /*question.layer.borderWidth = 1.0
        question.layer.borderColor = UIColor.darkGray.cgColor*/
        self.view.addSubview(question)
        
        //button
        
        let button = UIButton.init(type: .system)
        button.frame = CGRect(x: 150.0, y: 450.0, width: 120.0, height: 52.0)
        button.setTitle("Report Player", for: .normal)
        button.layer.borderWidth = 5.0
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.backgroundColor = UIColor.red.cgColor
        /*button.titleLabel?.textColor = UIColor.white*/
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 15.0
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
        //player reported label
        
        label.frame = CGRect(x: 50.0, y: 650.0, width: 321.0, height: 60.0)
        label.text = "Player Reported"
        
        label.textAlignment = .center
        /*label.textColor = UIColor.black*/
        label.backgroundColor = UIColor.red
        label.font = UIFont(name: "Copperplate-Bold", size: 30)
        
        self.view.addSubview(label)
        
        label.isHidden = true
        
       }
      
       
       // MARK: - Selectors
       
    @objc func buttonClicked(){
        print("Player Reported")
        label.isHidden = false
    }
    
    
       @objc func handleDismiss(){
           dismiss(animated: true, completion: nil)
       }
       
       // MARK: - Helper Functions
       
       func configureUI(){
           view.backgroundColor = .white
           
           navigationController?.navigationBar.barTintColor = .red
           navigationItem.title = "Report Player"
           navigationController?.navigationBar.barStyle = .black
           
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "stack").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
           
       }
       
}
