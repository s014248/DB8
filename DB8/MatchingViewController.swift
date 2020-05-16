//
//  MatchingViewController.swift
//  DB8
//
//  Created by Boris Kohler (student LM) on 4/2/20.
//  Copyright © 2020 Alexander Zhang (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import SwiftUI
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage
import Foundation

class MatchingViewController: UIViewController {

    
    
    let circle = UIView()
    @IBOutlet weak var label: UILabel!
    var displayLink: CADisplayLink!
    var seguetimeornot = false
    @IBOutlet weak var timeLabel: UILabel!
    var count = 10
    @IBOutlet weak var enterMatchButton: UIButton!
    @IBOutlet weak var stanceLabel: UILabel!
    var receivedString = "empty1"
    var receivedTopic = -98765
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        stanceLabel.text = "Your Stance: \(receivedString)"
        timeLabel.text = ""
        print(receivedString)
        enterMatchButton.isEnabled = false
        backButton.isEnabled = true
        setUpCircle()
        displayLink = CADisplayLink(target: self, selector: #selector(handleAnimations))
        displayLink.add(to: RunLoop.main, forMode: .default)
        
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    @IBAction func EnterMatchTouchedUp(_ sender: Any) {
        seguetimeornot = true
        let seconds = 0.33
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.performSegue(withIdentifier: "seguetime2", sender: nil)
        }
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
        Firestore.firestore().collection("test").document("a").getDocument { (document, error) in
        if let document = document, document.exists {
            /*while (document.data()?["content"] as? String=="Positive"||document.data()?["content"] as? String=="Negative"){
                if (document.data()?["content"] as? String=="Positive"||document.data()?["content"] as? String=="Negative"){
                    var sugma = 1
                }
                else{
                    break
                }
            }*/
            if(self.count > 1) {
                self.count -= 1
                if(self.count <= 5) {
                    self.timeLabel.text = "\(self.count)"
            }
        }
            else if(self.count == 1){
                self.enterMatchButton.isEnabled = true
        }
            }}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(seguetimeornot){
           // get a reference to the second view controller
           let secondViewController = segue.destination as! RandomTopicViewController
            
           // set a variable in the second view controller with the String to pass
           secondViewController.receivedString = receivedString
           secondViewController.receivedTopic = receivedTopic
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

    @IBAction func backbuttonpressed(_ sender: Any) {
        seguetimeornot = false
        self.performSegue(withIdentifier: "bobjoe", sender: nil)
    }
}

