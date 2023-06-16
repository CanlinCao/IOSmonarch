//
//  ViewController.swift
//  monarch
//
//  Created by Canlin Cao on 4/23/23.
//

import UIKit
import CoreBluetooth



class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate{
    
    @IBAction func bluetoothButton(_ sender: UIButton) {
        if connected == 1{
            sender.backgroundColor = UIColor.blue
            
        }
    }
    
    
    
    
    @IBAction func Button1(_ sender: Any) {
        writeOutgoingValue(data: "{infoTopic: [life]}")
        writeOutgoingValue(data: "{movePart: Wing}")
        print("Butterfly is moving wings and talk about its life cycle")
        
    }
    
    @IBAction func Button2(_ sender: Any) {
        writeOutgoingValue(data: "{movePart: Legs}")
        writeOutgoingValue(data: "{movePart: Wing}")
        print("Butterfly is moving its legs and wings")
    }
    
    
    @IBAction func Button3(_ sender: Any) {
        writeOutgoingValue(data: "{infoTopic: [diet]}")
        writeOutgoingValue(data: "{infoTopic: [migration]}")
        
        print("Butterfly is talking about its diet and migration pattern")
    }
    
    
    @IBAction func Button4(_ sender: Any) {
        writeOutgoingValue(data: "{infoTopic: [status]}")
        print("Butterfly is talking about its status")
    }
    
    @IBAction func Button5(_ sender: Any) {
        writeOutgoingValue(data: "{movePart: Wing}")
        print("Butterfly is moving its wings")
    }
    
    @IBAction func Button6(_ sender: Any) {
        writeOutgoingValue(data: "{movePart: Legs}")
        print("butterfly is moving its leg")
    }
    
    
    
    @IBAction func Button9(_ sender: Any) {
        writeOutgoingValue(data: "{infoTopic: [life]}")
        print("Butterfly is talking about its life cycle")
    }
    
    
    @IBAction func Button10(_ sender: Any) {
        writeOutgoingValue(data: "{infoTopic: [status]}")
        print("Butterfly is talking about its status")
    }
    
    
    @IBAction func Button11(_ sender: Any) {
        writeOutgoingValue(data: "{infoTopic: [diet]}")
        print("Butterfly is talking about its diet")
    }
    
    
    @IBAction func Button12(_ sender: Any) {
        writeOutgoingValue(data: "{infoTopic: [migration]}")
        print("Butterfly is talking about its migration")
    }
    
    
    private var centralManager: CBCentralManager!
    private var bluePeripheral: CBPeripheral!
    
    
    private var txCharacteristic: CBCharacteristic!
    private var rxCharacteristic: CBCharacteristic!
    private var connected = 0
    
    func bluetoothScan() -> Void {
        centralManager?.scanForPeripherals(withServices:[CBUUIDs.BLEService_UUID])
        connected = 1
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
       bluePeripheral.discoverServices([CBUUIDs.BLEService_UUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            print("*******************************************************")

            if ((error) != nil) {
                print("Error discovering services: \(error!.localizedDescription)")
                return
            }
            guard let services = peripheral.services else {
                return
            }
            //We need to discover the all characteristic
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
            print("Discovered Services: \(services)")
        }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        bluePeripheral = peripheral
        bluePeripheral.delegate = self

        print("Peripheral Discovered: \(peripheral)")
        print("Peripheral name: \(peripheral.name)")
        print ("Advertisement Data : \(advertisementData)")
            
        centralManager?.connect(bluePeripheral!, options: nil)
    }
    
    func writeOutgoingValue(data: String){
          
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        
        if let bluePeripheral = bluePeripheral {
              
          if let txCharacteristic = txCharacteristic {
                  
            bluePeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
              }
          }
      }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .poweredOff:
                print("Powered OFF")
            case .poweredOn:
                print("Powered ON")
                bluetoothScan()
            case .unsupported:
                print("UNSUPPORTED")
            case .unauthorized:
                print("UNAUTHROIZED")
            case .unknown:
                print("UNKNOWN")
            case .resetting:
                print("RESETTING")
            
            @unknown default:
                print("ERROR")
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }


}

extension ViewController: CBPeripheralManagerDelegate {

  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    switch peripheral.state {
    case .poweredOn:
        print("Peripheral Is Powered On.")
    case .unsupported:
        print("Peripheral Is Unsupported.")
    case .unauthorized:
    print("Peripheral Is Unauthorized.")
    case .unknown:
        print("Peripheral Unknown")
    case .resetting:
        print("Peripheral Resetting")
    case .poweredOff:
      print("Peripheral Is Powered Off.")
    @unknown default:
      print("Error")
    }
  }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        var characteristicASCIIValue = NSString()

        guard characteristic == rxCharacteristic,

        let characteristicValue = characteristic.value,
        let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }

        characteristicASCIIValue = ASCIIstring

        print("Value Recieved: \((characteristicASCIIValue as String))")
    }
}
