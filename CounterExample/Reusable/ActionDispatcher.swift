//
//  ActionDispatch.swift
//  CounterExample
//
//  Created by morse on 2025/2/25.
//  Copyright © 2025 Colin Eberhardt. All rights reserved.
//

import Foundation
import ReSwift

public protocol ActionDispatcher {
  func dispatch(_ action: Action)
}

extension Store: ActionDispatcher {
  
}
