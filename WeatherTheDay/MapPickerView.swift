import LocationPickerViewController
import CoreLocation
import MapKit


class MapPicker : LocationPicker {
    
    var favorites = [LocationItem]()
    
    open override func locationDidSelect(_ locationItem: LocationItem) {
        super.locationDidSelect(locationItem)
        let defaults = UserDefaults.standard
        defaults.set("\(locationItem.coordinate!.latitude)", forKey: "selectedLat")
        defaults.set("\(locationItem.coordinate!.longitude)", forKey: "selectedLon")
       
        defaults.set(locationItem.formattedAddressString, forKey: "favName")
        favorites = []
        loadFavorites()
    }
    
    
    func numberOfAlternativeLocations() -> Int {
        return favorites.count
    }
    
    func alternativeLocationAtIndex(index: Int) -> LocationItem {
       return favorites[index]
    }

    func loadFavorites() {
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "favName") {
            CLGeocoder().geocodeAddressString(name) {places, error in
                if let location = places?[0].location?.coordinate {
                    self.favorites.append(LocationItem(mapItem:
                        MKMapItem.init(placemark:
                            MKPlacemark(coordinate: location))))
                }
            }
        }
    }
}
