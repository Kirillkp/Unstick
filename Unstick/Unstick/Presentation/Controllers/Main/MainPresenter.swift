//
//  MainPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import Foundation

protocol MainModuleDelegate: AnyObject {}

final class MainPresenter {
    // MARK: - Private Properties

    private weak var view: MainViewProtocol?
    private weak var delegate: MainModuleDelegate?

    // MARK: - Init

    init(
        view: MainViewProtocol,
        delegate: MainModuleDelegate?
    ) {
        self.view = view
        self.delegate = delegate
    }
}

// MARK: - MainPresenterProtocol

extension MainPresenter: MainPresenterProtocol {
    func viewLoaded() {
        bindActions()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewWillDisappear(_ animated: Bool) {}

    func bindActions() {}
}

// MARK: - Private Methods

private extension MainPresenter {}
