//
//  CartConfirmationViewController.swift
//  GENOVA
//
//  Created by ITCAN  on 19/04/21.
//

import UIKit

class CartConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //create a new button
                let button = UIButton(type: .custom)
                //set image for button
                button.setImage(UIImage(named: "back"), for: .normal)
                //add function for button
                button.addTarget(self, action: #selector(fbButtonPressed), for: .touchUpInside)
                //set frame
                button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)

                let barButton = UIBarButtonItem(customView: button)
                //assign button to navigationbar
                self.navigationItem.leftBarButtonItem = barButton
    }
    @objc func fbButtonPressed()
    {
        self.navigationController?.popViewController(animated: true)
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
