//
//  ViewController.swift
//  DevicesDatabase
//
//  Created by Vladimir on 26/02/2020.
//  Copyright © 2020 Embler. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    //Mark: Properties
    @IBOutlet weak var lblConnectionStatus: UILabel!
    @IBAction func btnAddDevice(_ sender: UIButton) {
    }
    @IBAction func btnDeleteDevice(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         Auth.auth().signInAnonymously() { (authResult, error) in
            
            if error != nil {
                self.lblConnectionStatus.text = "Unable to connect"
                self.lblConnectionStatus.textColor = .red
                print("!!!!!!!!!!!!!!!!!!Error")
                print(error!.localizedDescription)
            } else {
                self.lblConnectionStatus.text = "Connected"
                self.lblConnectionStatus.textColor = .green
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Connected")
            }
            
        }

    }


}

