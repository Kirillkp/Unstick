//
//  SettingsPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//  
//

import Foundation

protocol SettingsModuleDelegate: AnyObject {}

final class SettingsPresenter {
    // MARK: - Private Properties

    private weak var view: SettingsViewProtocol?
    private weak var delegate: SettingsModuleDelegate?

    // MARK: - Init

    init(
        view: SettingsViewProtocol,
        delegate: SettingsModuleDelegate?
    ) {
        self.view = view
        self.delegate = delegate
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {
    func viewLoaded() {
        bindActions()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewWillDisappear(_ animated: Bool) {}

    func bindActions() {}
}

// MARK: - Private Methods

private extension SettingsPresenter {}
