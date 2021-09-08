//
//  File.swift
//  
//
//  Created by Dennis Hernandez on 8/24/21.
//

import Foundation

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
    //To keeps things easy we are making this static and publi singleton
    static public var main: Tanker? = nil
    
    //Poller tank devices for status
    var poller: Thread? = nil

    //MARK:Accessories
    let statusLED: TankerAccessory
    
    let misterButton: TankerAccessory
    
    let misterRelay: TankerAccessory
    let filterRelay: TankerAccessory
    
    let lightButton: TankerAccessory
    let blueLightRelay: TankerAccessory
    let whiteLightRelay: TankerAccessory
    
    public var state = TankerState()
    
    var firstCycle = true
    
    var tankerRunning = false
    public func active(isActive: Bool){tankerRunning = isActive}
    
    //MARK:INIT
    public init() {
        
        statusLED = TankerAccessory.init(thePin:"P4", theType: .statusLED)
        
        misterButton = TankerAccessory.init(thePin:"P17", theType: .button)//
        lightButton = TankerAccessory.init(thePin:"P27", theType: .button)
        
        misterRelay = TankerAccessory.init(thePin:"P5", theType: .relay)
        filterRelay = TankerAccessory.init(thePin:"P6", theType: .relay)
        blueLightRelay = TankerAccessory.init(thePin:"P13", theType: .relay)
        whiteLightRelay = TankerAccessory.init(thePin:"P19", theType: .relay)
        
    }
     
    public var tankerState : TankerMode {
        get {
            return tankerRunning ? .high : .off
        }
        set(newStatus){
            self.tankerRunning = (newStatus == TankerMode.off) ? false : true
            self.tankerRunning ? poller?.start() : poller?.cancel()
            print("isRunning:\(self.tankerRunning)")
        }
    }
    
    public var misterState : TankerMode {
        get {
            return misterRelay.mode
        }
        set(newState){
            misterRelay.mode = newState
            print("newStatus:\(newState)")
        }
    }
    
}
