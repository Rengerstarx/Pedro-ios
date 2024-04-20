//
//  EventsCategoryViewController.swift
//  Translator
//
//  Created by tpe on 29.10.2023.
//

import TinyConstraints
import Combine

class EventsCategoryViewController: UIViewController {
    private let category: ([EventsCategoryItem], String)
    
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .appClear
        return collectionView
    }()
    private let collectionInsets = TinyEdgeInsets.horizontal(16) + .vertical(12)
    private let cellSpacing: CGFloat = 12
    private let cellIdentifier = String(describing: EventsCategoryItemCollectionVIewCell.self)
    private var cellSize: CGSize?
    
    private var categoryItems: [EventsCategoryItem] = []
    
    private var keyboardHeight: CGFloat = 0
    
    let action = PassthroughSubject<EventsCategoryItem, Never>()
    var observables: [AnyCancellable] = []
    
    init(category: ([EventsCategoryItem], String), keyboardHeight: CGFloat) {
        self.category = category
        self.keyboardHeight = keyboardHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        updateItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if cellSize == nil {
            cellSize = {
                let cellHeight: CGFloat = 102
                let cellsCount: CGFloat = 1
                var cellWidth = Constants.screenWidth
                cellWidth -=  collectionInsets.left + collectionInsets.right
                cellWidth -= (cellsCount - 1) * cellSpacing
                cellWidth /= cellsCount
                cellWidth = cellWidth.rounded(.down)
                return CGSize(width: cellWidth, height: cellHeight)
            }()
        }
    }
    
    func handleKeyboardShowHide(height: CGFloat) {
        keyboardHeight = height
        updateCollectionViewContentInsets()
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        collectionView.showsVerticalScrollIndicator = false
        updateCollectionViewContentInsets()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EventsCategoryItemCollectionVIewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
    
    private func updateItems() {
        categoryItems = category.0
    }
    
    private func updateCollectionViewContentInsets() {
        collectionView.contentInset = collectionInsets + .bottom(keyboardHeight)
    }
    
}

// MARK: - UICollectionViewDataSource

extension EventsCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let categoryItemCell = cell as? EventsCategoryItemCollectionVIewCell
        let item = categoryItems[indexPath.item]
        categoryItemCell?.update(item: item)
        categoryItemCell?.observable = categoryItemCell?.action
            .sink { [weak self] in
                self?.action.send(item)
            }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EventsCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}
