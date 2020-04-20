//
//  LeaveController.swift
//  DB8
//
//  Created by Justin Robertson (student LM) on 4/19/20.
//  Copyright © 2020 Alexander Zhang (student LM). All rights reserved.
//

import Foundation

import UIKit

class LeaveController: UIViewController{
    
    // MARK: - Properties
    
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    
    func configureUI(){
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationItem.title = "Leave?"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "stack").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
    
}
