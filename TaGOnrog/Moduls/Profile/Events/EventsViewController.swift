//
//  EventsViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import TinyConstraints
import Parchment
import Combine
import AKAlertController

class EventsViewController: UIViewController {
        
    private let pagingViewController = PagingViewController()
    private var parentStackViewBottom: Constraint?
    private let parentStackView = ViewsFactory.defaultStackView(axis: .vertical, spacing: 0)
    
    private let questionsCategories: [([EventsCategoryItem], String)] = [([
        EventsCategoryItem(title: "Встреча Настей", description: "Встреча запланирована на 19:30 28.04"),
        EventsCategoryItem(title: "Встреча Давидом", description: "Встреча запланирована на 20:00 04.05"),
        EventsCategoryItem(title: "Встреча Альбиной", description: "Встреча запланирована на 21:30 14.05"),
        EventsCategoryItem(title: "Встреча Лизой", description: "Встреча запланирована на 18:30 14.05"),
        EventsCategoryItem(title: "Встреча Кириллом", description: "Встреча запланирована на 19:00 14.05")
    ], "Будущие"), ([
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча была в 18:00 01.03"),
        EventsCategoryItem(title: "Встреча Женей", description: "Встреча была в 20:00 04.03"),
        EventsCategoryItem(title: "Встреча Викой", description: "Встреча была в 21:00 24.03"),
        EventsCategoryItem(title: "Встреча Сергеем", description: "Встреча была в 19:35 11.04"),
        EventsCategoryItem(title: "Встреча Сашей", description: "Встреча была в 20:00 14.04")
    ], "Прошедшие")]
    
    
    let action = PassthroughSubject<EventsCategoryItem, Never>()
    var observable: AnyCancellable?
    
    private var keyboardHeight: CGFloat = 0
    
    lazy var loadedAdBannerHeight = rootTabBarController?.bannerHeight ?? 0 {
        didSet {
            updateParentStackViewBottom()
        }
    }
    
    private var bottomOffset: CGFloat {
        return max(keyboardHeight, loadedAdBannerHeight)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitles()
        setupViews()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Helpers
    
    private func commonInit() {
        hidesBottomBarWhenPushed = true
    }
    
    private func setTitles() {
        navigationItem.title = "Мои встречи"
    }
    
    private func setupViews() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .hexF2F2F7
        
        pagingViewController.menuBackgroundColor = .appClear
        
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 100, height: 32)
        pagingViewController.menuItemSpacing = 4
        pagingViewController.menuItemLabelSpacing = 16
        pagingViewController.menuInsets = .top(16) + .horizontal(16) + .bottom(4)
        
        pagingViewController.register(EventsCategoryCollectionViewCell.self, for: PagingIndexItem.self)
        
        pagingViewController.font = .sFProText(ofSize: 15)
        pagingViewController.textColor = .appSystemGray
        
        pagingViewController.selectedTextColor = .appBlack
        pagingViewController.selectedFont = .sFProTextBold(ofSize: 15)
        pagingViewController.selectedBackgroundColor = .hexFFDD00
        
        pagingViewController.borderOptions = .hidden
        pagingViewController.indicatorOptions = .hidden
        
        pagingViewController.dataSource = self
    }
    
    private func setupLayout() {
        pagingViewController.willMove(toParent: self)
        addChild(pagingViewController)
        [pagingViewController.view].forEach { parentStackView.addArrangedSubview($0) }
        
        view.addSubview(parentStackView)
        parentStackView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        parentStackViewBottom = parentStackView.bottomToSuperview(usingSafeArea: true)
        pagingViewController.didMove(toParent: self)
        
        updateParentStackViewBottom()
    }
    
    private func updateParentStackViewBottom() {
        parentStackViewBottom?.constant = -bottomOffset
        view.layoutIfNeeded()
    }
    
}

// MARK: - PagingViewControllerDataSource

extension EventsViewController: PagingViewControllerDataSource {
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return questionsCategories.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let questionCategory = questionsCategories[index]
        let controller = EventsCategoryViewController(
            category: questionCategory,
            keyboardHeight: keyboardHeight
        )
        return controller
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return PagingIndexItem(index: index, title: questionsCategories[index].1)
    }
    
}
