//
//  MenuBar.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/02.
//

import UIKit

class TabLayout : UIView {

    lazy var _tabBody : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var _tabList : [TabModel] = []
    lazy var _tabHeader: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        view.register(TabHeaderCell.self, forCellWithReuseIdentifier: "TabHeaderCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Current selected tab index
    private var _currentTabIndex: Int = 0
    
    // Indicator to track animation state
    private var _isAnimating: Bool = false
    
    private func setUI(){
        addSubview(_tabHeader)
        addSubview(_tabBody)
        
        NSLayoutConstraint.activate([
            _tabHeader.topAnchor.constraint(equalTo: topAnchor),
            _tabHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            _tabHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            _tabHeader.heightAnchor.constraint(equalToConstant: 50),

            _tabBody.topAnchor.constraint(equalTo: _tabHeader.bottomAnchor),
            _tabBody.leadingAnchor.constraint(equalTo: leadingAnchor),
            _tabBody.trailingAnchor.constraint(equalTo: trailingAnchor),
            _tabBody.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func initTabLayout(){
        // Set initial tab index
        _currentTabIndex = 0
        
        // tab body set for first
        changeTabBody(index: _currentTabIndex)

        // Select first tab with animation after a short delay (to ensure collection view is laid out)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.selectTab(at: self._currentTabIndex, animated: true)
        }
    }
    
    // New method to select tab with animation
    func selectTab(at index: Int, animated: Bool = true) {
        guard index >= 0 && index < _tabList.count && !_isAnimating else { return }
        
        // Update current index
        let previousIndex = _currentTabIndex
        _currentTabIndex = index
        
        // Select the tab in collection view
        _tabHeader.selectItem(at: IndexPath(item: index, section: 0),
                             animated: animated,
                             scrollPosition: .centeredHorizontally)
        
        // Update tab body
        changeTabBody(index: index)
        
        // Apply indicator animation
        if let currentCell = _tabHeader.cellForItem(at: IndexPath(item: index, section: 0)) as? TabHeaderCell {
            if animated {
                _isAnimating = true
                
                // Clear previous selection if different tab
                if previousIndex != index,
                   let previousCell = _tabHeader.cellForItem(at: IndexPath(item: previousIndex, section: 0)) as? TabHeaderCell {
                    previousCell.getLabelUnderline().backgroundColor = .clear
                }
                
                // Animate the indicator
                UIView.animate(withDuration: 0.3, animations: {
                    currentCell.getLabelUnderline().backgroundColor = .textColour
                }) { [weak self] _ in
                    self?._isAnimating = false
                }
            } else {
                // Without animation
                currentCell.getLabelUnderline().backgroundColor = .textColour
            }
        }
    }
    
    var _parentVC : UIViewController?
    var _controllerList : [UIViewController] = []
    func changeTabBody(index : Int){
        // Store the reference to ensure instances remain the same
        let targetController = _controllerList[index]
        
        _controllerList.forEach { controller in
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
        
        _parentVC?.addChild(targetController)
        targetController.view.frame = _tabBody.bounds
        targetController.didMove(toParent: _parentVC)
        _tabBody.addSubview(targetController.view)
    }
    
    init(
        setTabList : [TabModel],
        setControllers : [UIViewController],
        setParentVC : UIViewController
    ){
        super.init(frame: .zero)
        self._tabList = setTabList
        self._controllerList = setControllers
        self._parentVC = setParentVC
        
        setUI()
        initTabLayout()
    }
    
    // Public method to get current tab index
    func getCurrentTabIndex() -> Int {
        return _currentTabIndex
    }
    
    // Public method to get view controller at specific index
    func getViewController(at index: Int) -> UIViewController? {
        guard index >= 0 && index < _controllerList.count else { return nil }
        return _controllerList[index]
    }
    
    // Public method to get current view controller
    func getCurrentViewController() -> UIViewController? {
        return getViewController(at: _currentTabIndex)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TabLayout :
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    
    // cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _tabList.count
    }

    // cell binding
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabHeaderCell", for: indexPath) as! TabHeaderCell
        let model = _tabList[indexPath.item]
        cell.bind(model: model)
        
        // Initialize underline state based on current selection
        if indexPath.item == _currentTabIndex {
            cell.getLabelUnderline().backgroundColor = .textColour
        } else {
            cell.getLabelUnderline().backgroundColor = .clear
        }
        
        return cell
    }
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / CGFloat(_tabList.count)
        return CGSize(width: cellWidth, height: 50)
    }

    // section insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    // cell click event
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Use the new method to handle tab selection with animation
        selectTab(at: indexPath.item, animated: true)
    }
    
    // cell un click event
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TabHeaderCell {
            // Only clear if not the current selection
            if indexPath.item != _currentTabIndex {
                cell.getLabelUnderline().backgroundColor = .clear
            }
        }
    }
}
