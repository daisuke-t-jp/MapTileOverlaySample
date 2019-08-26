//
//  ViewController.swift
//  MapTileOverlay
//
//  Created by Daisuke T on 2019/08/26.
//  Copyright © 2019 DaisukeT. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

  // 国土地理院ベースタイル
  static let templeteBaseGSI = "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png"
  
  // オーバーレイ（明治期の低湿地タイル）
  static let templeteOverlay = "https://cyberjapandata.gsi.go.jp/xyz/swale/{z}/{x}/{y}.png"
  
  static let tileSize = 256
  

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var buttonBaseStandard: UIButton!
  @IBOutlet weak var buttonBaseGSI: UIButton!
  @IBOutlet weak var buttonOverlay: UIButton!
  
  var overlay: MKTileOverlay?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    
    let region = MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: 35.627433, longitude: 139.778765),
                                         span: MKCoordinateSpan.init(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    mapView.region = region
    
    
    buttonBaseStandard.addTarget(self, action: #selector(buttonActionBaseStandard), for: .touchUpInside)
    buttonBaseGSI.addTarget(self, action: #selector(buttonActionBaseGSI), for: .touchUpInside)
    buttonOverlay.addTarget(self, action: #selector(buttonActionOverlay), for: .touchUpInside)
  }
  
}


// MARK: - Button Action
extension ViewController {
  
  @objc func buttonActionBaseStandard(_ sender: AnyObject) {
    self.overlay = nil
    mapView.removeOverlays(mapView.overlays)
  }
  
  @objc func buttonActionBaseGSI(_ sender: AnyObject) {
    self.overlay = nil
    mapView.removeOverlays(mapView.overlays)
    
    let overlay = MKTileOverlay.init(urlTemplate: ViewController.templeteBaseGSI)
    overlay.canReplaceMapContent = true
    overlay.tileSize = CGSize(width: ViewController.tileSize, height: ViewController.tileSize)
    
    mapView.addOverlay(overlay)
  }

  @objc func buttonActionOverlay(_ sender: AnyObject) {
    
    if let overlay = self.overlay {
      mapView.removeOverlay(overlay)
      self.overlay = nil
      return
    }
    
    let overlay = MKTileOverlay.init(urlTemplate: ViewController.templeteOverlay)
    overlay.canReplaceMapContent = false
    overlay.tileSize = CGSize(width: ViewController.tileSize, height: ViewController.tileSize)
    
    mapView.addOverlay(overlay)
    
    self.overlay = overlay
  }

}

  
// MARK: - MKMapViewDelegate
extension ViewController {
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    
    return MKTileOverlayRenderer.init(overlay: overlay)
  }
  
}

