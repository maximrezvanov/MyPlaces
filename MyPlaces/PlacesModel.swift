//
//  PlacesModel.swift
//  MyPlaces
//
//  Created by MaximRezvanov on 3/23/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit

struct PlacesModel{
    
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var RestaurantImage: String?
    
    static let restaurantNames = ["Burger Heroes", "Kitchen", "Bonsai", "Дастархан", "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шок", "Бочка"]

    
    static func getPlaces() -> [PlacesModel] {
        
        var places = [PlacesModel]()
        
        for place in restaurantNames {
            places.append(PlacesModel(name: place, location: "Kerch", type: "Fast-Food", image: nil, RestaurantImage: place))
        }
        
        
        return places
    }
}
