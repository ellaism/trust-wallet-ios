// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import TrustKeystore
import UIKit

protocol BackupViewControllerDelegate: class {
    func didPressSkip(account: Account, in viewController: BackupViewController)
    func didPressBackup(account: Account, in viewController: BackupViewController)
}

class BackupViewController: UIViewController {

    let account: Account
    weak var delegate: BackupViewControllerDelegate?
    let viewModel = BackupViewModel()

    init(account: Account) {
        self.account = account

        super.init(nibName: nil, bundle: nil)

        let warningImageView = UIImageView()
        warningImageView.translatesAutoresizingMaskIntoConstraints = false
        warningImageView.image = R.image.backup_warning()

        let noBackupLabel = UILabel()
        noBackupLabel.translatesAutoresizingMaskIntoConstraints = false
        noBackupLabel.text = viewModel.headlineText
        noBackupLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
        noBackupLabel.adjustsFontSizeToFitWidth = true
        noBackupLabel.textColor = Colors.lightBlack

        let controlMoneyLabel = UILabel()
        controlMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        controlMoneyLabel.text = NSLocalizedString("export.youMustBackup.label.title", value: "You must backup your wallet in case this app is deleted, or your device is lost.", comment: "")
        controlMoneyLabel.numberOfLines = 0
        controlMoneyLabel.textAlignment = .center
        controlMoneyLabel.textColor = Colors.darkGray

        let neverStoredLabel = UILabel()
        neverStoredLabel.translatesAutoresizingMaskIntoConstraints = false
        neverStoredLabel.text = NSLocalizedString("export.thisStepImportant.label.title", value: "This step is important since your wallet will not be included in standard device backups.", comment: "")
        neverStoredLabel.numberOfLines = 0
        neverStoredLabel.textAlignment = .center
        neverStoredLabel.textColor = Colors.darkGray
        
        let backupLaterLabel = UILabel()
        backupLaterLabel.translatesAutoresizingMaskIntoConstraints = false
        backupLaterLabel.text = NSLocalizedString("export.backupLater.label.title", value: "You can backup your wallet later from the Settings page.", comment: "")
        backupLaterLabel.numberOfLines = 0
        backupLaterLabel.textAlignment = .center
        backupLaterLabel.textColor = Colors.darkGray

        let backupButton = Button(size: .large, style: .solid)
        backupButton.translatesAutoresizingMaskIntoConstraints = false
        backupButton.setTitle(NSLocalizedString("export.backup.button.title", value: "Backup Wallet", comment: ""), for: .normal)
        backupButton.addTarget(self, action: #selector(backup), for: .touchUpInside)
        
        let skipButton = Button(size: .large, style: .borderless)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitle(NSLocalizedString("export.dothislater.button.title", value: "I'll do this later", comment: ""), for: .normal)
        skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)

        let stackView = UIStackView(
            arrangedSubviews: [
                warningImageView,
                .spacer(),
                noBackupLabel,
                .spacer(height: 15),
                controlMoneyLabel,
                neverStoredLabel,
                backupLaterLabel,
                .spacer(height: 15),
                backupButton,
                skipButton
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.layoutGuide.topAnchor, constant: StyleLayout.sideMargin),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutGuide.leadingAnchor, constant: StyleLayout.sideMargin),
            stackView.trailingAnchor.constraint(equalTo: view.layoutGuide.trailingAnchor, constant: -StyleLayout.sideMargin),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.layoutGuide.bottomAnchor, constant: -StyleLayout.sideMargin),

            backupButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            backupButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
    
    @objc func skip() {
        delegate?.didPressSkip(account: account, in: self)
    }

    @objc func backup() {
        delegate?.didPressBackup(account: account, in: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
