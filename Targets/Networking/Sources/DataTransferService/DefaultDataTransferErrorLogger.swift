//
//  DefaultDataTransferErrorLogger.swift
//  PetConnect
//
//  Created by 이원빈 on 8/20/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import NetworkingInterface

public final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
  public init() {}
  
  public func log(error: Error) {
    printIfDebug("-------------")
    printIfDebug("\(error)")
  }
}
