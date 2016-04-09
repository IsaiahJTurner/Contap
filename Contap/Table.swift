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

class Table: UIViewController, UITableViewDelegate{

    let myarray = ["item1", "item2", "item3"]
    
    
    override func viewDidLoad() {
        viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myarray.count
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath)
        cell.textLabel?.text = myarray[indexPath.item]
        return cell
    }
    
    func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


}