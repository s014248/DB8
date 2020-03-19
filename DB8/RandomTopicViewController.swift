//
//  ViewController.swift
//  SpinningWheel
//
//  Created by Boris Kohler (student LM) on 2/26/20.
//  Copyright © 2020 Boris Kohler (student LM). All rights reserved.
//

import UIKit

class RandomTopicViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var wheel: UIPickerView!
    @IBOutlet weak var spinButton: UIButton!
    
    //babababa
    var topics = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topics = ["Is water wet?", "Was it fair for harambe to be killed?", "Fractions or Decimals?", "Should school start times be later?", "Should Debate Teams be considered a sport?", "Should the SAT go away?", "Did Thanos have the right idea?", "Is it acceptable to put milk before cereal?", "Popeyes or Chick Fil A?", "Do laugh tracks make shows better?", "Pineapple on pizza?", "Cat or dogs?", "What's more attractive: money or personality?", "Star wars or star trek?"]
        
        resultLabel.text = ""
        resultLabel.adjustsFontSizeToFitWidth = true
        
        wheel.delegate = self
        wheel.dataSource = self
        
        
    }
    
    func randomNum() -> Int {
        return Int.random(in: 0..<topics.count)
    }
    
    
    @IBAction func spinPressed(_ sender: Any) {
        wheel.selectRow(randomNum(), inComponent: 0, animated: true)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1,options: .curveEaseOut, animations: {}, completion: { finished in UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {}, completion: nil)})
        
        resultLabel.text = topics[wheel.selectedRow(inComponent: 0)]
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row]
    }
    


}

