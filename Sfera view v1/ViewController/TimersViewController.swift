//
//  ViewController.swift
//  Sfera view v1
//
//  Created by Максим on 08.07.2021.
//


import UIKit

class TimersViewController: UIViewController {
    //    MARK: - Properties
    private var viewModel: TimersViewModel = TimersViewModelImpl()
    private var timers: [TimerElement] = []
    
    // MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.identifier)
        tableView.register(NewTimerCell.self, forCellReuseIdentifier: NewTimerCell.identifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Private Functions
    private func bindViewModel() {
        viewModel.timersBind.bindAndFire { [weak self] timers in
            guard let self = self else { return }
            let isCountUpdate = self.timers.count != timers.count
            self.timers = timers
            if isCountUpdate {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupNavController() {
        navigationItem.title = "Мульти таймер"
    }
    
    //  Dismiss Keyboard
    fileprivate func setupGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    private func setupLayoutTableView() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayoutTableView()
        setupGestures()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavController()
        bindViewModel()
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Extension UITableViewDataSource
extension TimersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewTimerCell.identifier, for: indexPath) as? NewTimerCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.identifier, for: indexPath) as? TimerCell else { return UITableViewCell() }
            let index = indexPath.row
            cell.setupCell(newTimer: timers[index], index: index)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - Extension UITableViewDelegate
extension TimersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        switch section {
        case 0:
            headerView.title = String.titles.newTimer.rawValue
        case 1:
            headerView.title = String.titles.timers.rawValue
        default:
            break
        }
        return headerView
    }
}

extension TimersViewController: NewTimerDelegate {
    func didTapAddTimerButton(timer: TimerElement) {
//        timers.append(timer)
//        print(timers)
//
//        tableView.beginUpdates()
//        tableView.insertRows(at: [(NSIndexPath(row: timers.count-1, section: 1) as IndexPath)],
//                             with: .automatic)
//        tableView.endUpdates()
        
        viewModel.didAddTimerTap(timer: timer)
        viewModel.sortTimers()
        
    }
}

extension TimersViewController: TimerCellDelegate {
    func didEndTimer(index: Int) {
        print("Index с ячейки: \(index)")
        print("Кол-во эл-ов массива timers ДО: \(timers.count)")
        print("Состав массива timers ДО: \(timers)")
        
        guard !timers.isEmpty else { return }
        viewModel.didRemoveTimer(index: index)
        print("Кол-во эл-ов массива timers ПОСЛЕ : \(timers.count)")
        print("Состав массива timers После: \(timers)")
        tableView.reloadData()
        
//        let indexPath = [NSIndexPath(row: index, section: 1)]
//        timers.remove(at: index)
//        self.tableView.beginUpdates()
//
//        self.tableView.deleteRows(at: indexPath as [IndexPath] , with: .fade)
//        self.tableView.endUpdates()
//        self.tableView.reloadData()
   
    }
}
