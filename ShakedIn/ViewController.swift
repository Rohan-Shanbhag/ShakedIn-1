//
//  ViewController.swift
//  ShakedIn
//
//  Created by Nafeh Shoaib on 2018-11-24.
//  Copyright © 2018 nafehshoaib. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    let parameters = [
        "invitee": "urn:li:email:test@linkedin.com"
    ];
    
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func LinkedinRequest(_ sender: UIButton) {
        Alamofire.request("https://httpbin.org/get", method: .post, parameters: parameters).responseJSON { response in
            print(response)
        }
    }
}



