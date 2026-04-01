//
//  OnboardingPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 30.03.2026
//  
//

import Foundation

protocol OnboardingModuleDelegate: AnyObject {}

final class OnboardingPresenter {
    // MARK: - Private Properties

    private weak var view: OnboardingViewProtocol?
    private weak var delegate: OnboardingModuleDelegate?

    // MARK: - Init

    init(
        view: OnboardingViewProtocol,
        delegate: OnboardingModuleDelegate?
    ) {
        self.view = view
        self.delegate = delegate
    }
}

// MARK: - OnboardingPresenterProtocol

extension OnboardingPresenter: OnboardingPresenterProtocol {
    func viewLoaded() {
        bindActions()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewWillDisappear(_ animated: Bool) {}

    func bindActions() {}
}

// MARK: - Private Methods

private extension OnboardingPresenter {}
