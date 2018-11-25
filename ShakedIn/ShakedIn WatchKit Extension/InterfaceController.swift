//
//  InterfaceController.swift
//  ShakedIn WatchKit Extension
//
//  Created by Nafeh Shoaib on 2018-11-25.
//  Copyright © 2018 nafehshoaib. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion
import Alamofire
import CoreBluetooth

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    var shaker: WatchShaker = WatchShaker(shakeSensibility: .shakeSensibilitySoft, delay: 0.2)
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        shaker.delegate = self
        shaker.start()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController: WatchShakerDelegate
{
    func watchShaker(_ watchShaker: WatchShaker, didShakeWith sensibility: ShakeSensibility) {
        print("HELLO WOHAHDSDO")
    }
    
    func watchShakerDidShake(_ watchShaker: WatchShaker) {
        print("YOU HAVE SHAKEN YOUR ⌚️⌚️⌚️")
    }
    
    func watchShaker(_ watchShaker: WatchShaker, didFailWith error: Error) {
        print(error.localizedDescription)
    }
    
    private func sendRequestToLinkedInWith(linkedinUserID: String, myUserID: String) {
        let parameters = ["": ""]
        Alamofire.request("https://api.linkedin.com/v2/invitations", method: .post, parameters: parameters).responseJSON { response in
            print(response)
        }
    }
}
