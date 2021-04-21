//
//  AddressModel.swift
//  GENOVA
//
//  Created by Rahul Bawane on 20/04/21.
//

import Foundation

class Address: NSObject {
    var title = String()
    var fullname = String()
    var address = String()
    var pobox = String()
    var city = String()
    var country = String()
    var mobile = String()
    
    override init() {
        super.init()
    }
}
