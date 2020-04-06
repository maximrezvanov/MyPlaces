//
//  PlacesModel.swift
//  MyPlaces
//
//  Created by MaximRezvanov on 3/23/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import RealmSwift

class PlacesModel: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    
    convenience init (name: String, location: String?, type: String?, imageData: Data?){
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
