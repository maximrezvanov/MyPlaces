//
//  MainViewController.swift
//  MyPlaces
//
//  Created by MaximRezvanov on 3/22/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    

    var places: Results<PlacesModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        places = realm.objects(PlacesModel.self)
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let place = places[indexPath.row]

        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfPlaces.image = UIImage(data: place.imageData!)
 
        cell.imageOfPlaces.layer.cornerRadius = cell.imageOfPlaces.frame.size.height / 2
        cell.imageOfPlaces.clipsToBounds = true

        return cell
    }
    //MARK: - delete row
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
             let delete = deleteAction(at: indexPath)
             return UISwipeActionsConfiguration(actions: [delete])
         }

         func deleteAction(at indexPath: IndexPath) -> UIContextualAction {

            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
                let place = self.places[indexPath.row]
                StorageManager.deleteObject(place: place)
                self.tableView.reloadData()
                 }
            return deleteAction
             }
             
         
  


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.saveNewPlace()
        tableView.reloadData()
    }
}
