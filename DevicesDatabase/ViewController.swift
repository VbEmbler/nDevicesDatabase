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

    let refDevices = Database.database().reference().child("devices")
    var userAuthId: String!
    
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblConnectionStatus: UILabel!
    @IBOutlet weak var tblViewDevices: UITableView!
    @IBAction func btnAddDevice(_ sender: UIButton) {
        addDevise()
    }
    @IBAction func btnDeleteDevice(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //Database.database().reference()
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            
            if error != nil {
                self.lblConnectionStatus.text = "Unable to connect"
                self.lblConnectionStatus.textColor = .red
                print("!!!!!!!!!!!!!!!!!!Error")
                print(error!.localizedDescription)
            } else {
                self.lblConnectionStatus.text = "Connected "
                self.lblConnectionStatus.textColor = .green
                
                self.lblUserId.text = " \(authResult?.user.uid ?? "anon")"
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Connected")
                print(authResult!.user.uid)
                self.userAuthId = authResult!.user.uid
            }
            
        }
        
        
        //referenceDevices.setValue("Hi")

    }
    
    
    func addDevise (){
        //let key = refDevices.childByAutoId().key
        //let newDevice = refDevices.childByAutoId()
        let device = [//"id": key,
                      "userID": self.userAuthId,
                      "deviceName": UIDevice.current.name,
                      "deviceModel": UIDevice.current.model,
                      "os_version": UIDevice.current.systemVersion
                        ]
        refDevices.child(self.userAuthId).setValue(device)
    }


}

