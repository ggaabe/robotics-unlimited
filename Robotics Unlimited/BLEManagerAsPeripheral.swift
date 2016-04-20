//
//  BLEManagerAsPeripheral.swift
//  Robotics Unlimited
//
//  Created by Gabe Garrett on 4/19/16.
//  Copyright © 2016 Gabe. All rights reserved.
//

//
//  BLE.swift
//  Bluetooth Joint Position
//
//  Created by Gabe Garrett on 4/18/16.
//  Copyright © 2016 Gabe. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation

class BLEHandler : NSObject, CBPeripheralManagerDelegate{
    let characteristicUUID = CBUUID(string: "B4148580-E8E9-48F5-BDAD-691839C7DDFB")
    var holyCharacteristic : CBMutableCharacteristic
    var subscribed : Bool
    override init(){
    holyCharacteristic = CBMutableCharacteristic(type: characteristicUUID, properties: [CBCharacteristicProperties.Read, CBCharacteristicProperties.WriteWithoutResponse, CBCharacteristicProperties.Notify], value: nil, permissions: [CBAttributePermissions.Readable, CBAttributePermissions.Writeable])
    subscribed = false
        super.init()
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        peripheral.stopAdvertising()
        
        //        print("The peripheral state is ", appendNewline: false)
        switch peripheral.state{
        case .PoweredOff:
            print("Powered off")
        case .PoweredOn:
            print("Powered on")
        case .Resetting:
            print("Resetting")
        case .Unauthorized:
            print("Unauthorized")
        case .Unknown:
            print("Unknown")
        case .Unsupported:
            print("Unsupported")
        }
        /* Bluetooth is now powered on */
        
        let serviceUUid = CBUUID(string: "A8BBDEFF-DE0B-4998-AE60-8CFC5A9E7C7B")//CBUUID(NSUUID: uuid)
        let advertisementUUID = CBUUID(string: "5BCDBFD2-9053-4E2E-8A3E-8A01D213D9AA")
        if peripheral.state != .PoweredOn{
            
            print("turn bluetooth on")
            /*          let controller = UIAlertController(title: "Bluetooth",
             message: "Please turn Bluetooth on",
             preferredStyle: .Alert)
             
             controller.addAction(UIAlertAction(title: "OK",
             style: .Default,
             handler: nil))
             
             presentViewController(controller, animated: true, completion: nil)*/
            
        } else {
            print("ADVERTISING SELF")
            
            var servicePosition : CBMutableService
            servicePosition = CBMutableService(type: serviceUUid, primary: true)
           
            servicePosition.characteristics = [holyCharacteristic]
            
            print(servicePosition.characteristics)
            peripheral.addService(servicePosition)
       
            
            let manufacturerData = identifier2!.dataUsingEncoding(
                NSUTF8StringEncoding,
                allowLossyConversion: false)
            
            //let theUUid = CBUUID(NSUUID: uuid)
            
            let dataToBeAdvertised:[String: AnyObject!] = [
                CBAdvertisementDataLocalNameKey : "Robot Arm Peripheral",
                CBAdvertisementDataManufacturerDataKey : manufacturerData,
                CBAdvertisementDataServiceUUIDsKey : [advertisementUUID],
                ]
            
            peripheral.startAdvertising(dataToBeAdvertised)
            
        }
    }
    
    
    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        print("write request")
        print(NSString(data: requests[0].value!, encoding:NSUTF8StringEncoding))
    }
    
    var globalBLEPeripheralList = [CBPeripheralManager]()
    var globalBLECentralList = [CBCentral]()
    var globalBLECharacteristicList = [CBCharacteristic]()
    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
        print("Subscription Beginning")
        globalBLEPeripheralList.append(peripheral)
        globalBLECentralList.append(central)
        globalBLECharacteristicList.append(characteristic)
        print("Central subscribed!")
        
        let angleInfo = "ROBOT ARM JOINT POSITION READY"
        let data = angleInfo.dataUsingEncoding(NSUTF8StringEncoding)
        //let newCharacteristic = CBCharacteristic.self
        peripheral.updateValue(data!, forCharacteristic: holyCharacteristic, onSubscribedCentrals: [globalBLECentralList[0]])
        subscribed = true
    }
    //IT TAKES TIME FOR THE CHARACTERISTIC TO BROADCAST. Be patient mr. gabe. Eat chocolate.
    
    let uuid = NSUUID()
    
    /* The identifier of our beacon is the identifier of our bundle here */
    let identifier2 = NSBundle.mainBundle().bundleIdentifier
    
    /* Made up major and minor versions of our beacon region */
    let major: CLBeaconMajorValue = 1
    let minor: CLBeaconMinorValue = 0
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager,
                                              error: NSError?){
        
        if error == nil{
            print("Successfully started advertising our beacon data")
            
            let message = "Successfully set up your beacon. " +
                "The unique identifier of our service is: \(uuid.UUIDString)"
            
            print(message)
            
            //            let controller = UIAlertController(title: "iBeacon",
            //                                               message: message,
            //                                               preferredStyle: .Alert)
            
            //            controller.addAction(UIAlertAction(title: "OK",
            //                style: .Default,
            //                handler: nil))
            
            //            presentViewController(controller, animated: true, completion: nil)
            print(peripheral)
            
            
        } else {
            print("Failed to advertise our beacon. Error = \(error)")
        }
        
    }
    
}

class BLEManager {
    var peripheralManager : CBPeripheralManager
    var bleHandler : BLEHandler
    //var characterisic : CBMutableCharacteristic
    //var service : CBMutableService
    init(){
        self.bleHandler = BLEHandler()
        self.peripheralManager = CBPeripheralManager(delegate: self.bleHandler, queue: nil)
    }
}
