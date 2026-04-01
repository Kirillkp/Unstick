//
//  SettingsProtocols.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//  
//

import Foundation

// VIEW -> PRESENTER

protocol SettingsPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
}

// PRESENTER -> VIEW

protocol SettingsViewProtocol: AnyObject {}

// PRESENTER -> INTERACTOR

protocol SettingsInteractorProtocol: AnyObject {}
