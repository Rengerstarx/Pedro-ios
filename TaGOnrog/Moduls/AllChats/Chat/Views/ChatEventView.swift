//
//  ChatEventView.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit
import TinyConstraints

enum ChatEventViewMenu {
    case dateCell
    case switchWithIconCell
    case stepperCell
}

enum ChatEventViewAction {
    case changeDate(date: Date)
    case changeOffline(replay: Bool)
    case changeInterval(interval: Int)
}

class ChatEventView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private let cellIdentifier = String(describing: PresentationsPlayTableViewCell.self)
    private let rows: [ChatEventViewMenu] = [.dateCell, .switchWithIconCell, .stepperCell]
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    private let continueButton = ViewsFactory.continueButton()
    
    var actionHandler: ((ChatEventViewAction) -> Void)?
    
    private let popupSize = CGSize(width: Constants.screenWidth, height: 235)
    
    private var interval = 30
    private var isOffline = false
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: popupSize))
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayouts() {
        addSubview(blurView)
        addSubview(tableView)
        addSubview(continueButton)
        blurView.edgesToSuperview()
        tableView.edgesToSuperview(excluding: .bottom)
        continueButton.edgesToSuperview(excluding: .top)
        tableView.bottomToTop(of: continueButton, offset: 10)
    }
    
    private func setupViews() {
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        continueButton.setTitle("Создать", for: .normal)
        continueButton.tintColor = .appBlack
        
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = self
        tableView.rowHeight = 55
        tableView.frame = CGRect(origin: .zero, size: popupSize)
        tableView.backgroundColor = .appClear
        
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = PresentationsPlayTableViewCell.defaultCell(title: nil)
        switch rows[indexPath.item] {
        case .switchWithIconCell:
            cell = PresentationsPlayTableViewCell.switchCell(title: "Онлайн", icon: AppImage.FigureTwo.uiImage, iconColor: .hexFFDD00, isOn: isOffline, tag: indexPath.item, target: self, action: #selector(onSwitchOffline))
        case .stepperCell:
            let title = String.Chat.timeIntervalString.format(interval)
            cell = PresentationsPlayTableViewCell.stepperCell(
                title: title, value: Double(interval),
                isOn: false,
                tag: indexPath.item,
                target: self,
                action: #selector(onChangeEventInterval)
            )
        case .dateCell:
            let title = "Выберите дату"
            cell = PresentationsPlayTableViewCell.dateCell(
                title: title,
                tag: indexPath.item,
                target: self,
                action: #selector(onChangeTimeInterval)
            )
        }
        return cell
    }
    
    @objc private func onSwitchOffline(_ sender: UISwitch) {
        isOffline = sender.isOn
        actionHandler?(.changeOffline(replay: isOffline))
    }
    
    @objc private func onChangeTimeInterval(_ sender: UIDatePicker) {
        actionHandler?(.changeDate(date: sender.date))
    }
     
    @objc private func onChangeEventInterval(_ sender: UIStepper) {
        interval = Int(sender.value)
        actionHandler?(.changeInterval(interval: interval))
        tableView.reloadData()
    }
    
}
