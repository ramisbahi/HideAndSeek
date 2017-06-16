//
//  ViewController.swift
//  HideAndSeek
//
//  Created by Subhi Sbahi on 6/15/17.
//  Copyright © 2017 Rami Sbahi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    static var hideTime: Int = 0
    static var seekTime: Int = 0
    static var currentTime: Int = 0
    static var currentTime2: Int = 0
    static var myRunner = HideSeekRunner(players: [])
    var timer: Timer? = nil
    var timer2: Timer? = nil
    var player: AVAudioPlayer?
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TurnLabel: UILabel!
    
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var WhoFound: UILabel!
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    
    @IBOutlet weak var Switch1: UISwitch!
    @IBOutlet weak var Switch2: UISwitch!
    @IBOutlet weak var Switch3: UISwitch!
    @IBOutlet weak var Switch4: UISwitch!
    
    @IBOutlet weak var Player1: UILabel!
    @IBOutlet weak var Player2: UILabel!
    @IBOutlet weak var Player3: UILabel!
    @IBOutlet weak var Player4: UILabel!
    @IBOutlet weak var Player5: UILabel!
    @IBOutlet weak var Player6: UILabel!
    
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    @IBOutlet weak var Score3: UILabel!
    @IBOutlet weak var Score4: UILabel!
    @IBOutlet weak var Score5: UILabel!
    @IBOutlet weak var Score6: UILabel!
    
    @IBOutlet weak var EnterButton: UIButton!
    
    @IBAction func Start(_ sender: Any) {
        ViewController.currentTime = ViewController.hideTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
    }
    
    func update() {
        
        if(ViewController.currentTime > 0){
            ViewController.currentTime -= 1
            TimeLabel.text = String(ViewController.currentTime)
        }
        else
        {
            timer?.invalidate()
            timer = nil
            self.readySound()
            self.startOtherTimer()
        }
        
    }
    
    func readySound()
    {
        guard let url = Bundle.main.url(forResource: "TotalReady", withExtension: "mp3") else {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func startOtherTimer()
    {
        ViewController.currentTime2 = ViewController.seekTime
        TimeLabel.text = String(ViewController.currentTime2)
        timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("update2"), userInfo: nil, repeats: true)
    }
    
    func update2()
    {
        if(ViewController.currentTime2 > 0){
            ViewController.currentTime2 -= 1
            TimeLabel.text = String(ViewController.currentTime2)
        }
        else
        {
            timer2?.invalidate()
            timer2 = nil
            self.alarmSound()
            self.displayFound()
        }
    }
    
    func alarmSound()
    {
        guard let url = Bundle.main.url(forResource: "Buzz", withExtension: "mp3") else {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func displayFound()
    {
        let others = ViewController.myRunner.otherPlayers()
        let labels = [Label1, Label2, Label3, Label4]
        let switches = [Switch1, Switch2, Switch3, Switch4]
        
        for i in 0..<others.count
        {
            switches[i]?.isHidden = false
            labels[i]?.isHidden = false
            labels[i]?.text = others[i].name
        }
        
        StartButton.isEnabled = false
        WhoFound.isHidden = false
        EnterButton.isHidden = false
    }
    
    @IBAction func Enter(_ sender: Any) {
        let switches = [Switch1, Switch2, Switch3, Switch4]
        var foundIndices: [Int] = []
        for i in 0..<switches.count
        {
            if(switches[i]?.isOn)!
            {
                if(i < ViewController.myRunner.currentPlayerIndex)
                {
                    foundIndices.append(i)
                }
                else
                {
                    foundIndices.append(i+1)
                }
            }
        }
        ViewController.myRunner.found(indices: foundIndices)
        
        StartButton.isEnabled = true
        WhoFound.isHidden = true
        let labels = [Label1, Label2, Label3, Label4]
        for label in labels
        {
            label?.isHidden = true
        }
        for mySwitch in switches
        {
            mySwitch?.isHidden = true
        }
        EnterButton.isHidden = true
        ViewController.myRunner.nextPlayer()
        self.updateLabels()
    }
    
    func updateLabels()
    {
        if(ViewController.myRunner.myPlayers.isEmpty)
        {
            TurnLabel.text = "Add players in settings"
        }
        else
        {
            TurnLabel.text = "\(ViewController.myRunner.currentPlayer.name)'s Turn"
        }
        TimeLabel.text = String(ViewController.hideTime)
        let players = [Player1, Player2, Player3, Player4, Player5, Player6]
        let scores = [Score1, Score2, Score3, Score4, Score5, Score6]
        
        for i in 0..<ViewController.myRunner.myPlayers.count
        {
            players[i]?.isHidden = false
            scores[i]?.isHidden = false
            players[i]?.text = ViewController.myRunner.myPlayers[i].name
            scores[i]?.text = String(ViewController.myRunner.myPlayers[i].points)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        self.updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

