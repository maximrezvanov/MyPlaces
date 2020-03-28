//
//  StorageManager.swift
//  MyPlaces
//
//  Created by MaximRezvanov on 3/28/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import RealmSwift

let realm = try! Realm ()

class StorageManager {
    static func saveObject(place: PlacesModel){
        try! realm.write {
            realm.add(place)
        }
        
    }
    
    static func deleteObject(place: PlacesModel){
        try! realm.write{
            realm.delete(place)
        }
    }
    
}
