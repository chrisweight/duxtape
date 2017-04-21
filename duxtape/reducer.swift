//
//  reducer.swift
//  duxtape
//
//  Created by Christopher Weight on 24/03/2017.
//  Copyright © 2017 Christopher Weight. All rights reserved.
//

import Foundation

protocol Reducer {
   func execute(state:State, action:Action) -> State
}
