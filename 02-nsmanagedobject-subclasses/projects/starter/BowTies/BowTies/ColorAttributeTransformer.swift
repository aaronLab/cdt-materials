//
//  ColorAttributeTransformer.swift
//  BowTies
//
//  Created by Aaron Lee on 2021/12/20.
//  Copyright © 2021 Razeware. All rights reserved.
//

import UIKit

class ColorAttributeTransformer: NSSecureUnarchiveFromDataTransformer {
  
  override class var allowedTopLevelClasses: [AnyClass] {
    return [UIColor.self]
  }
  
  static func register() {
    let className = String(describing: ColorAttributeTransformer.self)
    let name = NSValueTransformerName(className)
    
    let transformer = ColorAttributeTransformer()
    ValueTransformer.setValueTransformer(transformer, forName: name)
  }

}
