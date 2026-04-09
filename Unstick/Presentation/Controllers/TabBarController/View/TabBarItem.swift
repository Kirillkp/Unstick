//
//  TabBarItem.swift
//  Movie
//
//  Created by Кирилл Полосов on 16.09.2022.
//

import Foundation
import UIKit

enum TabBarItem: Int, CaseIterable {
    case main
    case statistics
    case settings
}

extension TabBarItem {
    
    private var icon: UIImage {
        switch self {
        case .main:
            return UIImage(systemName: "house")!
        case .statistics:
            return UIImage(systemName: "chart.bar.xaxis")!
        case .settings:
            return UIImage(systemName: "gearshape")!
        }
    }

    func asTabBarItem() -> UITabBarItem {
        let item = UITabBarItem(title: nil, image: icon, selectedImage: icon)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        return item
    }
}
