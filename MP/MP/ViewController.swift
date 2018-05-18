//
//  ViewController.swift
//  MP
//
//  Created by SSY on 2018. 5. 10..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //MARK: Properties
    var audioPlayer: AVAudioPlayer!
    var timer: Timer!
    
    //MARK: IBOutlets
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var startTiemLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    // MARK: Methods
    // 처음 음악 재생시
    func initializePlayer() {
        // Assets 카탈로그에서 전체 음원 파일을 가져오는 방법 구상하기!
//        guard let soundAssets = NSDataAsset(name: "Music", bundle: Bundle.main) else {
        guard let soundAsset = NSDataAsset(name: "0") else {
            print("음원 파일을 가져 올 수 없습니다.")
            return
        }
       
        do {
            try self.audioPlayer = AVAudioPlayer(data: soundAsset.data)
//            self.audioPlayer.delegate = self
        } catch let error {
            print("erro: \(error.localizedDescription)")
        }
    }
    
    //MARK: IBActions
    // 재생 멈춤 버튼 눌렀을 경우
    @IBAction func touchPlayPauseButton(_ sender: UIButton) {
        // sender.isSelected에
        // 현재 sender.isSelected의 반대 상태를 넣어줌
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.audioPlayer?.play()
        }else{
          self.audioPlayer?.pause()
        }
    }
    // 슬라이더 값 변화
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializePlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

