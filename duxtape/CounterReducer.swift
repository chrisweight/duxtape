//
//  SimpleReducer.swift
//  duxtape
//
//  Created by Christopher Weight on 24/03/2017.
//  Copyright © 2017 Christopher Weight. All rights reserved.
//

import Foundation

class CounterReducer:Reducer {
    func execute(state: State, action: Action) -> State {

        var _state = state;
        
        switch action.type {
            case "ADD":
                _state.data = (_state.data as! Int) + 1
            case "SUBTRACT":
                _state.data = (_state.data as! Int) - 1
            default: break
        }
        
        return _state
    }
}
