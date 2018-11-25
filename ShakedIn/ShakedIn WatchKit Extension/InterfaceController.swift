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
//import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    var isReceiving = false

    @IBAction func didPressSenderRecieverButtonWith(sender: WKInterfaceButton) {
        
        var stateText = "Invite"
        var colour = #colorLiteral(red: 0, green: 0.7501449585, blue: 0.9885035157, alpha: 0.5347816781)
        
        switch isReceiving {
        case false:
            stateText = "Receive"
            colour = #colorLiteral(red: 0, green: 0.7501449585, blue: 0.9885035157, alpha: 0.5347816781)
            isReceiving = true
        case true:
            stateText = "Invite"
            colour = #colorLiteral(red: 0, green: 0.9824226499, blue: 0, alpha: 0.5347816781)
            isReceiving = false
        }
        sender.setTitle(stateText)
        sender.setBackgroundColor(colour)
    }
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
        print("Shook hands!!")
        // didShakeSuccessfully
        
        // TODO: Check if isReceiving
        if (isReceiving) {
            PhoneSessionManager.sharedManager.sendMessage(message: ["isShaking": true as AnyObject], replyHandler: { response in
                if response.description == "SUCCESS" {
                    WKInterfaceDevice.current().play(.success)
                }
            }, errorHandler: nil)
        }
        // TODO: WKConnectivtySession
            // WCSession.isSupported(){ let session = WCSession.defaultSession()
                // session.delegate = self
                // session.activateSession()}
        // TODO: Send and/or receive internal linkedin id accordingly
            // TODO: Create Receiver and Sender objects
            // TODO:
        // TODO: WKConnectivitySession
        // TODO: Haptic Feedback for confirmation
            // (void)playHaptic:(WKHaptic)WKHapticTypeSuccess
        // TODO: Optional: Ting sound and checkmark for confirmation
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
