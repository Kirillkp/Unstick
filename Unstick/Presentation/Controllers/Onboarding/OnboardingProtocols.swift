//
//  OnboardingProtocols.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 30.03.2026
//  
//

import Foundation

// VIEW -> PRESENTER

protocol OnboardingPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
}

// PRESENTER -> VIEW

protocol OnboardingViewProtocol: AnyObject {}

// PRESENTER -> INTERACTOR

protocol OnboardingInteractorProtocol: AnyObject {}
