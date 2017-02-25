//
//  ViewController.swift
//  PeriodicTimer
//
//  Created by Kina Winoto on 2/17/17.
//  Copyright © 2017 Kina Winoto. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    @IBOutlet weak var interval: NSPopUpButton!
    @IBOutlet weak var startTime: NSPopUpButton!
    @IBOutlet weak var status: NSTextField!
    
    
    var timer = Timer()
    
    var player: AVAudioPlayer?
    
    func playSound() {
        print("hit the interval")
        let url = Bundle.main.url(forResource: "Music_Box-Big_Daddy-1389738694", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func start(_ sender: Any) {
        
        // TODO: let use input any tiem they want.
        let dateFormatter = DateFormatter()
        let dateOnly = "MM-dd-yyyy"
        let timeOnly = "h:mm a"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        
        // Get only the current date
        var timeToStart : Date = Date.init() // default is current time
        dateFormatter.dateFormat = dateOnly
        let currentDate = dateFormatter.string(from: timeToStart)
        
        // Get the input current time, if now leave as default time of current time
        dateFormatter.dateFormat = "\(dateOnly) \(timeOnly)"
        if let timeTemp = startTime.titleOfSelectedItem {
            if timeTemp != "now" {
                timeToStart = dateFormatter.date(from: "\(currentDate) \(timeTemp)")!
            }
        }
        
        print ("start time: \(dateFormatter.string(from: timeToStart))")
        
        // Get the interval in minutes and then convert to seconds
        var intervalMin : Int = Int(10) // default
        if let intervaltemp = interval.titleOfSelectedItem {
            intervalMin = Int(intervaltemp)!
        }
        let intervalSec : Double = Double(intervalMin) * 60.0
        print("interval \(intervalSec)")
        
        // Initialize the timer for the desirted start time and interval in seconds
        timer = Timer.init(fireAt: timeToStart, interval: intervalSec, target: self, selector: #selector(playSound), userInfo: nil, repeats: true)
        
        // Add the timer to the current run loop under default mode
        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
        
        status.stringValue = "i'm running: \(intervalMin) min."
        
    }
    
    @IBAction func finish(_ sender: Any) {
        timer.invalidate()
        
        status.stringValue = "start me..."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

