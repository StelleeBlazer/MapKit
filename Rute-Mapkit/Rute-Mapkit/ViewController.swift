//
//  ViewController.swift
//  Rute-Mapkit
//
//  Created by Mac n Cheese on 24/07/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var lblJarak: UILabel!
    @IBOutlet weak var lblWaktuTempuh: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapKit.delegate = self
        
        // lokasi awal dan tujuan
        let awal = CLLocationCoordinate2D(latitude: -6.1753871, longitude: 106.8249641)
        let tujuan = CLLocationCoordinate2D(latitude: -6.5252653, longitude: 107.035952)
        
        // convert coordinate
        let placeAwal = MKPlacemark(coordinate: awal)
        let placeTujuan = MKPlacemark(coordinate: tujuan)
        
        // convert dari placemark ke map item
        let itemAwal = MKMapItem(placemark: placeAwal)
        let itemTujuan = MKMapItem(placemark: placeTujuan)
        
        // eksekusi di map
        let mkRequest = MKDirections.Request()
        mkRequest.source = itemAwal
        mkRequest.destination = itemTujuan
        mkRequest.transportType = .automobile
        
        var namaLokasiAwal : String = ""
        // var namaLokasiTujuan : String = ""
        
        
        // bikin rute
        let direction = MKDirections(request: mkRequest)
        
        direction.calculate { (getRoute, error) in
            
            let jarak = getRoute?.routes[0].distance
            self.lblJarak.text = String(jarak!)
            
            let waktu = getRoute?.routes[0].expectedTravelTime
            self.lblWaktuTempuh.text = String(waktu!)
            
            let rute = getRoute?.routes[0].polyline
            self.mapKit.addOverlay(rute!, level: .aboveRoads)
            
            namaLokasiAwal = (getRoute?.routes[0].name)!
            print(namaLokasiAwal)
        }
        
        // pin awal
        
        let pinAwal = MKPointAnnotation()
        pinAwal.title = "Lokasi Awal"
        pinAwal.coordinate = awal
        
        // pin tujuan
        let pinTujuan = MKPointAnnotation()
        pinTujuan.title = "Lokasi Tujuan"
        pinTujuan.coordinate = tujuan
        
        mapKit.showAnnotations([pinAwal, pinTujuan], animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let garisRute = MKPolylineRenderer(overlay: overlay)
        garisRute.lineWidth = 3
        garisRute.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return garisRute
    }


}

