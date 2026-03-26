//
//  Coordinatable.swift
//  CoordinatorLib
//
//  Created by Кирилл Полосов on 17.09.2022.
//

import Foundation

public protocol Coordinatable: AnyObject {

    var onFinish: ((Coordinatable) -> ())? { get set }

    func start()
}
