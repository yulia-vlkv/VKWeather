//
//  MainScreenView.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import UIKit


extension MainScreenView: ConfigurableView {
    
    func configure(with model: MainScreenViewModel) {
        navigationItem.title = model.city
        mainTableView.reloadData()
    }
}


class MainScreenView: UIViewController {
    
    public var model: MainScreenViewModel!
    
    private var cells: [DailyWeatherTableCellModel] = []

    private let mainTableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureNavigationBar()
        
        model.onViewDidLoad()
    }
    
    // MARK: - Configure TableView
    
    private func configureTableView(){
        view.addSubview(mainTableView)
        mainTableView.backgroundColor = .white
        mainTableView.toAutoLayout()
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.separatorStyle = .none
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(DailyWeatherTableCell.self, forCellReuseIdentifier: String(describing: DailyWeatherTableCell.self))
        mainTableView.register(CurrentWeatherTableCell.self, forCellReuseIdentifier: String(describing: CurrentWeatherTableCell.self))
        
        let constraints = [
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureNavigationBar(){
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "map.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(toLocationSelection))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance  = appearance
        navigationController?.navigationBar.standardAppearance  = appearance

    }
    
    @objc private func toLocationSelection(){
        model.showLocationSelection()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainScreenView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = model.sections[section]
        switch sectionModel{
        case .current(let items):
            return 1
        case .daily(let items):
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = model.sections[indexPath.section]
        switch sectionModel{
        case .current(let item):
            return cellForItem(item, indexPath: indexPath, tableView: tableView)
        case .daily(let items):
            return cellForItem(items[indexPath.row], indexPath: indexPath, tableView: tableView)
        }
    }
    
    private func cellForItem(_ item: MainScreenDataSourceItem, indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        switch item {
        case .currentWeather(let cellModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrentWeatherTableCell.self), for: indexPath) as! CurrentWeatherTableCell
            cell.configure(with: cellModel)
            return cell
        case .dailyWeather(let cellModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyWeatherTableCell.self), for: indexPath) as! DailyWeatherTableCell
            cell.configure(with: cellModel)
            cell.selectionStyle = .none
            return cell
        }
    }
    
}


