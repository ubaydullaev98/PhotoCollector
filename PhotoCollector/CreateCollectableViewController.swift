//
//  CreateCollectableViewController.swift
//  PhotoCollector
//
//  Created by Dilmurod Ubaydullaev on 12/28/19.
//  Copyright © 2019 Dilmurod Ubaydullaev. All rights reserved.
//

import UIKit
import CoreData

class CreateCollectableViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    @IBAction func mediaFolderTapped(_ sender: UIBarButtonItem) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func addButtonTpped(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Collectable", in: context)!
        let newCollecable = NSManagedObject(entity: entity, insertInto: context)
        newCollecable.setValue(textField.text, forKey: "title")
        newCollecable.setValue(imageView.image?.jpegData(compressionQuality: 1.0), forKey: "image")
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    


}
