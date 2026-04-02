//
//  OnboardingPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 30.03.2026
//  
//

import Foundation

protocol OnboardingModuleDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingPresenter {
    // MARK: - Private Properties

    private weak var view: OnboardingViewProtocol?
    private let appServices: AppServicing
    private weak var delegate: OnboardingModuleDelegate?

    // MARK: - Init

    init(
        view: OnboardingViewProtocol,
        appServices: AppServicing,
        delegate: OnboardingModuleDelegate?
    ) {
        self.view = view
        self.appServices = appServices
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

    func didTapContinue() {
        appServices.completeOnboarding()
        delegate?.onboardingDidFinish()
    }

    func bindActions() {}
}

// MARK: - Private Methods

private extension OnboardingPresenter {}
