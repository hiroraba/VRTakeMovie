//
//  CaptureViewController.swift
//  VRTakeMovie
//
//  Created by matsuohiroki on 2015/07/26.
//  Copyright © 2015年 matsuohiroki. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class CaputureViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    var index = 2
    
    let captureSession = AVCaptureSession()
    let videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
    let fileOutput = AVCaptureMovieFileOutput()
    
    var startButton, stopButton : UIButton!
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
        let videoInput =  try AVCaptureDeviceInput(device:self.videoDevice) as AVCaptureDeviceInput
        self.captureSession.addInput(videoInput)
        let audioInput = try AVCaptureDeviceInput(device:self.audioDevice)  as AVCaptureInput
        self.captureSession.addInput(audioInput);
        
        self.captureSession.addOutput(self.fileOutput)
        } catch let error as NSError {
            print(error)
        }
            
        let videoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession) as AVCaptureVideoPreviewLayer
        videoLayer.frame = self.view.bounds
        videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(videoLayer)
        
        self.setupButton()
        self.captureSession.startRunning()
    }
    
    func setupButton(){
        self.startButton = UIButton(frame: CGRectMake(0,0,120,50))
        self.startButton.backgroundColor = UIColor.redColor();
        self.startButton.layer.masksToBounds = true
        self.startButton.setTitle("start", forState: .Normal)
        self.startButton.layer.cornerRadius = 20.0
        self.startButton.layer.position = CGPoint(x: self.view.bounds.width/2 - 70, y:self.view.bounds.height-50)
        self.startButton.addTarget(self, action: "onClickStartButton:", forControlEvents: .TouchUpInside)
     
        /*
        self.stopButton = UIButton(frame: CGRectMake(0,0,120,50))
        self.stopButton.backgroundColor = UIColor.grayColor();
        self.stopButton.layer.masksToBounds = true
        self.stopButton.setTitle("stop", forState: .Normal)
        self.stopButton.layer.cornerRadius = 20.0
        
        self.stopButton.layer.position = CGPoint(x: self.view.bounds.width/2 + 70, y:self.view.bounds.height-50)
        self.stopButton.addTarget(self, action: "onClickStopButton:", forControlEvents: .TouchUpInside)
        */
        self.view.addSubview(self.startButton);
        //self.view.addSubview(self.stopButton);
    }
    
    func onClickStartButton(sender: UIButton){
        if !self.isRecording {
            // start recording
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDirectory = paths[0] as String
            let filePath : String? = "\(documentsDirectory)/temp.mp4"
           // let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)!
            fileOutput.startRecordingToOutputFileURL( NSURL(fileURLWithPath: filePath!), recordingDelegate: self)
            
            self.isRecording = true
            self.changeButtonColor(self.startButton, color: UIColor.grayColor())
            //self.changeButtonColor(self.stopButton, color: UIColor.redColor())
        } else {
            fileOutput.stopRecording()
            
            self.isRecording = false
            self.changeButtonColor(self.startButton, color: UIColor.redColor())
            //self.changeButtonColor(self.stopButton, color: UIColor.grayColor())
        }
    }
    
    func onClickStopButton(sender: UIButton){
        if self.isRecording {
            fileOutput.stopRecording()
            
            self.isRecording = false
            self.changeButtonColor(self.startButton, color: UIColor.redColor())
            self.changeButtonColor(self.stopButton, color: UIColor.grayColor())
        }
    }
    
    func changeButtonColor(target: UIButton, color: UIColor){
        target.backgroundColor = color
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        let assetsLib = ALAssetsLibrary()
        assetsLib.writeVideoAtPathToSavedPhotosAlbum(outputFileURL, completionBlock: nil)
    }
}
