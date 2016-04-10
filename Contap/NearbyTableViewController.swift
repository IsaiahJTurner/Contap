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
    var rows = 1
    let defaults = NSUserDefaults.standardUserDefaults()
    var notFirstTime:Bool = false
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
        if (notFirstTime == true) {
            let isSuccess = self.defaults.objectForKey("success") as! Bool;
            if isSuccess == true {
                defaults.setBool(false, forKey: "success")
                self.performSegueWithIdentifier("showSuccess", sender: self)
            }
        }
        self.notFirstTime = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        rows = 0
        Alamofire.request(.GET, "http://contap.isaiahjturner.com/connect2", parameters: ["name": self.defaults.objectForKey("name") as! String, "email": self.defaults.objectForKey("email") as! String])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(String(response.result))   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
        let alert = UIAlertController(title: "Intro Sent", message: "Check your email for your intro to Hillary Sanders!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ResultTableViewCell
        cell.name.text = "Hillary Sanders"
        cell.email.text = "hillarys@remax.com"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


}