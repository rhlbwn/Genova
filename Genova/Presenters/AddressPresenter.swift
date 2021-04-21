//
//  AddressPresenter.swift
//  GENOVA
//
//  Created by Rahul Bawane on 20/04/21.
//
import UIKit
import Foundation

enum AddressFields: String {
    case title = "Title"
    case fullName = "Full Name"
    case address = "Address"
    case pobox = "P.O. Box"
    case city = "City"
    case country = "Country"
    case verify = "Verify"
    case billing = "Use same address for billing"
    case defaultAddress = "Use as default address"
}

protocol AddressPresenteProtocol: AnyObject {
    func prefetchAddress(fields: [AddressFields])
    func didTapAddAddress(address: Address)
    func gotoOrderPlaced()
}

//typealias AddressPresenterDelegate = AddressPresenteProtocol & UIViewController

class AddressViewPresenter: UIViewController {
    weak var presenterDelegate: AddressPresenteProtocol?
    
    public func setViewDelegate(delegate: AddressPresenteProtocol) {
        self.presenterDelegate = delegate
    }
    
    public func prefetchAddress() {
        let fields = [AddressFields.title, .fullName, .address, .pobox, .city, .country, .billing, .defaultAddress]
        self.presenterDelegate?.prefetchAddress(fields: fields)
    }
    
    public func didTapAddAddress(address: Address) {
        self.presenterDelegate?.didTapAddAddress(address: address)
        self.presenterDelegate?.gotoOrderPlaced()
    }
}
