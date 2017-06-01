//
//  PitchViewController.swift
//  recorder4.0
//
//  Created by Ricky Humbert on 5/31/17.
//  Copyright © 2017 Ricky Humbert. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var chipmunk: UIButton!
    @IBOutlet weak var rabbit: UIButton!
    @IBOutlet weak var darthVader: UIButton!
    @IBOutlet weak var snail: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile:AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        audioEngine = AVAudioEngine()
        try! audioFile = AVAudioFile(forReading: recordedAudioURL as URL)
    }
    
    func playSound(value: Float, rateOrPitch: String){
        
        audioPlayerNode.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioEngine.attach(audioPlayerNode)
        
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        
        if (rateOrPitch == "rate") {
            changeAudioUnitTime.rate = value
        } else {
            changeAudioUnitTime.pitch = value
        }
        
        audioEngine.attach(changeAudioUnitTime)
        audioEngine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        audioEngine.connect(changeAudioUnitTime, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func playChipmunk(_ sender: Any) {
    
        playSound(value: 1000, rateOrPitch: "pitch")
    }
    
    
   
    @IBAction func playDarthVader(_ sender: Any) {
    
        playSound(value: -1000, rateOrPitch: "pitch")
    }
    
    
    @IBAction func playSnail(_ sender: Any) {
    
    
        playSound(value: 0.5, rateOrPitch: "rate")
    }
    
    
    @IBAction func playRabbit(_ sender: Any) {
    
    
        playSound(value: 1.5, rateOrPitch: "rate")
    }
    

}
