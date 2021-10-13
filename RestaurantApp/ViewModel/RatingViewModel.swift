//
//  RatingViewModel.swift
//  RestaurantApp
//
//  Created by Linus Wang on 4/30/21.
//

import SwiftUI
import CoreLocation
import Firebase

class RatingViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    // Location Detail
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    // Menu...
    @Published var showMenu = false
    
    // ItemData...
    @Published var items: [RestaurantItem] = []
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // checking Access to location
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("Denied")
            self.noLocation = true
        default:
            self.noLocation = false
            print("Unknown")

            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Reading user location, extract details
        
        self.userLocation = locations.last
        self.extractLocation()
        // After extracting location, log in
        self.login()
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation){ (res,err) in
            
            guard let safeData = res else{return}
            
            var address = ""
            
            // Getting area and locatlity name
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    
    // login anynomusly into database
    func login(){
        
        Auth.auth().signInAnonymously{ (res, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            print("Success = \(res!.user.uid)")
            
            self.fetchData()
            print("ok")
        }
    }
    
    // Fetching items data
    func fetchData(){
        let db = Firestore.firestore()
        print("Yes!")
        
        db.collection("001").getDocuments{ (snap, err) in
            guard let itemData = snap else{return}
            
            self.items = itemData.documents.compactMap({(doc) -> RestaurantItem? in
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! String
                let ratings = doc.get("item_ratings") as! String
                let image = doc.get("item_image") as! String
                let details = doc.get("item_details") as! String
                
                
                return RestaurantItem(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_ratings: ratings)
            })
        }
    }
}
