//
//  TapViewController.swift
//  Contap
//
//  Created by Isaiah Turner on 4/9/16.
//  Copyright © 2016 Alyssa McDevitt. All rights reserved.
//

import UIKit
import Alamofire

class TapViewController: UIViewController {
    var defaults = NSUserDefaults.standardUserDefaults()
    var goAway:Bool = false;

    @IBAction func startTimer(sender: AnyObject) {
        if (goAway) {
            return;
        }
        goAway = true;
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            Alamofire.request(.GET, "http://contap.isaiahjturner.com/connect", parameters: ["name": self.defaults.objectForKey("name") as! String, "email": self.defaults.objectForKey("email") as! String])
                .responseJSON { response in
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)     // server data
                    print(String(response.result))   // result of response serialization
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                    self.defaults.setBool(true, forKey: "success")
                    self.dismissViewControllerAnimated(true, completion: {})
            }
            }
    }
    
    @IBAction func close(sender: AnyObject) {
        defaults.setBool(false, forKey: "success")
        self.dismissViewControllerAnimated(true, completion: {})
    }
}