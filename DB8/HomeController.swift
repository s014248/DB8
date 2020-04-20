//
//  HomeController.swift
//  DebateMenu
//
//  Created by Justin Robertson (student LM) on 1/20/20.
//  Copyright © 2020 Justin Robertson. All rights reserved.
//
import UIKit

class HomeController: UIViewController{
    
    // MARK: - Properties
    
    var delegate: HomeControllerDelegate?
    
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
            navigationItem.title = "Stance: Positive"
        }
        else{
            navigationItem.title = "Stance: Negative"
        }
        navigationItem.prompt = "Butting Heads..."
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "stack").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))

    }
    
}
