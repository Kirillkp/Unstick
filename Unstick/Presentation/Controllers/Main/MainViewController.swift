//
//  MainViewController.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import UIKit
import SnapKit
import FamilyControls

final class ScreenTimeAuthorizationService {

    func requestAccess() async throws {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
    }

    func authorizationStatus() -> AuthorizationStatus {
        AuthorizationCenter.shared.authorizationStatus
    }
}

final class MainViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: MainPresenterProtocol?

    // MARK: - Private Properties

    // MARK: - UI

    private let backgroundView = MeshGradientView()
    private let startButton = UIButton()

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

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {}

// MARK: - Create UI

private extension MainViewController {
    func createUI() {
        title = "Главная"
        setupBackgroundView()
        setupStartButton()
    }
    
    func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupStartButton() {
        view.addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 200, height: 50))
        }
        startButton.backgroundColor = .red
        startButton.setTitle("Начать", for: .normal)
        startButton.addTarget(
            self,
            action: #selector(startButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc func startButtonTapped() {
        presenter?.nextAction()
    }
}
