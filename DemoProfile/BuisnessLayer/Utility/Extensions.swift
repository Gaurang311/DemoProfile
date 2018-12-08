//
//  Extensions.swift
//  DemoProfile
//
//  Created by Gaurang Lathiya on 09/12/18.
//  Copyright © 2018 Gaurang Lathiya. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

extension UIAlertAction {
    convenience init(title: String?, style: UIAlertAction.Style, image: UIImage, handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: title, style: style, handler: handler)
        self.actionImage = image
    }
    
    convenience init?(title: String?, style: UIAlertAction.Style, imageNamed imageName: String, handler: ((UIAlertAction) -> Void)? = nil) {
        if let image = UIImage(named: imageName) {
            self.init(title: title, style: style, image: image, handler: handler)
        } else {
            return nil
        }
    }
    
    var actionImage: UIImage {
        get {
            return self.value(forKey: "image") as? UIImage ?? UIImage()
        }
        set(image) {
            self.setValue(image, forKey: "image")
        }
    }
}

extension UIViewController {
    
    func getNavigationBarHeight() -> CGFloat {
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        var navBarHeight: CGFloat = 44.0
        if let navcontroller = self.navigationController {
            navBarHeight = navcontroller.navigationBar.frame.height
        }
        return statusBarHeight + navBarHeight
    }
    
    func topMostViewController() -> UIViewController {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
       // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews
            {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController()
                    }
                }
            }
            return self
        }
    }
    
    func showAlert(withTitle title: String, message: String) {
        DispatchQueue.main.async {
            let uiAlertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle:.alert)
            
            uiAlertController.addAction(
                UIAlertAction.init(title: "OK", style: .default, handler: { (UIAlertAction) in
                    uiAlertController.dismiss(animated: true, completion: nil)
                }))
            self.topMostViewController().present(uiAlertController, animated: true, completion: nil)
        }
    }
    
    func disableSwipeLeftToBack() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func enableSwipeLeftToBack() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    func setAppThemeGreenNavigationBar() {
        // Common setting for transparent navigation bar
        UINavigationBar.appearance().barTintColor = UIColor.white
        // Set button color
        UINavigationBar.appearance().tintColor = UIColor.black
    }
    
    func setTransparentNavigationBar() {
        // Common setting for transparent navigation bar
        UINavigationBar.appearance().barTintColor = UIColor.clear
        // Set button color
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}
