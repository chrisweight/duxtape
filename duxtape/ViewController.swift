//
//  ViewController.swift
//  duxtape
//
//  Created by Christopher Weight on 24/03/2017.
//  Copyright © 2017 Christopher Weight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var unsubscribe:(() -> ())? = nil
    var store = Store.createStore(reducer: CounterReducer(), initialState: CounterState(data:0))

    
    // MARK: -- Outlets
    //
    
    @IBOutlet weak var counter: UILabel!
    
    
    // MARK: -- Actions
    //
    
    @IBAction func onAdd(_ sender: Any) {
        _ = self.store.dispatch(action: Action(type:"ADD"))
    }

    @IBAction func onSubtract(_ sender: Any) {
        _ = self.store.dispatch(action: Action(type:"SUBTRACT"))
    }
    
    @IBAction func onUnsubscribe(_ sender: Any) {
        self.unsubscribe?()
    }
    
    // MARK: -- Overrides
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewController.viewDidLoad()")
        
        self.unsubscribe = store.subscribe(listener: {
            state in
            
            self.setCounter(fromData: state.data)
        })
        
        self.setCounter(fromData: store.getState().data)
    }

    private func setCounter(fromData:Any) {
        self.counter.text = String(describing: fromData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

