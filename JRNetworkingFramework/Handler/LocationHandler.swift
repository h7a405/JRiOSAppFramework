//
//  LocationHandler.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 21/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//
//MARK: - Header
//MARK: Header - Files
import UIKit
import CoreLocation
//MARK: Header - Protocols
protocol LocationHandlerDelegate {
    func updateLocation(name: String?)
}
//MARK: - Class
//MARK: - Classes - Body
class LocationHandler: NSObject {
    //MARK: - Parameter
    //MARK: - Parameters - Constant
    //MARK: - Parameters - Basic
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    //MARK: - Parameters - Array
    //MARK: - Parameters - Dictionary
    //MARK: - Parameters - Tuple
    //MARK: - Parameters - Customed
    //MARK: Customed - Normal
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: JRLocation = JRLocation(longitude: 0, latitude: 0, altitude: 0)
    //MARK: Customed - Delegate
    var delegate: LocationHandlerDelegate?
    //MARK: Customed - Datasource
    //MARK: Customed - Enum
    
    //MARK: - Method
    //MARK: - Methods - Life Circle
    //MARK: - Methods - Implementation
    override init() {
        super.init()
    }
    convenience init(delegate: LocationHandlerDelegate?) {
        self.init()
        self.delegate = delegate
        if CLLocationManager.locationServicesEnabled() == false {
            SVProgressHUD.showErrorWithStatus("请先开启定位。")
            return;
        }
        if !Tool.is_iOS7() {
            self.locationManager.requestWhenInUseAuthorization()
        }
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        self.updateLocation()
    }
    //MARK: - Methods - Operation
    //MARK: Operations - Go Operation
    //MARK: Operations - Do Operation
    //MARK: Operations - Show or Dismiss Operation
    //MARK: Operations - Setup Operation
    //MARK: Operations - Customed Operation
    func updateLocation() {
        self.locationManager.startUpdatingLocation()
    }
    //MARK: - Methods - Getter
    func getAddressNameWithLocation(location: JRLocation) {
        let cllocation: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geoCoder: CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(cllocation, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) in
            if placemarks != nil {
                
                let placemark: CLPlacemark = placemarks!.first!
                Log.VLog(placemark.addressDictionary)
            }
//            if self.delegate != nil {
//                for (_, (key, content)) in placemark.addressDictionary!.enumerate() {
//                    if (key as! String) == "Name" {
//                        self.delegate!.updateLocation(content as? String)
//                    }
//                }
//            }
        })
    }
    //MARK: - Methods - Setter
}
//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
//MARK: - Extensions - Delegate
extension LocationHandler: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.first!
        let coordinate: CLLocationCoordinate2D = location.coordinate
        self.currentLocation = JRLocation(longitude: coordinate.longitude, latitude: coordinate.latitude, altitude: location.altitude)
        Log.DLog(self.currentLocation.toString())
        self.locationManager.stopUpdatingLocation()
    }
}
//MARK: - Classes - Custom
class JRLocation: NSObject {
    var longitude: Double = 0
    var latitude: Double = 0
    var altitude: Double = 0
    override init() {
        super.init()
    }
    convenience init(longitude: Double, latitude: Double, altitude: Double) {
        self.init()
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
    }
    func toString() -> String {
        return "longitude:\(longitude), latitude:\(latitude), altitude:\(altitude)"
    }
}