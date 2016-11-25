//
//  PlayerDidTapCell.swift
//  Chapter3
//
//  Created by Miguel Bassila on 24/11/16.
//  Copyright © 2016 Bending Spoons. All rights reserved.
//

import Foundation
import Katana

struct PlayerDidTapCell: SyncAction {
  var payload: Int

  func updatedState(currentState: State) -> State {
    guard var state = currentState as? ApplicationState else {
      fatalError("Invalid state")
    }

    let cellIndex = self.payload
    state.board[cellIndex] = state.turn

    let winningLine = GameUtils.winningLine(for: state.board, lastMove: cellIndex)
    if let winningLine = winningLine {
      state.isGameFinished = true
      state.winningLine = winningLine

      switch state.turn {
      case .one:
        state.player1Score = state.player1Score + 10
      case .two:
        state.player2Score = state.player2Score + 10
      }

      return state
    }

    if !state.board.contains(where: { $0 == nil }) {
      state.isGameFinished = true
      return state
    }

    state.turn = state.turn == .one ? .two : .one
    return state
  }
}
