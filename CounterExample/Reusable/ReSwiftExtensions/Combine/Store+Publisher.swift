//
//  Store+Publisher.swift
//  CounterExample
//
//  Created by morse on 2025/2/25.
//  Copyright © 2025 Colin Eberhardt. All rights reserved.
//

import Combine
import Foundation
import ReSwift

extension Store where State: Equatable {

  /// 自定义 StatePublisher 类型，将 ReSwift 中 Store 转为 Publisher
  struct StatePublisher: Combine.Publisher {
    typealias Output = State
    typealias Failure = Never

    let store: Store<State>

    func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Output == S.Input {
      let subscription = StateSubscription(store: store, subscriber: subscriber)
      subscriber.receive(subscription: subscription)
    }
  }

  public func publisher() -> AnyPublisher<State, Never> {
    return StatePublisher(store: self).eraseToAnyPublisher()
  }
}

/// 自定义订阅者，将 ReSwift 中的 StoreSubscriber 转为 StateSubscription，使其符合 Combine 的 Subscripter
private final class StateSubscription<S: Subscriber, StateT: Any>: Combine.Subscription, StoreSubscriber where S.Input == StateT {
  typealias StoreSubscriberStateType = StateT

  var requested: Subscribers.Demand = .none
  var subscriber: S?

  let store: Store<StateT>
  var subscribed = false

  init(store: Store<StateT>, subscriber: S) {
    self.store = store
    self.subscriber = subscriber
  }

  // ReSwift calls this method on state changes
  // ReSwift 在状态改变时调用此方法
  func newState(state: StateT) {
    guard requested > .none else { return }

    requested -= .max(1)

    // Forward ReSwift update to subscriber
    // 将 ReSwift 更新转发给订阅者
    _ = subscriber?.receive(state)
  }

  func request(_ demand: Subscribers.Demand) {
    requested += demand

    if !subscribed, requested > .none {
      // Subscribe to ReSwift store
      store.subscribe(self)
      subscribed = true
    }
  }

  func cancel() {
    store.unsubscribe(self)
    subscriber = nil
  }
}
