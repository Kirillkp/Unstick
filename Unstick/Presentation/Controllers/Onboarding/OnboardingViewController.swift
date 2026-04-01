//
//  OnboardingViewController.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 30.03.2026
//  
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: OnboardingPresenterProtocol?

    // MARK: - Private Properties

    // MARK: - UI

    private let backgroundView = MeshGradientView()
    private let textBackground = BlurBackgroundView()

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

// MARK: - OnboardingViewProtocol

extension OnboardingViewController: OnboardingViewProtocol {}

// MARK: - Create UI

private extension OnboardingViewController {
    func createUI() {
        setupBackgroundView()
        setupTextBackground()

    }
    
    func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupTextBackground() {
        view.addSubview(textBackground)
        textBackground.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
            $0.height.equalTo(200)
        }
    }
}
