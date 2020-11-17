//
//  ListsController.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

class ListsController: UIViewController {
    // MARK: - Properties
    private var tableView: UITableView!
    private let userInfoButton = UserInfoButton()
    private let bottomMenuView = BottomMenuView()
    
    private var lists = [List(title: "All Tasks", image: .file),
                         List(title: "Important", image: .star),
                         List(title: "Completed", image: .check),
                         List(title: "Homework", image: .folder)]
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        
        configureNavigationController()
        configureTableView()
        setupUserInfoButton()
        setupBottomMenu()
    }
    
    deinit {
        print("deinit: listcontroller")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        let list = lists[indexPath.row]
        cell.configure(list: list)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { action, view, completion in
        }
        deleteAction.image = Images.trash
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - BottomMenuViewDelegate
extension ListsController: BottomMenuViewDelegate {
    func didTapCreateList() {
    }
}
