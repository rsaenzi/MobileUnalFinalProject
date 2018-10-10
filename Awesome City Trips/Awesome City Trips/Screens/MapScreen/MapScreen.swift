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
    private var firstAuthChangeDone = false
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
}

extension MapScreen: CLLocationManagerDelegate {
    
    // Called when user grants location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        self.permissionStatus = status
        
        // This prevent the first time to display the errorNoLocationPermissionGranted error by mistake
//        if firstAuthChangeDone == false {
//            firstAuthChangeDone = true
//            return
//        }
        
        guard self.permissionStatus == .authorizedAlways || self.permissionStatus == .authorizedWhenInUse else {
            KVNProgress.dismiss()
            //self.showSimpleAlert(message: .errorNoLocationPermissionGranted)
            return
        }
        
        KVNProgress.show()
        
        guard CLLocationManager.locationServicesEnabled() else {
            KVNProgress.dismiss()
            self.showSimpleAlert(message: .errorLocationError)
            return
        }
        
        manager.startUpdatingLocation()
    }
    
    // Called when user moves and iOS updates its location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation: CLLocation = locations.first else {
            KVNProgress.dismiss()
            self.showSimpleAlert(message: .errorLocationError)
            return
        }
        
        print("Location Long: \(userLocation.coordinate.longitude) - Lat: \(userLocation.coordinate.latitude)")
        
        // We request the points for current location only once
        if(!eventsForLocationRequested) {
            eventsForLocationRequested = true
            
            // Zoom to user location
            centerMapOnLocation(location: userLocation)
            
            let pointUserLocation = MapPoint(coordinate: userLocation.coordinate)
            eventsMap.addAnnotation(pointUserLocation)
        
            let coordsUserLocation = Coordinates(longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
            
            RequestGetEventFromLocation.request(coordinates: coordsUserLocation, numberofNearEvents: 10) { [weak self] response in
                
                KVNProgress.dismiss()
                
                guard let `self` = self else { return }
                
                switch response {
                case .success(let output):
                    
                    if let fetchedEvents = output.event {
                        self.allEvents = fetchedEvents
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
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        eventsMap.setRegion(coordinateRegion, animated: true)
    }
}


extension MapScreen: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Map Point Selected")
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let identifier = "Annotation"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView!.canShowCallout = true
//        } else {
//            annotationView!.annotation = annotation
//        }
//
//        return annotationView
//    }
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
