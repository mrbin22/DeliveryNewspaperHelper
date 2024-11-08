//
//  Customer.swift
//  DeliveryNewspaperHelper
//
//  Created by cmStudent on 2024/11/05.
//

import Foundation
import MapKit

struct Customer: Identifiable, Equatable {
    let id = UUID().uuidString
    let name: String
    var address: CLLocationCoordinate2D
    var isDelivered = false
    
    var mapItem: MKMapItem {
        let placemark = MKPlacemark(coordinate: address)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
}


