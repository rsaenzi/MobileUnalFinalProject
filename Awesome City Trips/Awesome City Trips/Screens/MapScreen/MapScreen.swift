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
    private var allPoints: [MapPoint] = []
    private var pointUserLocation: MapPoint?
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
        
        guard self.permissionStatus == .authorizedAlways || self.permissionStatus == .authorizedWhenInUse else {
            KVNProgress.dismiss()
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
            
            // Creates the annotation for user location
            self.pointUserLocation = MapPoint(coordinate: userLocation.coordinate)
            self.pointUserLocation!.title = "User Location"
            self.pointUserLocation!.subtitle = "You are here"
            eventsMap.addAnnotation(self.pointUserLocation!)
        
            let coordsUserLocation = Coordinates(longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
            
            // Request the list of events for that location
            RequestGetEventFromLocation.request(coordinates: coordsUserLocation, numberofNearEvents: 10) { [weak self] response in
                
                KVNProgress.dismiss()
                
                guard let `self` = self else { return }
                
                switch response {
                case .success(let output):
                    
                    guard let fetchedEvents = output.event else {
                        self.allEvents = []
                        self.allPoints = []
                        
                        self.showSimpleAlert(message: .errorOnFetchingData)
                        return
                    }
                    
                    // Store all events
                    self.allEvents = fetchedEvents
                    
                    // Now we create map points from all events
                    self.allPoints = self.allEvents.map { event -> MapPoint in
                        
                        let location = CLLocation(latitude: event.place.coordinates.latitude,
                                                  longitude: event.place.coordinates.longitude)
                        
                        let point = MapPoint(coordinate: location)
                        point.title = event.name
                        point.subtitle = ""
                        
                        return point
                    }
                    
                    self.eventsMap.addAnnotations(self.allPoints)
                    
                    
                default:
                    self.allEvents = []
                    self.allPoints = []
                    
                    self.showSimpleAlert(message: .errorOnFetchingData)
                }
            }
        }
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        eventsMap.setRegion(coordinateRegion, animated: true)
    }
}

extension MapScreen: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let selectedPoint = view.annotation as? MapPoint,
              let selectedIndex = self.allPoints.firstIndex(of: selectedPoint) else {
            return
        }
        
        let event = self.allEvents[selectedIndex]
        
        let screen: EventDetailsScreen = loadViewController()
        screen.setup(using: event)
        navigationController?.pushViewController(screen, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        // Creates the view id necessary
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView!.annotation = annotation
        }
        
        // Cast to marker to customize UI
        guard let marker = annotationView as? MKMarkerAnnotationView else {
            return annotationView
        }
        
        // Annotation for event
        if let selectedPoint = annotation as? MapPoint,
           let _ = self.allPoints.firstIndex(of: selectedPoint) {
            
            marker.canShowCallout = false
            marker.markerTintColor = UIColor.orange
            marker.animatesWhenAdded = false
            
        } else { // Annotation for User location
            marker.canShowCallout = true
            marker.markerTintColor = UIColor.magenta
            marker.animatesWhenAdded = true
        }
        
        return marker
    }
}


class MapPoint: NSObject, MKAnnotation {
    
    // Center latitude and longitude of the annotation view.
    // The implementation of this property must be KVO compliant.
    internal var coordinate: CLLocationCoordinate2D
    
    // Title and subtitle for use by selection UI.
    var title: String?
    
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    convenience init(coordinate: CLLocation, title: String? = nil, subtitle: String? = nil) {
        self.init(coordinate: coordinate.coordinate, title: title, subtitle: subtitle)
    }
}
