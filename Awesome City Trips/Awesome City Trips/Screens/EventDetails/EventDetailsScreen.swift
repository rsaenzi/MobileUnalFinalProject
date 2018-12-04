//
//  EventDetailsScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/23/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
import KVNProgress

class EventDetailsScreen: UIViewController {
    
    @IBOutlet weak private var eventBanner: UIImageView!
    @IBOutlet weak private var eventName: UILabel!
    @IBOutlet weak private var eventDate: UILabel!
    @IBOutlet weak private var eventPlace: UILabel!
    @IBOutlet weak private var eventPrice: UILabel!
    @IBOutlet weak private var eventRating: UILabel!
    @IBOutlet weak private var eventMap: MKMapView!
    @IBOutlet weak private var buttonBuy: UIButton!
    
    private var selectedEvent: Event?
}

extension EventDetailsScreen {
    
    func setup(using event: Event) {
        self.selectedEvent = event
    }
    
    override func viewDidLoad() {
        
        guard let selectedEvent = self.selectedEvent else {
            self.showSimpleAlert(message: .errorNoSelectedEvent)
            return
        }
        
        cleanLoadedEvent()
        
        KVNProgress.show()
        
        RequestGetEvent.request(eventId: selectedEvent.id) { [weak self] response in
            
            KVNProgress.dismiss()
            
            guard let `self` = self else { return }
            
            switch response {
            case .success(let output):
                self.selectedEvent = output.event
                self.loadFetchedEvent()
                
            default:
                self.selectedEvent = nil
                self.cleanLoadedEvent()
                
                self.showSimpleAlert(message: .errorOnFetchingData)
            }
        }
    }
    
    @IBAction func onTapBuy(_ sender: UIButton, forEvent event: UIEvent) {
        
        let screen: CreditCardsScreen = loadViewController()
        screen.selectedEvent = self.selectedEvent
        navigationController?.pushViewController(screen, animated: true)
    }
    
    private func loadFetchedEvent() {
        
        guard let event = self.selectedEvent else { return }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM d, yyyy"
        
        eventName.text = event.name
        eventDate.text = dateFormat.string(from: event.date)
        eventPlace.text = event.place.name
        eventPrice.text = "$\(event.price)"
        eventRating.text = "⭐️ x \(event.rating)"
        
        buttonBuy.isEnabled = true
        buttonBuy.backgroundColor = .red
        
        let anno = MKPointAnnotation();
        anno.coordinate = CLLocationCoordinate2D(
            latitude: event.place.coordinates.latitude,
            longitude: event.place.coordinates.longitude)
        
        eventMap.addAnnotations([anno])
        eventMap.showAnnotations([anno], animated: true)
        
        guard let imageUrl: URL = URL(string: event.iconUrl) else {
            eventBanner.image = nil
            return
        }
        
        let completion: CompletionHandler = {
            (image, error, cacheType, imageUrl) in
            
            guard let url = imageUrl else {
                print("Invalid image URL")
                return
            }
            guard let _ = image else {
                print("\(url) can not be loaded...")
                return
            }
            if let _ = error {
                print("\(url) loaded with error...")
                return
            }
        }
        
        let image = ImageResource(downloadURL: imageUrl, cacheKey: "event\(event.id)")
        eventBanner.kf.indicatorType = .activity
        eventBanner.kf.setImage(
            with: image,
            placeholder: nil,
            options: [.transition(.fade(0.2))],
            progressBlock: nil,
            completionHandler: completion)
    }
    
    private func cleanLoadedEvent() {
        
        eventBanner.image = nil
        eventName.text = nil
        eventDate.text = nil
        eventPlace.text = nil
        eventPrice.text = nil
        eventRating.text = nil
        
        buttonBuy.isEnabled = false
        buttonBuy.backgroundColor = .gray
        
        eventMap.removeAnnotations(eventMap.annotations)
    }
}

extension EventDetailsScreen: MKMapViewDelegate {
    
}
