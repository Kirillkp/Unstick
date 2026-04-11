//
//  RestrictionSetupMinutesPopoverViewController.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit

final class RestrictionSetupMinutesPopoverViewController: UITableViewController {
    private enum Layout {
        static let rowHeight: CGFloat = 44
        static let preferredWidth: CGFloat = 160
        static let preferredMaxHeight: CGFloat = 320
    }

    private let options: [Int]
    private let selectedValue: Int
    private let onSelected: (Int) -> Void

    init(
        options: [Int],
        selectedValue: Int,
        onSelected: @escaping (Int) -> Void
    ) {
        self.options = options
        self.selectedValue = selectedValue
        self.onSelected = onSelected
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        setupTableView()
        setupPreferredContentSize()
    }
}

private extension RestrictionSetupMinutesPopoverViewController {
    func setupSelf() {
        view.backgroundColor = DS.Colors.surfacePrimary
    }

    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = DS.Colors.surfacePrimary
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = Layout.rowHeight
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MinuteCell")
    }

    func setupPreferredContentSize() {
        let height = min(CGFloat(options.count) * Layout.rowHeight, Layout.preferredMaxHeight)
        preferredContentSize = CGSize(width: Layout.preferredWidth, height: height)
    }
}

extension RestrictionSetupMinutesPopoverViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MinuteCell", for: indexPath)
        let minute = options[indexPath.row]
        let isSelected = minute == selectedValue

        var content = cell.defaultContentConfiguration()
        content.text = "\(minute) мин"
        content.textProperties.font = DS.Font.medium(17)
        content.textProperties.color = DS.Colors.textSecondary
        cell.contentConfiguration = content
        cell.backgroundColor = DS.Colors.surfacePrimary
        cell.tintColor = DS.Colors.primary
        cell.accessoryType = isSelected ? .checkmark : .none

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let minute = options[indexPath.row]
        dismiss(animated: true) { [onSelected] in
            onSelected(minute)
        }
    }
}

extension RestrictionSetupMinutesPopoverViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        .none
    }
}

