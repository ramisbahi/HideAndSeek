//
//  SettingsViewController.swift
//  HideAndSeek
//
//  Created by Subhi Sbahi on 6/15/17.
//  Copyright © 2017 Rami Sbahi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    static var count = 0
    @IBOutlet weak var TimeField: UITextField!
    @IBOutlet weak var SeekTimeField: UITextField!
    
    @IBOutlet weak var Name1: UITextField!
    @IBOutlet weak var Name2: UITextField!
    @IBOutlet weak var Name3: UITextField!
    @IBOutlet weak var Name4: UITextField!
    @IBOutlet weak var Name5: UITextField!
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    
    @IBOutlet weak var Player1: UILabel!
    @IBOutlet weak var Player2: UILabel!
    @IBOutlet weak var Player3: UILabel!
    @IBOutlet weak var Player4: UILabel!
    @IBOutlet weak var Player5: UILabel!
    
    static var numOpen = 1
    
    @IBAction func Button1(_ sender: Any) {
        self.deletePlayer(1)
    }
    @IBAction func Button2(_ sender: Any) {
        if(SettingsViewController.numOpen < 2)
        {
            self.addPlayer()
        }
        else
        {
            self.deletePlayer(2)
        }
    }
    @IBAction func Button3(_ sender: Any) {
        if(SettingsViewController.numOpen < 3)
        {
            self.addPlayer()
        }
        else
        {
            self.deletePlayer(3)
        }
    }
    @IBAction func Button4(_ sender: Any) {
        if(SettingsViewController.numOpen < 4)
        {
            self.addPlayer()
        }
        else
        {
            self.deletePlayer(4)
        }
    }
    
    @IBAction func Button5(_ sender: Any) {
        if(SettingsViewController.numOpen < 5)
        {
            self.addPlayer()
        }
        else
        {
            self.deletePlayer(5)
        }
    }
    
    func deletePlayer(_ i: Int)
    {
        let buttons = [Button1, Button2, Button3, Button4, Button5]
        let playerLabels = [Player1, Player2, Player3, Player4, Player5]
        let textFields = [Name1, Name2, Name3, Name4, Name5]
        
        for index in i-1..<SettingsViewController.numOpen-1
        {
            textFields[index]?.text = textFields[index+1]?.text
        }
        
        if(SettingsViewController.numOpen <= 7)
        {
            buttons[SettingsViewController.numOpen]?.isHidden = true
        }
        buttons[SettingsViewController.numOpen - 1]?.setImage(UIImage(named: "plus"), for: .normal)
        playerLabels[SettingsViewController.numOpen - 1]?.isHidden = true
        textFields[SettingsViewController.numOpen - 1]?.isHidden = true
        
        SettingsViewController.numOpen -= 1
        
        if(SettingsViewController.numOpen == 1)
        {
            Button1.isHidden = true
        }
        
        
    }
    
    func addPlayer()
    {
        let buttons = [Button1, Button2, Button3, Button4, Button5]
        let playerLabels = [Player1, Player2, Player3, Player4, Player5]
        let textFields = [Name1, Name2, Name3, Name4, Name5]
        
        buttons[SettingsViewController.numOpen]?.setImage(UIImage(named: "minus"), for: .normal)
        if(SettingsViewController.numOpen <= 4)
        {
            buttons[SettingsViewController.numOpen + 1]?.setImage(UIImage(named: "plus"), for: .normal)
            buttons[SettingsViewController.numOpen + 1]?.isHidden = false
        }
        playerLabels[SettingsViewController.numOpen]?.isHidden = false
        textFields[SettingsViewController.numOpen]?.isHidden = false
        Button1.isHidden = false
        
        SettingsViewController.numOpen += 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        TimeField?.delegate = self
        SeekTimeField?.delegate = self
        
        let textFields = [Name1, Name2, Name3, Name4, Name5]
        for textField in textFields
        {
            textField?.delegate = self
        }
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        if(SettingsViewController.count > 0)
        {
            let names = [Name1, Name2, Name3, Name4, Name5]
            for name in names
            {
                name?.isEnabled = false
            }
            
            let buttons = [Button1, Button2, Button3, Button4, Button5]
            for button in buttons
            {
                button?.isHidden = true
            }
            Player1?.text = "Cannot change players"
            Name1?.isHidden = true
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        ViewController.hideTime = Int(TimeField.text!)!
        ViewController.seekTime = Int(SeekTimeField.text!)!
        
        if(SettingsViewController.count == 0)
        {
            var players: [Player] = []
            let textFields = [Name1, Name2, Name3, Name4, Name5]
            for i in 0..<SettingsViewController.numOpen
            {
                let currentPlayer = Player(name: (textFields[i]?.text)!)
                players.append(currentPlayer)
            }
            ViewController.myRunner = HideSeekRunner(players: players)
        }
        
        SettingsViewController.count += 1
    }
    

}
