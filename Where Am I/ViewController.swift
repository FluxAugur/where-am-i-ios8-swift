//
//  ViewController.swift
//  Where Am I
//
//  Created by Nathanial L. McConnell on 9/20/14.
//  Copyright (c) 2014 Nathanial L. McConnell. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

  @IBOutlet weak var latitude: UILabel!
  @IBOutlet weak var longitude: UILabel!
  @IBOutlet weak var speed: UILabel!
  @IBOutlet weak var heading: UILabel!
  @IBOutlet weak var altitude: UILabel!
  @IBOutlet weak var nearestAddress: UILabel!
  
  var manager: CLLocationManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    var userLocation: CLLocation = locations[0] as CLLocation
    
    latitude.text = "\(userLocation.coordinate.latitude)"
    longitude.text = "\(userLocation.coordinate.longitude)"
    speed.text = "\(userLocation.speed)"
    heading.text = "\(userLocation.course)"
    altitude.text = "\(userLocation.altitude)"
    
    CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) in
      if ((error) != nil) {
       println("Error: \(error)")
      } else {
        let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
        var subThoroughfare = (p.subThoroughfare != nil) ? p.subThoroughfare + " " : ""
        var thoroughfare = (p.thoroughfare != nil) ? p.thoroughfare : ""
        self.nearestAddress.text = "\(subThoroughfare)\(thoroughfare)\n\(p.subLocality)\n\(p.subAdministrativeArea)\n\(p.postalCode)\n\(p.country)"
      }
    })
    // latitude.text = "\(userLocation.coordinate.latitude)"
  }
}

