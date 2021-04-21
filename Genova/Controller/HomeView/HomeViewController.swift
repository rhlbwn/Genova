//
//  HomeViewController.swift
//  GENOVA
//
//  Created by ITCAN  on 18/04/21.
//

import UIKit

class GenderCollectionCell: UICollectionViewCell {
    @IBOutlet weak var genderLabel: UILabel!
}

class ProductCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        bgView.shadow()
    }
    
    @IBAction func cartAction(_ sender: UIButton) {
    }
    
    func setupCell(product: Product) {
        self.nameLabel.text = product.name
        self.amountLabel.text = product.cost
        self.typeLabel.text = product.type
        self.discountLabel.text = product.discount + " Off"
        self.productImageView.image = UIImage(named: product.image)
        if product.favourite {
            self.favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.favouriteButton.tintColor = .red
        } else {
            self.favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.favouriteButton.tintColor = .black
        }
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var genderCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!

    private let presenter = HomeViewPresenter()
    private var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "G E N O V A"
        // Do any additional setup after loading the view.
        
        //presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genderCollectionView  {
            return 4
        } else {
            return self.products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genderCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenderCollectionCell", for: indexPath) as! GenderCollectionCell
            var gender = ""
            switch indexPath.item {
            case 0: gender = "Mens"
            case 1: gender = "Womens"
            case 2: gender = "Unisex"
            case 3: gender = "Western"
            default: gender = "Indian"
            }
            cell.genderLabel.text = gender
            cell.genderLabel.textColor = indexPath.item == 0 ? .black : .gray
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
            cell.setupCell(product: products[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productCollectionView {
            return CGSize(width: (collectionView.bounds.width/2)-5, height: 280)
        } else {
            return CGSize(width: collectionView.bounds.width/3, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didTapProduct(product: products[indexPath.item])
    }
}

extension HomeViewController: HomePresenterDelegate {
    func gotoCheckout(product: Product) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddressViewController") as! AddressViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentProducts(products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
    }
}

extension UIView {
    func shadow() {
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.masksToBounds = false
    }
}

