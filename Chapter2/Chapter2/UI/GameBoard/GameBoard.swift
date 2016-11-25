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
    
    var children: [AnyNodeDescription] = [
      View(props: View.Props.build {
        $0.backgroundColor = .flatLightGrey()
        $0.frame = props.frame
        $0.setKey(Keys.background)
      }),

      Label(props: .gameBoardLabelProps(content: "Player one: \(props.player1Score)", key: Keys.player1Score, shouldPlay: props.turn == .one)),
      Label(props: .gameBoardLabelProps(content: "Player two: \(props.player2Score)", key: Keys.player2Score, shouldPlay: props.turn == .two)),
    ]

    if props.isGameFinished {
      let startButton = Button(props: .startButtonProps(title: "New Game", key: Keys.startButton, didTap: nil))
      children.append(startButton)
    }

    return children
  }
}

extension GameBoard {
  enum ChildrenKeys {
    case background
    case player1Score, player2Score
    case startButton
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

extension GameBoard: PlasticReferenceSizeable, PlasticNodeDescription {

  static var referenceSize = CGSize(width: 320, height: 568)

  static func layout(views: ViewsContainer<Keys>, props: PropsType, state: StateType) {

    let nativeView = views.nativeView
    let player1Score = views[.player1Score]!
    let player2Score = views[.player2Score]!
    let background = views[.background]!

    background.fill(nativeView)

    player1Score.fillHorizontally(nativeView, insets: .scalable(0, 15, 0, 15))
    player1Score.setTop(nativeView.top, offset: .scalable(30))
    player1Score.height = .scalable(40)

    player2Score.fillHorizontally(nativeView, insets: .scalable(0, 15, 0, 15))
    player2Score.top = player1Score.bottom
    player2Score.height = .scalable(40)

    let startButton = views[.startButton]
    startButton?.asFooter(nativeView, insets: .scalable(0, 10, 10, 10))
    startButton?.height = .scalable(40)
  }
}
