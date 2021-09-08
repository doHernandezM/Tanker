//
//  File.swift
//  
//
//  Created by Dennis Hernandez on 8/29/21.
//

import Foundation

//MARK:TankerAccessoryController
public class TankerController {
    var firstButtonPressed: TankerAccessory?
    var secondButtonPressed: TankerAccessory?
    var lastState: TankerState? = nil
    
    public init() {
        Tanker.main = Tanker()
    }
    
    public func start() {
        self.startPoller()
    }
    
    //MARK:panelUI
    let debouncer = TankerTimer(timeInterval: 0.25, loops: nil)
    
    func lightSwitchPressed(theSwitch:TankerAccessory) {
        //            print(state)
        debouncer.handler = {
            //            print(theSwitch.type.rawValue)
            
            if (theSwitch.int == 1) {
                theSwitch.timer?.interval()
                
                Tanker.main?.statusLED.int = 1
                
                Tanker.main?.blueLightRelay.int = 1
                Tanker.main?.whiteLightRelay.int = 1
            } else {
                Tanker.main?.statusLED.int = 0
                
                Tanker.main?.blueLightRelay.int = 0
                Tanker.main?.whiteLightRelay.int = 0
                
                theSwitch.timer?.stop(force: true)
            }
        }
        debouncer.interval()
    }
    
    //MARK:Poller
    
    public func startPoller() {
        if let tank = Tanker.main {
            tank.poller = Thread(){ [self] in
            createPoller()()
        }
        
            tank.poller?.qualityOfService = .background
            tank.poller?.start()
        }
    }
    
    public func createPoller() -> CompletionHandler {
        return {[self] in
            var i = 0
            
            while true {
                i += 1
                
                if (i % 400 != 0) {
                    continue
                } else {
                    if let tank = Tanker.main {
                        if tank.firstCycle {
                            tank.firstCycle = false
                        } else {
                            if (tank.state.misterButtonDown != tank.misterButton.bool) {
                                print("state.misterButtonDown != misterButton.bool")
                                print("mister")
                                self.lightSwitchPressed(theSwitch: tank.misterButton)
                            }
                            if (tank.state.lightButtonDown != tank.lightButton.bool) {
                                print("light")
                                self.lightSwitchPressed(theSwitch: tank.lightButton)
                            }
                        }
                        
                        tank.state.statusLED = tank.statusLED.bool
                        
                        tank.state.misterButtonDown = tank.misterButton.bool
                        tank.state.lightButtonDown = tank.lightButton.bool
                        
                        tank.state.misterOn = tank.misterRelay.bool
                        tank.state.lightBlue = tank.blueLightRelay.bool
                        tank.state.lightWhite = tank.whiteLightRelay.bool
                    } else {
                        print("Tank is nil")
                    }
                }
                sleep(1/2)
            }
        }
    }
}
