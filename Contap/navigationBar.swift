//
//  navigationBar.swift
//  Contap
//
//  Created by Alyssa McDevitt on 4/9/16.
//  Copyright © 2016 Alyssa McDevitt. All rights reserved.
//

import Foundation
import UIKit


class navigationBar: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

