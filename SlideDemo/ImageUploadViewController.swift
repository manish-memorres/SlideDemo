//
//  ImageUploadViewController.swift
//  SlideDemo
//
//  Created by M on 02/05/17.
//  Copyright © 2017 AJ. All rights reserved.
//

import UIKit

class ImageUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var closeButton:UIButton!
    @IBOutlet weak var uploadImageView:UIImageView!
    
    let imgPickerChoosePhoto = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.layer.cornerRadius = closeButton.frame.size.width / 2
        closeButton.layer.borderColor = UIColor.white.cgColor
        closeButton.layer.borderWidth = 1.0
        
        imgPickerChoosePhoto.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonClicked(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseImageClicked(sender: UIButton) {
        
        let actionSheet = UIAlertController.init(title: "Choose Image From", message: "", preferredStyle: .actionSheet)
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheet.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Camera", style: .default)
        { action -> Void in
            self.imgPickerChoosePhoto.allowsEditing = false
            self.imgPickerChoosePhoto.sourceType = .camera
            
            self.present(self.imgPickerChoosePhoto, animated: true, completion: nil)
        }
        actionSheet.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Photos", style: .default)
        { action -> Void in
            self.imgPickerChoosePhoto.allowsEditing = false
            self.imgPickerChoosePhoto.sourceType = .photoLibrary
            
            self.present(self.imgPickerChoosePhoto, animated: true, completion: nil)
            
        }
        actionSheet.addAction(deleteActionButton)
        
        self.present(actionSheet, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            uploadImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
