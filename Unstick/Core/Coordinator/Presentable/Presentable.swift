//
//  Presentable.swift
//  CoordinatorLib
//
//  Created by Кирилл Полосов on 17.09.2022.
//

import UIKit

public protocol Presentable: AnyObject {

    var toPresent: UIViewController? { get }
}

// MARK: - Default implementation for UIViewController

extension UIViewController: Presentable {
    
    public var toPresent: UIViewController? {
        return self
    }
}
