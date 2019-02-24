//
//  ViewController.swift
//  SoundShaker
//
//  Created by IMCS2 on 2/23/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {
    var songNumberTobePlayed : Int = 0
    var player = AVAudioPlayer()
    let audioResource = ["1","2","3","4","5","6","7","8","9","10"]
    @IBOutlet weak var songLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func motionEnded(_ _motion: UIEvent.EventSubtype, with event : UIEvent?){
        if event?.subtype == UIEvent.EventSubtype.motionShake{
            print("Device was shaken")
            songNumberTobePlayed = Int.random(in: 0 ..< audioResource.count)
            audioPlayer(songNumber: songNumberTobePlayed)
        }
        
    }
    
    @objc func swipped(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            if swipeGesture.direction == UISwipeGestureRecognizer.Direction.right {
                print("Swiped to right");
                if(songNumberTobePlayed > 0){
                    songNumberTobePlayed-=1
                }
                
            }
            else if swipeGesture.direction == UISwipeGestureRecognizer.Direction.left {
                print("Swiped to left")
                if(songNumberTobePlayed < audioResource.count-1){
                    songNumberTobePlayed+=1
                }
                else if songNumberTobePlayed == audioResource.count-1{
                    songNumberTobePlayed = 0
                }
            }
        }
        audioPlayer(songNumber: songNumberTobePlayed)
    }
    
    // Function plays song with number 'songNumber' from the audioResource array!
    func audioPlayer (songNumber:Int) {
        songNumberTobePlayed = songNumber
        let audioPath = Bundle.main.path(forResource: audioResource[songNumberTobePlayed], ofType: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf : URL(fileURLWithPath: audioPath!))
            songLabel.text = "Song number: " + audioResource[songNumberTobePlayed]
        }catch{
            print("Error playing")
        }
        player.play()
        
        
    }
    
}

