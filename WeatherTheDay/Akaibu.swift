//
//  Akaibu.swift
//  Akaibu
//
//  Created by Roy Tang on 4/10/2015.
//  Copyright © 2015 lerryrowy. All rights reserved.
//

import Foundation
protocol AkaibuProtocol {
    func getCollection() -> String
}

class Akaibu: NSObject, NSCoding, AkaibuProtocol {
    
    internal static let SuiteNameAkaibu: String = "Akaibu"
    internal var parentName: String! = "Akaibu"
    static let SUITE_NAME = "Akaibu"
    
    var objectId: String!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        var _class: AnyClass? = self.classForCoder
        while (_class != nil && _class != NSObject.self) {
            let properties = Akaibu.getProperties(_class: _class!)
            for (name, _) in properties {
                let value = aDecoder.decodeObject(forKey: self.encodingKeyForPropertyWithName(name: name))
                self.setValue(value, forKey: name)
            }
            _class = _class?.superclass()
        }
    }
    
    public func encode(with aCoder: NSCoder) {
        
        // add properties relatives to superclass
        var _class: AnyClass? = self.classForCoder
        
        while (_class != nil && _class != NSObject.self) {
            let properties = Akaibu.getProperties(_class: _class!)
            for (name, _) in properties {
                let value = self.value(forKey: name)
                aCoder.encode(value, forKey: self.encodingKeyForPropertyWithName(name: name))
            }
            _class = _class?.superclass()
        }
    }
    
    private func encodingKeyForPropertyWithName(name: String) -> String {
        return name
    }
    
    private static func getProperties(_class: AnyClass) -> [String: String] {
        var count: UInt32 = 0
        let properties = class_copyPropertyList(_class, &count)
        
        var results = [String: String]()
        for i in (0..<count) {
            let property = properties?[Int(i)]
            let name = NSString(utf8String: property_getName(property)) as! String
            
            let attrs = NSString(utf8String: property_getAttributes(property)) as! String
            
            results[name] = attrs
        }
        
        free(properties)
        
        return results
    }
    
    private class func toStr(utf8String: UnsafePointer<Int8>) -> String! {
        return NSString(utf8String: utf8String) as? String
    }
    
    private static func getIVars(_class: AnyClass) {
        var count: UInt32 = 0
        let ivarList = class_copyIvarList(_class, &count)
        
        var results = [String]()
        for i in (0..<count) {
            let property = ivarList?[Int(i)]
            let name = NSString(utf8String: ivar_getName(property)) as! String
            results.append(name)
        }
        
        free(ivarList)
    }
    
    func getCollection() -> String {
        return "\(type(of:self))"
    }
    
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Akaibu {
            return obj.objectId == self.objectId
        }
        return false
        
    }
    
    
    // MARK: Public APIs
    
    func saveWithKey(key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        
        if let userDefaults = UserDefaults(suiteName: Akaibu.SuiteNameAkaibu) {
            userDefaults.set(data, forKey: key)
            userDefaults.synchronize()
        }
    }
    
    class func saveWithKey(obj: Akaibu, key: String) {
        obj.saveWithKey(key: key)
    }
    
    class func loadWithKey(key: String) -> Akaibu? {
        if let userDefaults = UserDefaults(suiteName: Akaibu.SuiteNameAkaibu) {
            
            if let obj = userDefaults.object(forKey: key) as? Data,
                let data = NSKeyedUnarchiver.unarchiveObject(with: obj) as? Akaibu {
                return data
            }
        }
        
        return nil
    }
    
    class func removeAll() {
        let defaults = UserDefaults(suiteName: Akaibu.SuiteNameAkaibu)
        
        UserDefaults(suiteName: Akaibu.SuiteNameAkaibu)?.dictionaryRepresentation().keys.forEach({ (key) -> () in
            defaults?.removeObject(forKey: key)
        })
    }
}
