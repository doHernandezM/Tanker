//
//  File.swift
//  
//
//  Created by Dennis Hernandez on 8/24/21.
//

import Foundation
import SwiftyPi
//MARK:Tank

var handler: CompletionHandler?

public struct TankerState {
    var statusLED = true
    var misterOn = false
    var lightBlue = false
    var lightWhite = false
    
    var misterButtonDown = false
    var lightButtonDown = false
}

public class Tanker {
    //To keeps things easy we are making this static and public singleton
    static public var main: Tanker? = nil
    
    //Poller tank devices for status
    var poller: Thread? = nil

    //MARK:Accessories
    let statusLED: SwiftyPiDevice
    
    let misterButton: SwiftyPiDevice
    
    let misterRelay: SwiftyPiDevice
    let filterRelay: SwiftyPiDevice
    
    let lightButton: SwiftyPiDevice
    let blueLightRelay: SwiftyPiDevice
    let whiteLightRelay: SwiftyPiDevice
    
    public var state = TankerState()
    
    var firstCycle = true
    
    var tankerRunning = false
    public func active(isActive: Bool){tankerRunning = isActive}
    
    //MARK:INIT
    public init() {
        
        statusLED = SwiftyPiDevice.init(gpioPinName:"P4", theType: .statusLED)
        
        misterButton = SwiftyPiDevice.init(gpioPinName:"P17", theType: .button)//
        lightButton = SwiftyPiDevice.init(gpioPinName:"P27", theType: .button)
        
        misterRelay = SwiftyPiDevice.init(gpioPinName:"P5", theType: .relay)
        filterRelay = SwiftyPiDevice.init(gpioPinName:"P6", theType: .relay)
        blueLightRelay = SwiftyPiDevice.init(gpioPinName:"P13", theType: .relay)
        whiteLightRelay = SwiftyPiDevice.init(gpioPinName:"P19", theType: .relay)
        
    }
     
    public var tankerState : SwiftyPiMode {
        get {
            return tankerRunning ? .high : .off
        }
        set(newStatus){
            self.tankerRunning = (newStatus == SwiftyPiMode.off) ? false : true
            self.tankerRunning ? poller?.start() : poller?.cancel()
            print("isRunning:\(self.tankerRunning)")
        }
    }
    
    public var misterState : SwiftyPiMode {
        get {
            return misterRelay.mode
        }
        set(newState){
            misterRelay.mode = newState
            print("newStatus:\(newState)")
        }
    }
    
}
