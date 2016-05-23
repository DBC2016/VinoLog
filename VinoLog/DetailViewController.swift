//
//  DetailViewController.swift
//  VinoLog
//
//  Created by Demond Childers on 5/20/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    let backendless = Backendless.sharedInstance()
    let loginManager = LoginManager.sharedInstance
    var currentUser = BackendlessUser()
    var vinoSelected :Vinos?
    
    
    
    //IBActions for Storyboard
    
    
    @IBOutlet private weak var vinoNameTextField             :UITextField!
    @IBOutlet private weak var vinoCompanyTextField          :UITextField!
    @IBOutlet private weak var vinoVintageTextField          :UITextField!
    @IBOutlet private weak var vinoCategoryTextField         :UITextField!
    @IBOutlet private weak var vinoVariTextField             :UITextField!
    @IBOutlet private weak var vinoDescripTextField          :UITextView!
    @IBOutlet private weak var vinoImageView                 :UIImageView!
    @IBOutlet private weak var vinoRatingStackView           :UIStackView!
    
    
    
    
    
    
    
    //MARK: - DATA METHODS
    
    private func saveNewVino(newVino: Vinos){
        let dataStore = backendless.data.of(Vinos.ofClass())
        dataStore.save(newVino, response: { (result) in
            print("Vino Saved")
        }) { (fault) in
            print("Server Reported Error:\(fault)")
            
        }
    }

    
    //MARK: - Interactivity Methods
    
    @IBAction private func saveButtonPressed(button: UIBarButtonItem) {
        print("Vino Saved")
        guard let vino = vinoSelected else {
            return
        }
        vino.vinoName = vinoNameTextField.text!
        vino.vinoCompany = vinoCompanyTextField.text!
        vino.vinoVintage = vinoVintageTextField.text!
        vino.vinoVari = vinoVariTextField.text!
//        vinoSelected!.vinoImage = vinoImageView.image!
        vino.vinoCategory = vinoCategoryTextField.text!
        vino.vinoDescrip = vinoDescripTextField.text!
        //vino DATE...
        saveNewVino(vino)
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    @IBAction private func trashButtonPressed (button: UIBarButtonItem) {
        print("Vino Removed")
        if let entrySelected = vinoSelected {
            backendless.delete(entrySelected)
            saveNewVino(entrySelected)
        }
    }

    
    //MARK: - Data View Methods
    
    
//    func newDataRecv() {
//        print("reloading data")
//        completeForecast()
//    }
//    
//    
//    func curDataRecv() {
//        print("DM Temp: \(dataManager.currentWeather.weatherTemp)")
//        
//    }
    
    
    
    //MARK: - STACK VIEW METHODS
    
    
    private func addVino() {
        let vinoImageView = UIImageView(image: UIImage(named: "vinoIcon"))
        vinoImageView.contentMode = .ScaleAspectFit
        let vinoCount = vinoRatingStackView.arrangedSubviews.count
        if vinoCount < 10{
            vinoRatingStackView.insertArrangedSubview(vinoImageView, atIndex: vinoCount - 1)
            UIView.animateWithDuration(0.25) { () -> Void in
                self.vinoRatingStackView.layoutIfNeeded()
            }
        }
    }
    
    
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Add")
        let vinoImageView = UIImageView(image: UIImage(named: "vinoIcon"))
        vinoImageView.contentMode = .ScaleAspectFit
        let vinoCount = vinoRatingStackView.arrangedSubviews.count
        vinoRatingStackView.insertArrangedSubview(vinoImageView, atIndex: vinoCount - 1)
        
        
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.vinoRatingStackView.layoutIfNeeded()
            
            
        }
        
    }
    
    @IBAction func removeButtonPressed(sender: UIButton) {
        print("Remove")
        let vinoCount = vinoRatingStackView.arrangedSubviews.count
        if vinoCount  > 0 {
            let vinoToRemove = vinoRatingStackView.arrangedSubviews[vinoCount - 2]
            vinoRatingStackView.removeArrangedSubview(vinoToRemove)
            vinoToRemove.removeFromSuperview()
            UIView.animateWithDuration(0.25) { () -> Void in
                self.vinoRatingStackView.layoutIfNeeded()
                
            }
        }
    }
    //MARK: - SAVE FILE METHODS
    
//    
//    @IBAction private func saveButtonPressed(button: UIButton) {
//        if let image = capturedImage.image {
//            let imagePath = getDocumentPathForFile(getNewImageFilename())
//            
//            UIImagePNGRepresentation(image)!.writeToFile(imagePath, atomically: true)
//        } else {
//            print("No Image to Save")
//            
//        }
//        
//        
//    }
//    
//    
//    private func getNewImageFilename() -> String {
//        return NSProcessInfo.processInfo().globallyUniqueString + ".png"
//    }
//    
//    
//    private func getDocumentPathForFile(filename: String) -> String {
//        let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
//        print("Path:\(docPath)")
//        return docPath.stringByAppendingPathComponent(filename)
//    }
    
    
    
    //MARK: - BUILT-IN CAMERA METHODS
    
    //Code to pull photos from Gallery
    
    @IBAction private func galleryButtonTapped(button: UIBarButtonItem) {
        print("gallery")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .SavedPhotosAlbum
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction private func cameraButtonTapped(button: UIBarButtonItem) {
        print("Camera")
        //Code to bring up Camera App
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .Camera
            imagePicker.delegate = self
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            print("No Camera")
            
        }
        
    }
    
    
//    // Better Understand difference between these functions and their use
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        capturedImage.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
//        picker.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    
//    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        picker.dismissViewControllerAnimated(true, completion: nil)
//        
//    }
//    
    
    //MARK: - LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let vino = vinoSelected{
            vinoNameTextField.text = vino.vinoName
            vinoCompanyTextField.text = vino.vinoCompany
            vinoVintageTextField.text = vino.vinoVintage
            vinoVariTextField.text = vino.vinoVari
            //        vinoSelected!.vinoImage = vinoImageView.image!
            vinoCategoryTextField.text = vino.vinoCategory
            vinoDescripTextField.text = vino.vinoDescrip
        } else {
            vinoSelected = Vinos()
            vinoNameTextField.text = ""
            vinoCompanyTextField.text = ""
            vinoVintageTextField.text = ""
            vinoVariTextField.text = ""
            //        vinoSelected!.vinoImage = vinoImageView.image!
            vinoCategoryTextField.text = ""
            vinoDescripTextField.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
