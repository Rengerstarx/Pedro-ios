//
//  EventsViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import TinyConstraints
import Parchment
import Combine

class EventsViewController: UIViewController {
        
    private let pagingViewController = PagingViewController()
    private var parentStackViewBottom: Constraint?
    private let parentStackView = ViewsFactory.defaultStackView(axis: .vertical, spacing: 0)
    
    private let questionsCategories: [([EventsCategoryItem], String)] = [([
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06")
    ], "Будущие"), ([
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06"),
        EventsCategoryItem(title: "Встреча Антоном", description: "Встреча запланирована на 10:00 14.06")
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
        navigationItem.title = "Мои мероприятия"
    }
    
    private func setupViews() {
        
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
