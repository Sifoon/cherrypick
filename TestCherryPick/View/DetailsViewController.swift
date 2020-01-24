//
//  DetailsViewController.swift
//  TestCherryPick
//
//  Created by Seif Nasri on 24/01/2020.
//  Copyright © 2020 Seif Nasri. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var detailLabelOne: UILabel!
    
    @IBOutlet var detailsLabelTwo: UILabel!
    var result : Result?{
          didSet {
              refreshUI(result!)
          }
      }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func refreshUI (_ result : Result){
        self.detailLabelOne.text = result.location.country
        self.detailsLabelTwo.text = result.location.city
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
