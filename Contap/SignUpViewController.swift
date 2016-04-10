//
//  SignUpViewControlle.swift
//  Contap
//
//  Created by Alyssa McDevitt on 4/9/16.
//  Copyright © 2016 Alyssa McDevitt. All rights reserved.
//

import UIKit

class SignUpViewControler: UIViewController {
    var defaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidAppear(animated: Bool) {
        self.name.becomeFirstResponder()
    }
    @IBAction func autofillData(sender: AnyObject) {
        if let name = defaults.objectForKey("name") as? String {
            self.name.text = name
        }
        if let email = defaults.objectForKey("email") as? String {
            self.email.text = email
        }
        if let username = defaults.objectForKey("username") as? String {
            self.username.text = username
        }
        if let password = defaults.objectForKey("password") as? String {
            self.password.text = password
        }
    }
    @IBAction func saveData(sender: AnyObject) {
        defaults.setObject(self.name.text, forKey: "name")
        defaults.setObject(self.email.text, forKey: "email")
        defaults.setObject(self.username.text, forKey: "username")
        defaults.setObject(self.password.text, forKey: "password")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

