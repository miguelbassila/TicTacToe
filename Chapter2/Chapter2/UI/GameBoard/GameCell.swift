//
//  GameCell.swift
//  Chapter2
//
//  Created by Miguel Bassila on 24/11/16.
//  Copyright © 2016 Bending Spoons. All rights reserved.
//

import Foundation
import Katana
import KatanaElements

struct GameCell: NodeDescription, PlasticNodeDescription {

  typealias PropsType = Props
  typealias StateType = EmptyState
  typealias Keys = ChildrenKeys
  typealias NativeView = UIView

  static func childrenDescriptions(props: GameCell.Props,
                                   state: EmptyState,
                                   update: @escaping (EmptyState) -> (),
                                   dispatch: @escaping StoreDispatch) -> [AnyNodeDescription] {
    var children: [AnyNodeDescription] = [Button(props: .gameCellButtonProps(isWinningCell: props.isWinningCell, didTap: nil, key: Keys.button))]
    if props.player != nil {
      let image = Image(props: .gameCellImage(player: props.player, key: Keys.image))
      children.append(image)
    }

    return children
  }

  static func layout(views: ViewsContainer<GameCell.ChildrenKeys>, props: GameCell.Props, state: EmptyState) {
    let nativeView = views.nativeView
    views[.image]?.fill(nativeView, insets: .scalable(10, 10, 10, 10))
    views[.button]?.fill(nativeView)
  }
}

extension GameCell {
  enum ChildrenKeys {
    case button
    case image
  }
}

extension GameCell {
  struct Props: NodeDescriptionProps {
    var frame: CGRect = .zero
    var key: String?
    var alpha: CGFloat = 1.0

    var player: Player?
    var isWinningCell: Bool

    init(key: Any, player: Player?, isWinningCell: Bool) {
      self.isWinningCell = isWinningCell
      self.player = player
      self.setKey(key)
    }
  }
}
