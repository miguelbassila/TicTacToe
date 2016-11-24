//
//  App.swift
//  TicTacToe
//
//  Created by Miguel Bassila on 24/11/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import Foundation
import Katana
import KatanaElements

struct App: NodeDescription {
  typealias PropsType = EmptyProps
  typealias StateType = EmptyState
  typealias NativeView = UIView

  var props: PropsType

  static func childrenDescriptions(props: PropsType,
                                   state: StateType,
                                   update: @escaping (StateType) -> (),
                                   dispatch: @escaping StoreDispatch) -> [AnyNodeDescription] {

    return [
      Label(props: Label.Props.build {
        $0.frame = props.frame
        $0.textAlignment = .center
        $0.text = NSAttributedString(string: "I'm Katana! Nice to meet you :)")
      })
    ]
  }
}
