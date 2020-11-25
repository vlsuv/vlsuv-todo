//
//  AccountSettingsController.swift
//  vlsuv-todo
//
//  Created by vlsuv on 12.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit
import Firebase

class AccountSettingsController: UIViewController {
    // MARK: - Properties
    private var tableView: UITableView!
    private var accountInfoView: AccountInfoView!
    private var signOutButton: SignOutButton!
    
    private var smartLists: [SmartList] = [SmartList]()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        
        configureNavigationController()
        configureTableView()
        fetchSmartLists()
    }
    
    deinit {
        print("deinit: account setting controller")
    }
    
    // MARK: - Requests
    private func fetchSmartLists() {
        guard let id = UserManager.currentUserId() else {return}
        ListManager.shared.fetchSmartLists(withUserUid: id) { [weak self] smartLists in
            guard let self = self else {return}
            
            self.smartLists = smartLists
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    @objc private func handleDone() {
        dismiss(animated: true)
    }
    
    // MARK: - Handlers
    private func configureNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        
        navigationController?.isTransparent()
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            NSAttributedString.Key.foregroundColor: Colors.black
        ]
        navigationController?.navigationBar.tintColor = Colors.baseBlue
        navigationItem.title = "Settings"
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SmartListSettingCell.self, forCellReuseIdentifier: SmartListSettingCell.identifier)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor)
        
        tableView.backgroundColor = Colors.veryLightGray
        setupAccountInfoView()
        setupSignOutButton()
    }
    
    private func setupAccountInfoView() {
        accountInfoView = AccountInfoView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: AccountInfoView.accountInfoViewHeight))
        accountInfoView.delegate = self

        tableView.tableHeaderView = accountInfoView
    }
    
    private func setupSignOutButton() {
        signOutButton = SignOutButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: SignOutButton.signOutButtonHeight))
        signOutButton.delegate = self

        tableView.tableFooterView = signOutButton
    }
}

// MARK: - UITableViewDataSource
extension AccountSettingsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return AccountSettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let accountSettingSection = AccountSettingSection(rawValue: section) else {return 0}
        switch accountSettingSection {
        case .smartLists:
            return smartLists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let accountSettingSection = AccountSettingSection(rawValue: indexPath.section) else {return UITableViewCell()}
        switch accountSettingSection {
        case .smartLists:
            let cell = tableView.dequeueReusableCell(withIdentifier: SmartListSettingCell.identifier, for: indexPath) as! SmartListSettingCell
            cell.delegate = self
            let data = smartLists[indexPath.row]
            cell.configure(smartList: data)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension AccountSettingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SettingSectionHeaderView.settingSectionHeaderViewHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SettingSectionHeaderView.settingSectionHeaderViewHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let accountSettingSection = AccountSettingSection(rawValue: section) else {return UIView()}
        let settingSectionHeaderView = SettingSectionHeaderView(sectionName: accountSettingSection.description)
        return settingSectionHeaderView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - AccountInfoViewDelegate
extension AccountSettingsController: AccountInfoViewDelegate {
    func didTapEditAccount() {
    }
}

// MARK: - SignOutButtonDelegate
extension AccountSettingsController: SignOutButtonDelegate {
    func didTapSignOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        view.window?.rootViewController?.dismiss(animated: false)
    }
}

// MARK: - SmartListSettingCellDelegate
extension AccountSettingsController: SmartListSettingCellDelegate {

    func didTapSwitchControl(for cell: SmartListSettingCell) {
        guard let indexPath = tableView.indexPath(for: cell), let id = UserManager.currentUserId() else {return}
        var list = smartLists[indexPath.row]
        list.isShow.toggle()
        ListManager.shared.updateSmartList(withUserUid: id, usingList: list)
    }
}
