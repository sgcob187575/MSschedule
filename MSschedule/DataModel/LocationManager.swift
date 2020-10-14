//
//  LocationManager.swift
//  MSplan
//
//  Created by 陳昱豪 on 2020/8/19.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import GoogleMaps
class LocationManager: NSObject,ObservableObject {
    static let shared = LocationManager()
    @Published var mapItems = [MKMapItem]()
    @Published var location:CLLocationCoordinate2D?
    
    let manager = CLLocationManager()
    override init() {
        super.init()
        manager.delegate = self
    }
    func getLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
      // 1
      let geocoder = GMSGeocoder()

      // 2
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard
          let address = response?.firstResult(),
          let lines = address.lines
          else {
            return
        }
        dump(lines)
      }
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let request=MKLocalSearch.Request()
        request.naturalLanguageQuery="海"
        request.region=MKCoordinateRegion(center: locations.last!.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        self.location=locations.last!.coordinate
        let search=MKLocalSearch(request: request)
        search.start{(response,err) in
            if let mapItems = response?.mapItems {
            self.mapItems = mapItems
            }
            self.mapItems.forEach { (mapitem) in
                print(mapitem.name)
                print(mapitem.placemark.coordinate)
            }
            self.reverseGeocode(coordinate: self.location!)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
