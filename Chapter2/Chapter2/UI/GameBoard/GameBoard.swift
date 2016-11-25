//
//  GameBoard.swift
//  Chapter2
//
//  Copyright © 2016 Bending Spoons.
//  Distributed under the MIT License.
//  See the LICENSE file for more information.

import Foundation
import Katana
import KatanaElements

enum Player {
  case one, two
}

struct GameBoard: NodeDescription {
  typealias PropsType = Props
  typealias StateType = EmptyState
  typealias NativeView = UIView
  typealias Keys = ChildrenKeys
  
  var props: PropsType
  
  static func childrenDescriptions(props: PropsType,
                                   state: StateType,
                                   update: @escaping (StateType) -> (),
                                   dispatch: @escaping StoreDispatch) -> [AnyNodeDescription] {
    
    return [
      View(props: View.Props.build {
        $0.backgroundColor = .red
        $0.frame = props.frame
      })
    ]
  }
}

extension GameBoard {
  enum ChildrenKeys {
  }
}

extension GameBoard {
  struct Props: NodeDescriptionProps, Buildable {
    var frame: CGRect = .zero
    var key: String?
    var alpha: CGFloat = 1.0

    var isGameFinished: Bool
    var turn: Player
    var board: [Player?]
    var winningLine: [Int]?

    var player1Score: Int
    var player2Score: Int

    var isLoading: Bool

    init() {
      self.isGameFinished = true
      self.turn = .one
      self.player1Score = 0
      self.player2Score = 0
      self.winningLine = nil
      self.isLoading = false

      self.board = [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil,
      ]
    }
  }
}
