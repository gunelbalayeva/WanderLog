//
//  LogoViewController.swift
//  WanderLog
//
//  Created by User on 06.04.25.
//

import UIKit

class LogoViewController: UIViewController {
    
    @IBOutlet weak var logoImage:UIImageView!
    @IBOutlet weak var logoNameLabel:UILabel!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           logoImage.alpha = 0
           logoImage.transform = CGAffineTransform(rotationAngle: .pi)
           logoNameLabel.transform = CGAffineTransform(translationX: 0, y: 50)
           logoNameLabel.alpha = 0
           animateLogo()
       }
       
       func animateLogo() {
           UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseIn], animations: {
               self.logoImage.alpha = 1
               self.logoImage.transform = .identity
           }) { _ in
               self.animateLabel()
           }
       }
       
       func animateLabel() {
           UIView.animate(withDuration: 1.0, delay: 0.5, options: [.curveEaseOut], animations: {
               self.logoNameLabel.transform = .identity
               self.logoNameLabel.alpha = 1
           }) { _ in
               self.navigateToMainViewController()
           }
       }
       
       func navigateToMainViewController() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
               mainVC.modalPresentationStyle = .fullScreen
               self.present(mainVC, animated: true, completion: nil)
           }
       }
    
}
                       
                       
                       
