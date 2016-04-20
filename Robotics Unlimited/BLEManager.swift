////
////  BLEManager.swift
////  Robotics Unlimited
////
////  Created by Gabe Garrett on 4/18/16.
////  Copyright © 2016 Gabe. All rights reserved.
////
//
//import Foundation
//import CoreBluetooth
//
//class BLEManager {
//    var centralManager : CBCentralManager
//    var bleHandler : BLEHandler
//    init(){
//        self.bleHandler = BLEHandler()
//        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue: nil)
//    }
//}
//
//class BLEHandler : NSObject, CBCentralManagerDelegate{
//    override init(){
//        super.init()
//    }
//    let serviceUUid = CBUUID(string: "A8BBDEFF-DE0B-4998-AE60-8CFC5A9E7C7B")//CBUUID(NSUUID: uuid)
//    let advertisementUUID = CBUUID(string: "5BCDBFD2-9053-4E2E-8A3E-8A01D213D9AA")
//    let characteristicUUID = CBUUID(string: "B4148580-E8E9-48F5-BDAD-691839C7DDFB")
//    
//    func centralManagerDidUpdateState(central: CBCentralManager) {
//        switch(central.state){
//        case .Unsupported:
//            print("BLE is Unsupported")
//        case .Unauthorized:
//            print("BLE is Unauthorized")
//        case .Unknown:
//            print("BLE is unknown")
//        case .Resetting:
//            print("BLE is resetting")
//        case .PoweredOff:
//            print("BLE is powered off")
//        case .PoweredOn:
//            print("BLE is powered on")
//            print("Start scanning")
//            central.scanForPeripheralsWithServices(nil, options: nil)
//        }
//    }
//    
//    var peripherals = [CBPeripheral]()
//    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
//        print(peripheral.name)
//        if((peripheral.name?.lowercaseString) == ("gabe’s macbook air")){ //change to NSUUID
//            print("FOUND MACBOOK!")
//            peripherals.append(peripheral)
//            central.connectPeripheral(peripherals[0], options: nil)
//        }
//        print("Advertisement data: " + String(advertisementData))
//        print("Services: " + String(peripheral.services))
//       /* if peripheral.services != nil{
//            for service in peripheral.services!{
//                if service.characteristics != nil{
//                    for characteristic in service.characteristics!{
//                        print(characteristic)
//                    }
//                }
//            }
//        }*/
//       // central.retrievePeripheralsWithIdentifiers(macbookIdentifiers)
//        //print(peripherals)
//    }
//
//    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
//        print("Failed to connect \(peripheral) cause of \(error)")
//    }
//    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
//        print("CONNECTED to \(peripheral)")
//        //central.stopScan()
//        peripherals[0].discoverServices([serviceUUid])
//        print("CONNECTED SERVICES" + String(peripheral.services))
//        if peripheral.services != nil{
//            print("Services is not nil")
//            for service in peripherals[0].services!{
//                
//                peripherals[0].discoverCharacteristics(nil, forService: service)
//                if service.characteristics != nil{
//                    for characteristic in service.characteristics!{
//                        print("C H A R A C T E R I S T I C S OMG")
//                        print(characteristic)
//                        let newValue = "ROBOT DATA"
//                        let data = newValue.dataUsingEncoding(NSUTF8StringEncoding)
//                        //peripherals[0].writeValue(data!, forCharacteristic: characteristic, type: CBCharacteristicWriteType.WithResponse)
//                        peripherals[0].setNotifyValue(true, forCharacteristic: characteristic)
//                        peripherals[0].writeValue(data!, forCharacteristic: characteristic, type: CBCharacteristicWriteType.WithResponse)
//                        print("Wrote to papa")
//                    }
//                }else{
//                    print("characteristics is nil")
//                }
//            }
//        }else{
//            print("services currently nil")
//        }
//    }
//    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError!) {
//        print("S E R V I C E S: \(peripheral.services) and error\(error)")
//        if let services = peripheral.services {
//            for service in services {
//                peripheral.discoverCharacteristics(nil, forService: service)
//            }
//        }
//    }
//    
//    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService!, error: NSError!)
//    {
//        print("peripheral:\(peripheral) and service:\(service)")
//        for characteristic in service.characteristics!
//        {
//            print("Found characteristic!")
//            peripheral.setNotifyValue(true, forCharacteristic: characteristic)
//            print("Found characteristic!")
//            print(characteristic)
//        }
//    }
//    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?)
//    {
//        print("characteristic changed:\(characteristic)")
//    }
//}