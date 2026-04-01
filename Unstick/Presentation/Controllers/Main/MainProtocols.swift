//
//  MainProtocols.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import Foundation

// VIEW -> PRESENTER

protocol MainPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func nextAction()
}

// PRESENTER -> VIEW

protocol MainViewProtocol: AnyObject {}

// PRESENTER -> INTERACTOR

protocol MainInteractorProtocol: AnyObject {}
