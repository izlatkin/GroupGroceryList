//
//  SignUpViewController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/4/21.
//

import UIKit
import AlamofireImage
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var choseimage=false
    let user = PFUser()
    
    
    @IBOutlet weak var TFusername: UITextField!
    
    @IBOutlet weak var TFPassword: UITextField!
    
    
    @IBOutlet weak var ivProfilePic: UIImageView!
    
    @IBAction func TapProfilePic(_ sender: Any) {
        let picker=UIImagePickerController()
        picker.delegate=self
        picker.allowsEditing=true
        print("clicking")
    
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    
        
    }
    
    
    @IBAction func btnCreateAccount(_ sender: Any) {
        
        
        user.username=TFusername.text
        user.password=TFPassword.text
        user.signUpInBackground { success, Error in
            if success{
                    self.performSegue(withIdentifier: "SignUpCompleteSegue", sender: nil)
            }
            else{
                print("Error signing up")
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image=info[.editedImage] as! UIImage
        
        let size=CGSize(width: 300, height: 300)
        let scaledimage=image.af_imageScaled(to: size)
        
        ivProfilePic.image=scaledimage
        choseimage=true
        
        let imagedata=ivProfilePic.image!.pngData()
        let file=PFFileObject(name: "image.png", data: imagedata!)
        
        user["ProfilePicture"] = file   //can set this before saving to parse
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
