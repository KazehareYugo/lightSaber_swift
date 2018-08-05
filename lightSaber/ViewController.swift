//
//  ViewController.swift
//  lightSaber
//
//  Created by Kazehare Yugo on 2018/08/05.
//  Copyright © 2018年 xyz.app. All rights reserved.
//

import UIKit
import CoreMotion //加速度センサーの値を取得するフレームワーク
import AVFoundation  //音を再生するためのフレームワーク
//①いろいろインポート

class ViewController: UIViewController {
    
    //⑵変数とか定義して行く
    let motionManager : CMMotionManager = CMMotionManager()
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    var startAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSound()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func tappedStartButton(_ sender: UIButton) {
        startAudioPlayer.play()
        startGetAccelerometer()
        
        
    }
    func setupSound() {
        //soundがちゃんと読み込めている場合は下のプログラムを実行しなさい
        if let sound = Bundle.main.path(forResource: "light_saber1", ofType: ".mp3") {
            //try はエラー処理　もしだめだったら落としてください
            audioPlayer = try! AVAudioPlayer(contentsOf:  URL(fileURLWithPath: sound))
            audioPlayer.prepareToPlay()
        }
        if let sound = Bundle.main.path(forResource: "Light_saber3", ofType: ".mp3") {
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            audioPlayer.prepareToPlay()
            
        }
        
    }
    
    func startGetAccelerometer() {
        motionManager.accelerometerUpdateInterval = 1 / 100
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (accelerometerData: CMAccelerometerData?, error: Error?) in
            if let acc =  accelerometerData {
                let x = acc.acceleration.x
                let y = acc.acceleration.y
                let z = acc.acceleration.z
                let synthetic = (x * x) + (y * y) + (z * z)
                
                if synthetic >= 8 {
                    self.audioPlayer.play()
                }
            }
            
        }
    }
    

}

