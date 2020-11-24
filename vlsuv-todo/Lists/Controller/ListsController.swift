//
//  ListsController.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit
import Firebase

class ListsController: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView!
    private let userInfoButton = UserInfoButton()
    private let bottomMenuView = BottomMenuView()
    
    private var sections: [ListsSection] = ListsSection.getSections()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        
        configureNavigationController()
        configureTableView()
        setupUserInfoButton()
        setupBottomMenu()
        fetchLists()
    }
    
    deinit {
        print("deinit: listcontroller")
    }
    
    // MARK: - Requests
    private func fetchLists() {
        guard let id = UserManager.currentUserId() else {return}
        
        ListManager.shared.fetchSmartLists(withUserUid: id) { [weak self] smartLists in
            guard let self = self else {return}
            
            for index in self.sections.indices {
                if self.sections[index].name == .smartLists {
                    self.sections[index].lists = smartLists
                }
            }
            self.tableView.reloadData()
        }
        
        ListManager.shared.fetchUserLists(withUserUid: id) { [weak self] userLists in
            guard let self = self else {return}
            
            for index in self.sections.indices {
                if self.sections[index].name == .userLists {
                    self.sections[index].lists = userLists
                }
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - BarButton Actions
    @objc private func handleSearch() {
    }
    
    @objc private func showUserSettings() {
        let controller = UINavigationController(rootViewController: AccountSettingsController())
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    // MARK: - Handlers
    private func configureNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.loupe, style: .plain, target: self, action: #selector(handleSearch))
        
        navigationController?.isTransparent()
        navigationController?.navigationBar.tintColor = Colors.baseBlue
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingBottom: bottomMenuView.bottomMenuViewHeight)
        
        tableView.rowHeight = Sizes.listCellHeight
        tableView.separatorStyle = .none
    }
    
    private func setupUserInfoButton() {
        userInfoButton.addTarget(self, action: #selector(showUserSettings), for: .touchUpInside)
        userInfoButton.configureUser()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userInfoButton)
    }
    
    private func setupBottomMenu() {
        bottomMenuView.delegate = self
        
        view.addSubview(bottomMenuView)
        bottomMenuView.anchor(left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingBottom: bottomMenuView.bottomMenuViewHeight)
    }
}

// MARK: - UITableViewDataSource
extension ListsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        let list = sections[indexPath.section].lists[indexPath.row]
        cell.configure(list: list)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let section = sections[indexPath.section]
        return section.isEdit
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] action, view, completion in
            guard let id = UserManager.currentUserId(), let list = self?.sections[indexPath.section].lists[indexPath.row] else {return}
            
            ListManager.shared.delete(withUserUid: id, usingList: list)
            completion(true)
        }
        deleteAction.image = Images.trash
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = Colors.lightGray
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.footerViewIsShow ? 1 : 0
    }
}

// MARK: - BottomMenuViewDelegate
extension ListsController: BottomMenuViewDelegate {
    func didTapCreateList() {
        guard let id = UserManager.currentUserId() else {return}
        
        let alertController = UIAlertController(title: "New List", message: nil, preferredStyle: .alert)
        let createAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields?.first
            
            if textField?.text != "" {
                let newList = UserList(title: textField!.text!, createdDate: Date())
                ListManager.shared.add(withUserUid: id, usingList: newList)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField()
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
