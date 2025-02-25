//
//  ViewController.swift
//  CounterExample
//
//  Created by Colin Eberhardt on 04/08/2016.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Combine
import ReSwift
import UIKit

public class MainViewController: UIViewController {

  let counterUserInteractions: CounterUserInteractions
  let statePublisher: AnyPublisher<AppState, Never>
  var subscriptions = Set<AnyCancellable>()

  var rootView: CounterView {
    return view as! CounterView
  }

  public init(counterUserInteractions: CounterUserInteractions, statePublisher: AnyPublisher<AppState, Never>) {
    self.counterUserInteractions = counterUserInteractions
    self.statePublisher = statePublisher
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func loadView() {
    view = CounterView(userInteractions: counterUserInteractions)
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    observeState()
  }

  func observeState() {
    statePublisher
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] state in
        self?.rootView.label.text = "\(state.counter)"
      })
      .store(in: &subscriptions)

  }
}
