//
//  SettingsViewController.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//  
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: SettingsPresenterProtocol?

    // MARK: - Private Properties

    // MARK: - UI

    // MARK: - Override

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        presenter?.viewLoaded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter?.viewWillDisappear(animated)
    }
}

// MARK: - SettingsViewProtocol

extension SettingsViewController: SettingsViewProtocol {}

// MARK: - Create UI

private extension SettingsViewController {
    func createUI() {
        title = "Настройки"
    }
}
