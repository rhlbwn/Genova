//
//  AddressViewController.swift
//  GENOVA
//
//  Created by ITCAN  on 19/04/21.
//

import UIKit

protocol TextFieldProtocol {
    func save(value: String, index: Int)
}

class TextFieldCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var bottomView: UIView!

    var delegate: TextFieldProtocol!
    
    override func awakeFromNib() {
        inputField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let value = (textField.text ?? "") + string
        delegate.save(value: value, index: self.tag)
        return true
    }
}

class CheckboxCell: UITableViewCell {
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var heading: UILabel!
}

class AddressViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let presenter = AddressViewPresenter()
    private var address = Address()
    private var addressFields = [AddressFields]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CHECKOUT"

        //presenter
        presenter.setViewDelegate(delegate: self)
        presenter.prefetchAddress()

    }
    
    @IBAction func addNewAddress(_ sender: UIButton) {
        self.presenter.didTapAddAddress(address: address)
    }
}

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.addressFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let value = self.addressFields[indexPath.row].rawValue
        switch AddressFields(rawValue: value)! {
        case .verify: return UITableViewCell()
        case .billing, .defaultAddress:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxCell", for: indexPath) as! CheckboxCell
            cell.heading.text = self.addressFields[indexPath.row].rawValue
            return cell
        default: return setCell(indexPath: indexPath, type: AddressFields(rawValue: value)!)
        }
    }
    
    func setCell(indexPath: IndexPath, type: AddressFields) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
        cell.inputField.placeholder = type.rawValue
        cell.tag = indexPath.row
        cell.delegate = self
        switch type {
        case .title: cell.inputField.text = self.address.title
        case .fullName: cell.inputField.text = self.address.fullname
        case .address: cell.inputField.text = self.address.address
        case .pobox: cell.inputField.text = self.address.pobox
        case .city: cell.inputField.text = self.address.city
        case .country: cell.inputField.text = self.address.country
        default: break
        }
        return cell
    }
}

extension AddressViewController: TextFieldProtocol {
    func save(value: String, index: Int) {
        switch self.addressFields[index] {
        case .title: self.address.title = value
        case .fullName: self.address.fullname = value
        case .address: self.address.address = value
        case .pobox: self.address.pobox = value
        case .city: self.address.city = value
        case .country: self.address.country = value
        default: break
        }
    }
}

extension AddressViewController: AddressPresenteProtocol {
    func prefetchAddress(fields: [AddressFields]) {
        self.addressFields = fields
    }
    
    func didTapAddAddress(address: Address) {
        
    }
    
    func gotoOrderPlaced() {
        let vc = self.storyboard?.instantiateViewController(identifier: "SuccessViewController") as! SuccessViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
