//
//  ViewController.swift
//  FoodTracker
//
//  Created by Nadine Fares on 9/14/19.
//  Copyright © 2019 Nadine Fares. All rights reserved.
//

import UIKit
//Sublass of UIViewController. Inherits all behaviors.
//UITextFieldDelegate: tells the compiler that the ViewController class can act as a valid text field delegate (handles text input and assign instances as the delegate of the text field)
class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    //IBOutlet tells Xcode that you can connect to the nameTextField property from the interface builder (IB). The weak keywork indicates that the reference does not prevent the system from deallocating the referenced object.
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    /**
     This is called when the view controllers contect view is created and loaded from a storyboard. The view controller's outlets are guaranteed to have valid values by the time this method is called. 
     **/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self

    }
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true //returns a boolean value that indicates whether the system should process the press of the Return Key
    }
    
    /**
     Gives you a chance to read the information enterd into the text field and do something with it. In this case, the text in the text field will be used to change the value of the label when return is hit
     **/
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder() //ensures that if the user taps the image view while typing in the text field, the keyboard is dismissed properly.
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary //.photoLibrary uses the simulator's camera roll
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        //method being called on view controller to ask it to present the view controller defined by Picker controller
        present(imagePickerController, animated: true, completion: nil) //completion handler: a piece of code that executes after this method, nil means you don't have to do anything else
    }
    
}

