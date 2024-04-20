//
//  PresentationsPlayTableViewCell.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit

class PresentationsPlayTableViewCell {
    
    static func defaultCell(title: String?, icon: UIImage? = nil, iconColor: UIColor? = nil) -> UITableViewCell {
        let cell = defaultCell(style: .default, icon: icon, iconColor: iconColor)
        cell.textLabel?.text = title
        return cell
    }
    
    static func switchCell(
        title: String?,
        icon: UIImage? = nil,
        iconColor: UIColor? = nil,
        isOn: Bool,
        tag: Int,
        target: Any?,
        action: Selector
    ) -> UITableViewCell {
        let switchView = ViewsFactory.defaultSwitch()
        switchView.tag = tag
        switchView.isOn = isOn
        switchView.addTarget(target, action: action, for: .valueChanged)
        let cell = defaultCell(style: .value1, icon: icon, iconColor: iconColor, accessory: .none)
        cell.textLabel?.text = title
        cell.accessoryView = switchView
        cell.selectionStyle = .none
        return cell
    }
    
    static func dateCell(
        title: String?,
        icon: UIImage? = nil,
        iconColor: UIColor? = nil,
        tag: Int,
        target: Any?,
        action: Selector
    ) -> UITableViewCell {
        let dateView = UIDatePicker()
        dateView.setValue(UIColor.appWhite, forKeyPath: "textColor")
        dateView.tag = tag
        dateView.addTarget(target, action: action, for: .valueChanged)
        let cell = defaultCell(style: .value1, icon: icon, iconColor: iconColor, accessory: .none)
        cell.textLabel?.text = title
        cell.accessoryView = dateView
        cell.selectionStyle = .none
        return cell
    }
    
    private static func defaultCell(
        style: UITableViewCell.CellStyle,
        icon: UIImage? = nil,
        iconColor: UIColor? = nil,
        accessory: UITableViewCell.AccessoryType = .disclosureIndicator
    ) -> UITableViewCell {
        let cell = UITableViewCell(style: style, reuseIdentifier: nil)
        cell.accessoryType = accessory
        cell.textLabel?.font = .sFProTextSemibold(ofSize: 15)
        cell.detailTextLabel?.font = .systemFont(ofSize: 14)
        cell.textLabel?.textColor = .appWhite
        cell.detailTextLabel?.textColor = .appWhite
        cell.imageView?.image = icon?.applyingSymbolConfiguration(.init(scale: .large))
        cell.imageView?.tintColor = iconColor
        cell.backgroundColor = .appClear
        return cell
    }
    
    static func stepperCell(
        title: String?,
        value: Double = 3.0,
        icon: UIImage? = nil,
        iconColor: UIColor? = nil,
        isOn: Bool, tag: Int,
        target: Any?, action: Selector
    ) -> UITableViewCell {
        let stepperView = ViewsFactory.defaultStepper()
        stepperView.tag = tag
        stepperView.value = Double(value)
        stepperView.stepValue = 5
        stepperView.minimumValue = 10
        stepperView.maximumValue = 60
        stepperView.setIncrementImage(AppImage.actionsPlus.uiImageWith(tint: .appWhite), for: .normal)
        stepperView.setDecrementImage(AppImage.presentationsMinus.uiImageWith(tint: .appWhite), for: .normal)
        stepperView.addTarget(target, action: action, for: .valueChanged)
        let cell = defaultCell(style: .value1, icon: icon, iconColor: iconColor, accessory: .none)
        cell.textLabel?.text = title
        cell.accessoryView = stepperView
        cell.selectionStyle = .none
        return cell
    }
    
}
