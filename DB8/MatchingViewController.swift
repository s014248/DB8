//
//  MatchingViewController.swift
//  DB8
//
//  Created by Boris Kohler (student LM) on 4/2/20.
//  Copyright © 2020 Alexander Zhang (student LM). All rights reserved.
//

import UIKit

class MatchingViewController: UIViewController {

    let circle = UIView()
    @IBOutlet weak var label: UILabel!
    var displayLink: CADisplayLink!
    @IBOutlet weak var timeLabel: UILabel!
    var count = 10
    @IBOutlet weak var enterMatchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = ""
        
        enterMatchButton.isEnabled = false

        setUpCircle()
        displayLink = CADisplayLink(target: self, selector: #selector(handleAnimations))
        displayLink.add(to: RunLoop.main, forMode: .default)
        
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        
         
    }
    
    var value: CGFloat = 0.0
    var invert: Bool = false
    @objc func handleAnimations() {
        invert ? (value -= 1.25) : (value += 1.25)
        circle.backgroundColor = UIColor.red.withAlphaComponent(value/100)
        label.textColor = UIColor.red
        if value > 100 || value < 0 {
            invert = !invert
        }
    }
    
    func setUpCircle() {
        view.addSubview(circle)
        circle.layer.cornerRadius = 50
        circle.backgroundColor = .red
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    
    @objc func update() {
        if(count > 1) {
            count -= 1
            if(count <= 5) {
                timeLabel.text = "\(count)"
            }
        }
        else if(count == 1){
            enterMatchButton.isEnabled = true
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
