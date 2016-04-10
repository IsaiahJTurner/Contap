//
//  table.swift
//  Contap
//
//  Created by Alyssa McDevitt on 4/9/16.
//  Copyright © 2016 Alyssa McDevitt. All rights reserved.
//


//look i lterally have no idea what i'm doing pls help 
import Foundation
import UIKit

import Alamofire

class NearbyTableViewController: UITableViewController {
    @IBOutlet var tableview: UITableView!
    let nearby = []
    let defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://contap.isaiahjturner.com/connect", parameters: ["name": defaults.objectForKey("name") as! String, "email": defaults.objectForKey("email") as! String])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(String(response.result))   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearby.count
    }
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ResultTableViewCell
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


}