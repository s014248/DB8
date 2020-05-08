import Foundation
import UIKit

class TopicController: UIViewController{
    
       // MARK: - Properties
       
       
       
       // MARK: - Init
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
           
        let label = UILabel.init()
        label.frame = CGRect(x: 50.0, y: 300.0, width: UIScreen.main.bounds.size.width-100, height: 300.0)
        label.text = "What's more attractive: money or personality?"
        label.numberOfLines = 0
        label.textAlignment = .center
        /*label.textColor = UIColor.black*/
        label.backgroundColor = UIColor.red
        label.font = UIFont(name: "Copperplate-Bold", size: 30)
        /*label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.darkGray.cgColor*/
        self.view.addSubview(label)
           
       }
       
       
       // MARK: - Selectors
       
       @objc func handleDismiss(){
           dismiss(animated: true, completion: nil)
       }
       
       // MARK: - Helper Functions
       
       func configureUI(){
           view.backgroundColor = .white
           
           navigationController?.navigationBar.barTintColor = .red
           navigationItem.title = "Question"
           navigationController?.navigationBar.barStyle = .black
           
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "stack").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
           
       }
       
}
