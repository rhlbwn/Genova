//
//  SuccessViewController.swift
//  GENOVA
//
//  Created by ITCAN  on 19/04/21.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var backToHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        backToHomeButton.layer.borderWidth = 2
        backToHomeButton.layer.borderColor = UIColor.white.cgColor
    }
    

    @IBAction func backToHome(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
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
