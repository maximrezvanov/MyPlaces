//
//  NewPlaceTableViewController.swift
//  MyPlaces
//
//  Created by MaximRezvanov on 3/25/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {

    var currentPlace: PlacesModel?
    
    var imageIsChange = false
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        
        placeName.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        
        setupEditPlace()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) {_  in
                self.chooseImagePicker(source: .camera)            }
            
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)            }
            
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel )
            
            present(actionSheet, animated: true)
            
        } else{
            view.endEditing(true)
        }
    }
    
    func savePlace() {
        
        
        var image: UIImage?
        if imageIsChange {
            image = placeImage.image
        } else{
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        
        let imageData = image?.pngData()
    
        let newPlace = PlacesModel(name: placeName.text!,
                                   location: placeLocation.text,
                                   type: placeType.text,
                                   imageData: imageData)
        if currentPlace != nil {
            
            try! realm.write {
                currentPlace?.imageData = newPlace.imageData
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
            }
            
        } else {StorageManager.saveObject(place: newPlace)}

    }
    
    func setupEditPlace() {
        if currentPlace != nil {
            guard let data =  currentPlace?.imageData, let image = UIImage(data: data) else { return }
            setupNavigationBar()
            imageIsChange = true
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFill
            placeName.text =  currentPlace?.name
            placeType.text = currentPlace?.type
            placeLocation.text = currentPlace?.location
        }
    }
    
    func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
        
    }
  
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension NewPlaceTableViewController: UITextFieldDelegate{
    //скрытие клавиатуры по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChange() {
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

extension NewPlaceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker (source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        imageIsChange = true
        dismiss(animated: true)
    }
    
}
