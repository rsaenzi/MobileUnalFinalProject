//
//  MapScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/22/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import MapKit
import KVNProgress

class MapScreen: UIViewController {
    
    @IBOutlet weak private var eventsMap: MKMapView!
    
    private var manager: CLLocationManager!
    private var permissionStatus: CLAuthorizationStatus!
    private let regionRadius: CLLocationDistance = 2000
    private var eventsForLocationRequested = false
    private var allEvents: [Event] = []
}

extension MapScreen {
    
    override func viewDidLoad() {
        
        // Request user current location
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        eventsMap.setRegion(coordinateRegion, animated: true)
    }
}

extension MapScreen: CLLocationManagerDelegate {
    
    // Called when user grants location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        self.permissionStatus = status
        
        guard self.permissionStatus == .authorizedAlways || self.permissionStatus == .authorizedWhenInUse else {
            self.showSimpleAlert(message: .errorNoLocationPermissionGranted)
            return
        }
        
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
    }
    
    // Called when
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation: CLLocation = locations.first else { return }
        centerMapOnLocation(location: userLocation)
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        // We request the points for current location only once
        if(!eventsForLocationRequested) {
            eventsForLocationRequested = true
            
            let point = MapPoint(coordinate: userLocation.coordinate)
            eventsMap.addAnnotation(point)
            
            KVNProgress.show()
            
            let coords = Coordinates(longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
            
            RequestGetEventFromLocation.request(coordinates: coords, numberofNearEvents: 10) { [weak self] response in
                
                KVNProgress.dismiss()
                
                guard let `self` = self else { return }
                
                switch response {
                case .success(let output):
                    
                    if let events = output.events {
                        self.allEvents = events
                        self.addEventsToMap()
                    }
                    
                default:
                    self.allEvents = []
                    self.showSimpleAlert(message: .errorOnFetchingData)
                }
            }
        }
    }
    
    private func addEventsToMap() {
        
        let points: [MapPoint] = allEvents.map { event -> MapPoint in
            let location = CLLocation(latitude: event.place.coordinates.latitude, longitude: event.place.coordinates.longitude)
            return MapPoint(coordinate: location, title: event.name, subtitle: event.description)
        }
        
        eventsMap.addAnnotations(points)
    }
}


extension MapScreen: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Map Point Selected")
    }
}




class MapPoint: NSObject, MKAnnotation {
    
    // Center latitude and longitude of the annotation view.
    // The implementation of this property must be KVO compliant.
    internal var coordinate: CLLocationCoordinate2D
    
    // Title and subtitle for use by selection UI.
    private var title: String?
    
    private var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    convenience init(coordinate: CLLocation, title: String? = nil, subtitle: String? = nil) {
        self.init(coordinate: coordinate.coordinate, title: title, subtitle: subtitle)
    }
}
