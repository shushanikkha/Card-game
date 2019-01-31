//
//  ViewController.swift
//  Finaly Card Game
//
//  Created by Shushan Khachatryan on 10/11/18.
//  Copyright © 2018 Shushan Khachatryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var buttonsArray: [UIButton]!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblSteps: UILabel!
    var cardArray = [#imageLiteral(resourceName: "card6"), #imageLiteral(resourceName: "card24"), #imageLiteral(resourceName: "card21"), #imageLiteral(resourceName: "card35"), #imageLiteral(resourceName: "card6"), #imageLiteral(resourceName: "card24"), #imageLiteral(resourceName: "card21"), #imageLiteral(resourceName: "card35")]
    var points = 0
    var steps = 0
    var firstButton: UIButton!
    var secondButton: UIButton!
    var selectedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardArray.shuffle()
    }
    

    // MARKS: - Actions -

    @IBAction func cardButtons(_ sender: UIButton) {
        guard sender.image(for: .normal) == nil else { return }
        self.steps += 1
        self.lblSteps.text = ("Steps:  \(steps.description)")
        sender.setImage(self.cardArray[sender.tag - 1], for: .normal)
        sender.setBackgroundImage(nil, for: .normal)
        UIView.animate(withDuration: 0.5, animations: {sender.backgroundColor = .black})
        {(succes) in
            if self.firstButton == nil {
                self.firstButton = sender
            } else {
                self.secondButton = sender
                self.updateUI()
            }
        }
     }
    
    
    // MARK: - Methods -
    
    func updateUI(){
        guard self.firstButton.image(for: .normal) == self.secondButton.image(for: .normal) else {
            UIView.animate(withDuration: 0.5, animations: {
                self.firstButton.backgroundColor = .red
                self.secondButton.backgroundColor = .red}) {
                    (success) in
                    self.firstButton.setImage(nil, for: .normal)
                    self.secondButton.setImage(nil, for: .normal)
                    self.firstButton.setBackgroundImage(#imageLiteral(resourceName: "back"), for: .normal)
                    self.secondButton.setBackgroundImage(#imageLiteral(resourceName: "back"), for: .normal)
                    self.firstButton.backgroundColor = .clear
                    self.secondButton.backgroundColor = .clear
                    self.firstButton = nil
                    self.secondButton = nil
            }
            return
        }
        self.points += 1
        self.lblPoints.text = ("Points: \(self.points.description)")
        self.firstButton = nil
        self.secondButton = nil
        if self.points == 4 {
            let alert = UIAlertController(title: "Game over!", message: "You are win after \(self.steps.description) steps!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
