//
//  PhoneSessionManager.swift
//  ShakedIn WatchKit Extension
//
//  Created by Nafeh Shoaib on 2018-11-25.
//  Copyright © 2018 nafehshoaib. All rights reserved.
//

import WatchConnectivity

class PhoneSessionManager: NSObject, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    static let sharedManager = PhoneSessionManager()
    
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    
    func startSession() {
        session?.delegate = self
        session?.activate()
    }
    
}

// MARK: Application Context
extension PhoneSessionManager {
    
}


// MARK: Interactive Messaging
extension PhoneSessionManager {
    
    // App has to be reachable for live messaging.
    private var validReachableSession: WCSession? {
        if let session = session, session.isReachable {
            return session
        }
        return nil
    }
    
    // Sender
    func sendMessage(message: [String : AnyObject], replyHandler: (([String : AnyObject]) -> Void)? = nil,
                     errorHandler: ((NSError) -> Void)? = nil) {
        validReachableSession?.sendMessage(message, replyHandler: replyHandler as! ([String : Any]) -> Void, errorHandler: errorHandler as! (Error) -> Void)
    }
    
}
