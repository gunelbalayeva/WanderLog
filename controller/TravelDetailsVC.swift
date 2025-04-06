//
//  TravelDetailsVC.swift
//  WanderLog
//
//  Created by User on 04.04.25.
//

import UIKit

class TravelDetailsVC: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    var travelData:TravelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let travelData = travelData {
            if let imageData = travelData.image {
                imageView.image = UIImage(data: imageData)
            }
            country.text = travelData.countryName
            city.text = travelData.cityName
            year.text = "\(travelData.year)" 
        }
    }



}
