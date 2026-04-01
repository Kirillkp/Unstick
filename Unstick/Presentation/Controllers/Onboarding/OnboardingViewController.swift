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
    private let logo = UIImageView()
    private let logoTitle = UILabel()
    private let textBackground = BlurBackgroundView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

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
        setupLogoImage()
        setupLogoTitle()
        setupTextBackground()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupLogoImage() {
        backgroundView.addSubview(logo)
        logo.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(DS.Spacing.x32)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 48, height: 48))
        }
        logo.image = Assets.icon
    }
    
    func setupLogoTitle() {
        backgroundView.addSubview(logoTitle)
        logoTitle.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(DS.Spacing.x8)
            $0.centerX.equalToSuperview()
        }
        logoTitle.text = L10n.Onboarding.logotitle
        logoTitle.textColor = DS.Colors.textTertiary
        logoTitle.applyFontStyle(.caption2)
    }
    
    func setupTextBackground() {
        backgroundView.addSubview(textBackground)
        textBackground.snp.makeConstraints {
            $0.top.equalTo(logoTitle.snp.bottom).offset(DS.Spacing.x48)
            $0.centerY.equalToSuperview().offset(DS.Spacing.x48)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
        }
    }
    
    func setupTitleLabel() {
        textBackground.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(DS.Spacing.x32)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x32)
        }
        titleLabel.numberOfLines = 0
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.text = L10n.Onboarding.title
        titleLabel.applyFontStyle(.largeTitle)
    }
    
    func setupSubtitleLabel() {
        textBackground.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(DS.Spacing.x16)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x32)
            $0.bottom.equalToSuperview().inset(DS.Spacing.x32)
        }
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = DS.Colors.textSecondary
        subtitleLabel.text = L10n.Onboarding.subtitle
        subtitleLabel.applyFontStyle(.body)
    }
}
