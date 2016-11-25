//
//  NewGame.swift
//  Chapter3
//
//  Created by Miguel Bassila on 25/11/16.
//  Copyright © 2016 Bending Spoons. All rights reserved.
//

import Foundation
import Katana

struct NewGame: SyncAction {
  var payload: ()

  func updatedState(currentState: State) -> State {
    guard let state = currentState as? ApplicationState else {
      fatalError("Invalid state")
    }

    // Create a new state and assign values we should retain (scores)
    var newState = ApplicationState()
    newState.player1Score = state.player1Score
    newState.player2Score = state.player2Score

    return newState
  }
}
