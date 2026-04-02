//
//  ModuleFactrory.swift
//  Movie
//
//  Created by Кирилл Полосов on 16.09.2022.
//

import Foundation

final class ModuleFactory {

    let appServices: AppServicing

    init(appServices: AppServicing) {
        self.appServices = appServices
    }
}
