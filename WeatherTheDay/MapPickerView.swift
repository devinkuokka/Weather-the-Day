import LocationPickerViewController
import CoreLocation
import Prephirences
import MapKit


class MapPicker : LocationPicker {
    fileprivate let currentState = Prephirences.instance(forKey: "currentState") as! MutableDictionaryPreferences
    fileprivate let favorites = Prephirences.instance(forKey: "favorites") as! MutablePreferencesType
    
    
    override func alternativeLocationDidDelete(locationItem: LocationItem) {
        super.alternativeLocationDidDelete(locationItem: locationItem)
       //alternativeLocations?.remove(at: (alternativeLocations?.index(of: locationItem))!)
        favorites.set(objectToArchive: alternativeLocations, forKey: "locations")
    }
    
    
    override func viewDidLoad() {
        self.addBarButtons()
        isAlternativeLocationEditable = true
        super.viewDidLoad()
        loadLocations()
    }
    
    func loadLocations() {
        if alternativeLocations == nil {
            alternativeLocations = []
        }
        alternativeLocations?.removeAll(keepingCapacity: true)
        if let favoriteLocations = favorites.unarchiveObject(forKey: "locations")  as? [LocationItem] {
            for location in favoriteLocations {
                alternativeLocations?.append(location)
            }
        }
    }
    
    
    open override func locationDidSelect(locationItem: LocationItem) {
        super.locationDidSelect(locationItem: locationItem)
        currentState.set(objectToArchive: locationItem, forKey: "location")
        if alternativeLocations == nil {
            alternativeLocations = []
        }
        
        if !(alternativeLocations?.contains(locationItem))! {
            alternativeLocations?.append(locationItem)
        }
        favorites.set(objectToArchive: alternativeLocations, forKey: "locations")
    }
    
    open override func locationDidPick(locationItem: LocationItem) {
        locationDidSelect(locationItem: locationItem)
        super.locationDidPick(locationItem: locationItem)
        
        if alternativeLocations == nil {
            alternativeLocations = []
        }
        
        if !(alternativeLocations?.contains(locationItem))! {
            alternativeLocations?.append(locationItem)
        }
        favorites.set(objectToArchive: alternativeLocations, forKey: "locations")
    }
    
    
    //    func numberOfAlternativeLocations() -> Int {
    //        return favorites.count
    //    }
    //
    //    func alternativeLocationAtIndex(index: Int) -> LocationItem {
    //       return favorites[index]
    //    }
    
}
