//
//  listener.swift
//  duxtape
//
//  Created by Christopher Weight on 24/03/2017.
//  Copyright © 2017 Christopher Weight. All rights reserved.
//

import Foundation

struct Listener {
    var key:String
    var callback: (State) -> ()
}
