//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Rachel Paturi on 11/29/15.
//  Copyright © 2015 Rachel Paturi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioPlayerNode:AVAudioPlayerNode!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stopAllAudio(){
        audioPlayer.stop()
        audioEngine.stop()
    }
    
    func setAudioSpeed(rate: Float) {
        stopAllAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        //Play audio slowly
        setAudioSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        //Play audio fast
        setAudioSpeed(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func audioPlayerNodeStart() {
        audioPlayerNode = AVAudioPlayerNode()
        stopAllAudio()
        audioEngine.reset()
        
        audioEngine.attachNode(audioPlayerNode)
    }
    
    func audioPlayerNodePlay() {
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayerNodeStart()
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNodePlay()
        
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    @IBAction func playReverbAudio(sender: UIButton) {

        audioPlayerNodeStart()

        let audioReverb = AVAudioUnitReverb()
        audioReverb.loadFactoryPreset(.LargeHall)
        audioReverb.wetDryMix = 50.0

        audioEngine.attachNode(audioReverb)
        audioEngine.connect(audioPlayerNode, to: audioReverb, format: nil)
        audioEngine.connect(audioReverb, to: audioEngine.outputNode, format: nil)
        
        
        audioPlayerNodePlay()
    }
    
    
    @IBAction func stopAllAudio(sender: AnyObject) {
        stopAllAudio()
    }

}
