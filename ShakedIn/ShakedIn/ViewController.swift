//
//  ViewController.swift
//  ShakedIn
//
//  Created by Nafeh Shoaib on 2018-11-25.
//  Copyright © 2018 nafehshoaib. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    @IBOutlet weak var myNameTextField: UITextField!
    @IBOutlet weak var myLinkedInUserNameTextField: UITextField!
    
    @IBAction func didPressSaveButton(_ sender: UIButton) {
        myLinkedInUserName = myLinkedInUserNameTextField.text
        myName = myNameTextField.text
    }
    
    var myLinkedInUserName: String? = "";
    var myName: String? = "";
    var connectionLinkedInName = "";
    var connections: [String] = [];
    
    var SERVICE_UUID = "b24216e7-2295-4952-bd61-f7d7da47cb19"
    
    var centralManager: CBCentralManager?
    var peripheralManager: CBPeripheralManager?
    
    let WR_UUID = CBUUID(string: "b24216e7-2295-4952-bd61-f7d7da47cb19")
    let WR_PROPERTIES: CBCharacteristicProperties = .write
    let WR_PERMISSIONS: CBAttributePermissions = .writeable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public func runBLEService() {
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
    }
}

extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == .poweredOn) {
            
            //here we scan for the devices with a UUID that is specific to our app, which filters out other BLE devices.
            self.centralManager?.scanForPeripherals(withServices: [CBUUID(string: SERVICE_UUID)], options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // Here we can read peripheral.identifier as UUID, and read our advertisement data by the key CBAdvertisementDataLocalNameKey.
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
    }
}

extension ViewController: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        if (peripheral.state == .poweredOn){
            
            let serialService = CBMutableService(type: CBUUID(string: SERVICE_UUID), primary: true)
            let writeCharacteristics = CBMutableCharacteristic(type: WR_UUID,
                                                               properties: WR_PROPERTIES, value: nil,
                                                               permissions: WR_PERMISSIONS)
            serialService.characteristics = [writeCharacteristics]
            peripheralManager?.add(serialService)
            
            let advertisementData = String(format: "%@", myName!)
            peripheralManager?.startAdvertising([CBAdvertisementDataServiceUUIDsKey:[SERVICE_UUID],
                                                CBAdvertisementDataLocalNameKey: advertisementData])
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
        for request in requests {
            if let value = request.value {
                
                // linkedIn Name
                let messageText = String(data: value, encoding: String.Encoding.utf8)
                connectionLinkedInName = messageText!
                connections.append(connectionLinkedInName)
            }
            self.peripheralManager?.respond(to: request, withResult: .success)
        }
    }
}

extension ViewController : CBPeripheralDelegate {
    
    func peripheral( _ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral( _ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        for characteristic in service.characteristics! {
            
            let characteristic = characteristic as CBCharacteristic
            if (characteristic.uuid.isEqual(WR_UUID)) {
                if let messageText = myLinkedInUserName {
                    let data = messageText.data(using: .utf8)
                    peripheral.writeValue(data!, for: characteristic, type: CBCharacteristicWriteType.withResponse)
                }
            }
            
        }
    }
}
