//
//  ViewController.swift
//  VRTakeMovie
//
//  Created by matsuohiroki on 2015/07/26.
//  Copyright © 2015年 matsuohiroki. All rights reserved.
//

import UIKit
import MobileCoreServices

class VRTakeMovieViewController: UIViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var previewImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let sheet: UIActionSheet = UIActionSheet()
        let title: String = "写真を投稿";
        sheet.title = title;
        sheet.delegate = self;
        sheet.addButtonWithTitle("キャンセル")
        sheet.addButtonWithTitle("写真を撮る")
        sheet.addButtonWithTitle("カメラロールから選択")
        sheet.addButtonWithTitle("動画を取る")
        sheet.cancelButtonIndex = 0
        sheet.showInView(self.view);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 1){
            self.pickImageFromCamera()
        } else if(buttonIndex == 2) {
            self.pickImageFromLibrary()
        } else {
            self.startCamera()
        }
    }
    
    func pickImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            
            let image:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.dismissViewControllerAnimated(true, completion: {() -> Void in
                self.previewImageView.image = image
            })
        }
        if let url = info[UIImagePickerControllerMediaURL] as? NSURL {
            self.dismissViewControllerAnimated(true, completion: {() -> Void in
            })

        }

    }
    
    func startCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let ipc: UIImagePickerController = UIImagePickerController()
            ipc.delegate = self
            ipc.sourceType = UIImagePickerControllerSourceType.Camera
            ipc.mediaTypes = [kUTTypeMovie as String]
            ipc.allowsEditing = false
            ipc.showsCameraControls = true
            self.presentViewController(ipc, animated: true, completion: nil)
        } else {
            print("この端末ではカメラを利用できません")
        }
    }
    
    
    /*
    * カメラロールへの保存が終了したとき
    */
    func video(videoPath: String, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        if (error != nil) {
            print("動画の保存に失敗しました。")
        } else {
            print("動画の保存に成功しました。")
        }
    }
}
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    



