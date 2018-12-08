//
//  SplashScreen.swift
//  DemoProfile
//
//  Created by Gaurang Lathiya on 09/12/18.
//  Copyright © 2018 Gaurang Lathiya. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableSwipeLeftToBack()
        self.perform(#selector(moveToLoginScreen), with: nil, afterDelay: 0.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func moveToLoginScreen() {
        // Animation for fade
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        
        if let loginScreenObj: LoginScreen = self.storyboard?
            .instantiateViewController(withIdentifier: String(describing: LoginScreen.self)) as? LoginScreen  {
            self.navigationController?.pushViewController(loginScreenObj, animated: true)
        }
    }
}
