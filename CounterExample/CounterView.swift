//
//  CounterView.swift
//  CounterExample
//
//  Created by morse on 2025/2/25.
//  Copyright © 2025 Colin Eberhardt. All rights reserved.
//

import UIKit

class CounterView: UIView {

  let userInteractions: CounterUserInteractions

  let upButton = {
    let button = UIButton(frame: .zero)
    button.translatesAutoresizingMaskIntoConstraints = false

    var configuration = UIButton.Configuration.plain()
    configuration.title = "+"
    configuration.background.backgroundColor = .blue
    button.configuration = configuration

    return button
  }()

  let downButton = {
    let button = UIButton(frame: .zero)
    button.translatesAutoresizingMaskIntoConstraints = false

    var configuration = UIButton.Configuration.plain()
    configuration.title = "-"
    configuration.background.backgroundColor = .blue
    button.configuration = configuration

    return button
  }()

  let label = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false

    label.textAlignment = .center

    return label
  }()

  init(frame: CGRect = .zero, userInteractions: CounterUserInteractions) {
    self.userInteractions = userInteractions

    super.init(frame: frame)

    constructViewHierarchy()
    activateViewConstraints()
    setupAppearance()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// 构建视图层次
  open func constructViewHierarchy() {
    addSubview(upButton)
    addSubview(downButton)
    addSubview(label)

    upButton.addAction(
      UIAction { [weak self] _ in
        self?.userInteractions.increment()
      }, for: .touchUpInside)

    downButton.addAction(
      UIAction { [weak self] _ in
        self?.userInteractions.decrement()
      }, for: .touchUpInside)
  }

  /// 激活视图约束
  open func activateViewConstraints() {
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      label.widthAnchor.constraint(equalToConstant: 100),

      upButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      upButton.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: 32),

      downButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      label.trailingAnchor.constraint(equalTo: downButton.leadingAnchor, constant: 32),
    ])
  }

  /// 设置 View 样式
  open func setupAppearance() {}

}
