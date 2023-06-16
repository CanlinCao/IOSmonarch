//
//  CBUUIDs.swift
//  monarch
//
//  Created by Canlin Cao on 6/7/23.
//

import Foundation
import CoreBluetooth


struct CBUUIDs{
    static let kBLEService_UUID = "6FCAE9D6-2A83-59A6-B3CE-CDF5F6FAC2B2"
    static let kBLE_Characteristic_uuid_Tx = "6FCAE9D6-2A83-59A6-B3CE-CDF5F6FAC2B2"
    static let kBLE_Characteristic_uuid_Rx = "6FCAE9D6-2A83-59A6-B3CE-CDF5F6FAC2B2"

    static let BLEService_UUID = CBUUID(string: kBLEService_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)
    
    
    
    
}
