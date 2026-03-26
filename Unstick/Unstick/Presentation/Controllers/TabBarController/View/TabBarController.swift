//
//  TabBarController.swift
//  Movie
//
//  Created by Кирилл Полосов on 16.09.2022.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    func configureThemeAppearance() {
        if let viewControllers = viewControllers {
            zip(viewControllers, TabBarItem.allCases).forEach { controller, item in
                controller.tabBarItem = item.asTabBarItem()
            }
        }
    }
}
