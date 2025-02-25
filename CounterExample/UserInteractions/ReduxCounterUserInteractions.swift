//
//  ReduxCounterUserInteractions.swift
//  CounterExample
//
//  Created by morse on 2025/2/25.
//  Copyright © 2025 Colin Eberhardt. All rights reserved.
//

import Foundation
import ReSwift

public class ReduxCounterUserInteractions: CounterUserInteractions {
  let actionDispatcher: ActionDispatcher

  public init(actionDispatcher: ActionDispatcher) {
    self.actionDispatcher = actionDispatcher
  }

  public func increment() {
    actionDispatcher.dispatch(CounterActionIncrease())
  }

  public func decrement() {
    actionDispatcher.dispatch(CounterActionDecrease())
  }

}
