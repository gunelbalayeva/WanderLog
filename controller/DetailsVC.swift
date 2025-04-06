//
//  DetailsVC.swift
//  WanderLog
//
//  Created by User on 02.04.25.
//
import UIKit
import MapKit
import CoreLocation
import CoreData

class DetailsVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,
                 MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var countryName: UITextField!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var mapView: MKMapView!
//    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // map
//        mapView.delegate = self
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
 
        //RECOGNIZERS
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(gestureRecognizer)
        myImageView.isUserInteractionEnabled = true
        let imageViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImageview))
        myImageView.addGestureRecognizer(imageViewRecognizer)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location,span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    
   @objc func selectImageview() {
       let picker = UIImagePickerController()
       picker.delegate = self
       picker.sourceType = .photoLibrary
       picker.allowsEditing = true
       present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                myImageView.image = selectedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
    @objc func hideKeyBoard(){
        view.endEditing(true)
    }

    @IBAction func didSaveButton(_ sender: UIButton) {
        if let image = myImageView.image,
           let country = countryName.text, !country.isEmpty,
           let city = cityName.text, !city.isEmpty,
           let yearText = year.text, let year = Int(yearText), year > 0 {
            
            let imageData = image.pngData() ?? Data()
            let newId = UUID()
            CoreDataManager.shared.addTravel(countryName: country, cityName: city, id: newId, image: imageData, year: year)
            print("Data saved successfully!")
        } else {
            var alert = UIAlertController(title: "Validation error", message: "Please fill all requared fileds", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    @IBAction func didDeleteButton(_ sender: Any) {
        print("Delete")
    }
    
}
