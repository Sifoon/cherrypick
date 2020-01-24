//
//  ViewController.swift
//  TestCherryPick
//
//  Created by Seif Nasri on 24/01/2020.
//  Copyright © 2020 Seif Nasri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var mainViewModel: MainViewModel?
    
    
    var newResp : ServiceResult?{
        didSet {
            refreshUI(newResp!)
        }
    }


    var newError : String?{
        didSet {
            refreshUI( error :newError!)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.mainViewModel = MainViewModel()
        
    }


    
    func refreshUI( _ newResp : ServiceResult){
        print(newResp)
        self.tableView.reloadData()
    }
    
    func refreshUI(  error : String){
        print(error)
    }
}



extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let resCount = newResp?.results else {
            return 0
        }
        return resCount.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                            as! TableCell

        let resultAtIndex = newResp?.results[indexPath.row]
        cell.labelText.text = resultAtIndex?.name.first

        return cell
    }
    
    
   
    
}

extension ViewController : UITableViewDelegate{
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let controller = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailsViewController
           controller.result = newResp?.results[indexPath.row]
           self.present(controller, animated: true, completion: nil)
       }
        
    
}


class TableCell : UITableViewCell {
   
    @IBOutlet var labelText: UILabel!
    @IBOutlet var imageview: UIImageView!
    
}
