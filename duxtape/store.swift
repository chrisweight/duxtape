//
//  store.swift
//  duxtape
//
//  Created by Chris Weight <chris@chrisweight.com>, April 2017
//
//  This is a naive (to-be-improved) ground-up implementation of a 
//  classic Redux Store.
//
//  All original thought is credited to Dan Abramov (@gaearon)
//
//  TODO: Implement enhancer for middleware, async requests, time-travel etc
//


import Foundation


class Store {
  
    private var reducer:Reducer?
    private var listeners = [Listener]()
    
    private var state:State {
        didSet {
            for listener in self.listeners {
                listener.callback(self.state)
            }
        }
    }

    
    // MARK: -- Static API
    //
    
    static func createStore(reducer:Reducer, initialState:State) -> Store {
        return Store(reducer: reducer, state: initialState)
    }
    
    
    // MARK: -- Public API
    //
    
    func dispatch(action:Action) -> Action {
        print("Store.dispatch(action: \(action))")
        
        self.state = self
            .reducer!
            .execute(state: self.state, action: action)
        
        return action
    }
    
    func subscribe(listener: @escaping (State) -> ()) -> () -> () {
        let key         = String((Date().timeIntervalSince1970 * 1000).hashValue)
        let listener    = Listener(key: key, callback: listener)
        
        print("Store.subscribe(listener: \(listener))")
        
        self
            .listeners
            .append(listener)
        
        return {
            print("Store.unsubscribe(key: \(key))")
            
            self.listeners = self.listeners.filter {
              $0.key != key
            }
        }
    }
    
    func getState() -> State {
        return state
    }
    
    
    // MARK: -- Internal
    //
    
    init (reducer: Reducer, state:State) {
        print("Store.init()")
        
        self.state      = state
        self.reducer    = reducer
        
        _ = self
            .dispatch(
                action: Action(type: ActionType.Init.rawValue)
        )
    }
    
    deinit {
        print("Store.deinit()")
    }
}
