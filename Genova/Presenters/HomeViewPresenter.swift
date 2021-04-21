//
//  HomeViewPresenter.swift
//  GENOVA
//
//  Created by ITCAN  on 18/04/21.
//

import UIKit

protocol HomePresenterDelegate: AnyObject {
    func presentProducts(products: [Product])
    func presentAlert(title: String, message: String)
    func gotoCheckout(product: Product)
}

typealias PresenterDelegate = HomePresenterDelegate & UIViewController

class HomeViewPresenter {
    weak var presenterDelegate: PresenterDelegate?
    
    public func getProducts() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "Products", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                print(jsonData)
                do {
                    let products = try JSONDecoder().decode([Product].self, from: jsonData)
                    self.presenterDelegate?.presentProducts(products: products)
                } catch {
                    print("decode error")
                }
            }
        } catch {
            print(error)
        }
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.presenterDelegate = delegate
    }
    
    public func didTapProduct(product: Product) {
        self.presenterDelegate?.gotoCheckout(product: product)
    }
}
