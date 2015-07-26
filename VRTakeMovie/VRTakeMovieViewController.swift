//
//  ViewController.swift
//  VRTakeMovie
//
//  Created by matsuohiroki on 2015/07/26.
//  Copyright © 2015年 matsuohiroki. All rights reserved.
//

import UIKit

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
        } else {
            self.pickImageFromLibrary()
        }
    }
    
    // 写真を撮ってそれを選択
    func pickImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    // ライブラリから写真を選択する
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    /*
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            
            let image:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.dismissViewControllerAnimated(true, completion: {() -> Void in
                self.previewImageView.image = image
            })
        }
    }
*/
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            
            let image:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.dismissViewControllerAnimated(true, completion: {() -> Void in
                self.previewImageView.image = image
            })
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
    
}


