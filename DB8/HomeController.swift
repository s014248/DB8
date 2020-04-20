import UIKit

class HomeController: UIViewController{
    
    // MARK: - Properties
    
    var delegate: HomeControllerDelegate?
    var receivedString = "empty4"
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .none
        configNavigationBar()
    }
    
    // MARK: - Handlers
    
    @objc func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configNavigationBar(){
        navigationController?.navigationBar.barTintColor = .red //makes background dark gray
        navigationController?.navigationBar.barStyle = .black //makes text put in white
        
        let num = Int.random(in: 0..<2)
        if num == 0{
            navigationItem.title = "Stance: \(receivedString)"
        }
        else{
            navigationItem.title = "Stance: \(receivedString)"
        }
        navigationItem.prompt = "Butting Heads..."
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "stack").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))

    }
    
}
