//
//  AppDependencyContainer.swift
//  CounterExample
//
//  Created by morse on 2025/2/25.
//  Copyright © 2025 Colin Eberhardt. All rights reserved.
//

import Combine
import ReSwift
import UIKit

public final class AppDependencyContainer {
  let stateStore: Store<AppState> = {
    return Store(reducer: Reducers.counterReducer, state: AppState(), middleware: [])
  }()

  public init() {

  }

  public func makeAppStatePublisher() -> AnyPublisher<AppState, Never> {
    return stateStore.publisher()
  }

  public func makeCounterUserInteractions() -> CounterUserInteractions {
    return ReduxCounterUserInteractions(actionDispatcher: stateStore)
  }

  @MainActor
  public func makeMainViewController() -> MainViewController {
    let userInteractions = makeCounterUserInteractions()
    let publisher = makeAppStatePublisher()
    return MainViewController(counterUserInteractions: userInteractions, statePublisher: publisher)
  }
}
