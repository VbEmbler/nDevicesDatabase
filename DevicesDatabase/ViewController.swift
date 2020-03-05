//
//  ViewController.swift
//  DevicesDatabase
//
//  Created by Vladimir on 26/02/2020.
//  Copyright © 2020 Embler. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper
import RxSwift
import RxCocoa
import RxFirebase


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //Mark: Properties

    let refDevices = Database.database().reference().child("devices")
    var userAuthId: String!
    var devicesList = [DeviceData]()
    let dispoaeBag = DisposeBag()
 
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var ConnectionStatusLabel: UILabel!
    @IBOutlet weak var devicesTableView: UITableView!
    
    @IBAction func AddDeviceButton(_ sender: UIButton) {
        
        addDevise()
        actionLabel.text = "Device added"
        
    }
    
    @IBAction func DeleteDeviceButton(_ sender: UIButton) {
        
        deleteDevice()
        actionLabel.text = "Device deleted"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authInDatabse()
        getDevices()
        
    }
    
    
    //Mark: Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let deviceCell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! DeviceTableViewCell
        let device: DeviceData
        device = devicesList[indexPath.row]
        
        deviceCell.userIdLabel.text! = "User ID: \(device.userId ?? "Empty")"
        deviceCell.deviceNameLabel.text! = "Device Name: \(device.deviceName ?? "Empty")"
        deviceCell.modelLabel.text! = "Model: \(device.deviceModel ?? "Empty")"
        deviceCell.osVersionLabel.text! = "OS Version \(device.osVersion ?? "Empty")"

        return deviceCell
    }
    
    func getDevices(){
        
        refDevices.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.devicesList.removeAll()
                
                for devices in snapshot.children.allObjects as! [DataSnapshot]{
                    let deviceObject = devices.value as? [String: AnyObject]
                    let device = Mapper<DeviceData>().map(JSON: deviceObject!)
                    self.devicesList.append(device!)
                }
                self.devicesTableView.reloadData()
            }
        })
        
    }
    
    func authInDatabse () {
        
        let auth = Auth.auth()
        auth.rx.signInAnonymously().asObservable()
            .subscribe(onNext: {(authResult) in
            //print(authResult)
            self.ConnectionStatusLabel.text = "Connected "
            self.ConnectionStatusLabel.textColor = .green
            self.userAuthId = authResult.user.uid

        }, onError:  {(error) in
            //print("error")
            self.ConnectionStatusLabel.text = "Unable to connect"
            self.ConnectionStatusLabel.textColor = .red
        },onCompleted: {
            }).disposed(by: dispoaeBag)
        
        //Database.database().reference()
        /*Auth.auth().signInAnonymously() { (authResult, error) in

            if error != nil {
                self.ConnectionStatusLabel.text = "Unable to connect"
                self.ConnectionStatusLabel.textColor = .red
                //print("!Error")
                print(error!.localizedDescription)
            } else {
                self.ConnectionStatusLabel.text = "Connected "
                self.ConnectionStatusLabel.textColor = .green
                self.userAuthId = authResult!.user.uid
            }
            
        }*/
        
    }
    
    func addDevise () {
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
    
    func deleteDevice() {
        
        refDevices.child(userAuthId).setValue(nil)
    }

}

