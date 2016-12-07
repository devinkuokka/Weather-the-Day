import Foundation
import Prephirences


fileprivate func debugHomeModel() -> HomeModel {
    return HomeModel(latitude: 38.2,
                     longitude: 13.4,
                     description: "Rainy",
                     iconPath: "Sun",
                     temp: 22,
                     low: 12,
                     high: 30,
                     chanceOfPrecip: 0.4,
                     minutesUntilPrecip: 20,
                     typeOfPrecip: .Snow)
}

func initializePreferences() {
    let currentState: MutableDictionaryPreferences = ["location": "",
                                                      "forecast": "",
                                                      "debugHomeModel": debugHomeModel()]
    Prephirences.registerInstance(UserDefaults.standard, forKey: "favorites")
    Prephirences.registerInstance(currentState as PreferencesType,
                                  forKey: "currentState")
}


