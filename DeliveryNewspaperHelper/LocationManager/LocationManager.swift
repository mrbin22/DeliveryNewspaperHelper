//
//  LocationManager.swift
//  DeliveryNewspaperHelper
//
//  Created by cmStudent on 2024/11/04.
//

import MapKit


extension MKMapItem {
    private struct AssociatedKeys {
        static var customerKey = "customerKey"
    }

    // Getter và setter sử dụng đối tượng liên kết (associated object)
}



//extension MKMapItem {
////    func getCustomer(customer: Customer) -> Customer {
////        return customer
////    }
//    
//    var customer: Customer {
//        get {
//            return self.customer
//        }
//        
//        set {
//            self.customer = newValue
//        }
//    }
//}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude
    }
    
    
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude == rhs.center.latitude
    }
}



class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var region = MKCoordinateRegion()
    private var onUpdateHeading: ((CLLocationDirection) -> Void)?
    @Published var distance = CLLocationDistance()
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 1
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            
            region = MKCoordinateRegion(center: center, latitudinalMeters: 1000.0, longitudinalMeters: 1000.0)
        }
    }
    
    func startUpdatingHeading(_ onUpdate: @escaping (CLLocationDirection) -> Void) {
        if CLLocationManager.headingAvailable() {
            manager.startUpdatingHeading()
        }
        self.onUpdateHeading = onUpdate
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        onUpdateHeading?(newHeading.trueHeading)
    }
    
    @MainActor
    func calculateRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, transportType: MKDirectionsTransportType) {
        
//        
//        let sourcePlacemark = MKPlacemark(coordinate: from)
//        let destinatonPlacemark = MKPlacemark(coordinate: to)
        
        let distance = MKMapPoint(from).distance(to: MKMapPoint(to))
        print(distance)
//        
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: sourcePlacemark)
//        request.destination = MKMapItem(placemark: destinatonPlacemark)
//        request.transportType = transportType
        
//        do {
//            let directions = MKDirections(request: request)
//            let response = try await directions.calculate()
//            let routes = response.routes
//        } catch {
//            print(error.localizedDescription)
//        }
    }
}
