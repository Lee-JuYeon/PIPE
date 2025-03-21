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
            _tabBody.bottomAnchor.constraint(equalTo: bottomAnchor) // Add this line
        ])
    }
    
    private func initTabLayout(){
        // tab body set for first
        changeTabBody(index: 0)

        // tab header set for first
        if let headCell = _tabHeader.cellForItem(at: IndexPath(item: 0, section: 0)) as? TabHeaderCell {
            headCell.getLabelUnderline().backgroundColor = .textColour
        }
    }
    
    var _parentVC : UIViewController?
    var _controllerList : [UIViewController] = []
    func changeTabBody(index : Int){
        _controllerList.forEach { controller in
            // 부모에서 자식 뷰 컨트롤러를 제거
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
        _parentVC?.addChild(_controllerList[index])
        _controllerList[index].view.frame = _tabBody.bounds
        _controllerList[index].didMove(toParent: _parentVC.self)
        _tabBody.addSubview(_controllerList[index].view)
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
        return cell
    }
    
    // 셀의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / CGFloat(_tabList.count)
        return CGSize(width: cellWidth, height: 50) // 높이는 필요에 따라 조정 가능
    }

    // 셀의 좌우 여백 설정 (여기서는 가운데 정렬이므로 따로 여백은 필요하지 않습니다)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    // cell click event
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changeTabBody(index:indexPath.row)
        
        // 선택된 셀에 접근
        if let cell = collectionView.cellForItem(at: indexPath) as? TabHeaderCell {
            // 여기서 선택된 셀에 대한 작업을 수행
            // selectedCell.titleLabel.text = "Selected"
            cell.getLabelUnderline().backgroundColor = .textColour
            
        }
    }
    
    // cell un click event
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TabHeaderCell {
            // 선택되지 않은 셀에 대한 작업 수행
            cell.getLabelUnderline().backgroundColor = .clear
        }
    }
}
/*
 
 private func setControllersInContainer(controllers: [UIViewController]) {
     /*
      let childViewController = ChildViewController()
      addChild(childViewController)
      containerView.addSubview(childViewController.view)
      childViewController.view.frame = containerView.bounds
      childViewController.didMove(toParent: self)
      */
//        self._controllerList = controllers
//        _tabBody.addSubview(self._controllerList.first!.view)
     
 }
 
 extension TabLayout :
     UICollectionViewDataSource,
     UICollectionViewDelegateFlowLayout
 {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         _controllerList.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         // Implement this method to return a valid UICollectionViewCell
         // For example:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBodyCell", for: indexPath) as! TabBodyCell
         let viewController = _controllerList[indexPath.item]
         viewController.view.frame = cell.contentView.bounds
         cell.contentView.addSubview(viewController.view)
         return cell
     }

     // Implement UICollectionViewDataSource and UICollectionViewDelegate methods here

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         changePageView(page: indexPath.item)
     }

 }

 class TabLayout : UIViewController{

     lazy var pageView : UIPageViewController = {
         let view = UIPageViewController(
             transitionStyle: .scroll,
             navigationOrientation: .horizontal,
             options: nil
         )
         view.didMove(toParent: self)
         view.view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()

     lazy var tabHeader: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0

         let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
         view.showsHorizontalScrollIndicator = false
         view.backgroundColor = .clear
         view.dataSource = self
         view.delegate = self
         view.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()

     var pageControllerCurrentIndex : Int = 0
     var controllers : [UIViewController] = []
     var tabList : [TabModel] = []
     var parentVC: UIViewController?
     init(
         setTabList : [TabModel],
         setControllers : [UIViewController],
         setPageControllerCurrentIndex : Int,
         setParentViewController: UIViewController
     ){
         super.init(nibName: nil, bundle: nil)
         self.tabList = setTabList
         self.controllers = setControllers
         self.pageControllerCurrentIndex = setPageControllerCurrentIndex
         self.parentVC = setParentViewController
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .clear
         initPageViewController()
         setupChildViewControllers()
     }


     private func setupChildViewControllers() {
         for controller in controllers {
             addChild(controller)
             controller.didMove(toParent: self)
         }
     }

     private func initPageViewController() {
         addChild(pageView)
         view.addSubview(pageView.view)
         view.addSubview(tabHeader)
         pageView.didMove(toParent: self)

         pageView.delegate = self
         pageView.dataSource = self
         pageView.setViewControllers(
             [controllers[pageControllerCurrentIndex]],
             direction: .forward,
             animated: false,
             completion: nil
         )

         NSLayoutConstraint.activate([
             tabHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: calculateMargin(padding: 0)),
             tabHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tabHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tabHeader.heightAnchor.constraint(equalToConstant: 50)
         ])

         NSLayoutConstraint.activate([
             pageView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             pageView.view.topAnchor.constraint(equalTo: tabHeader.bottomAnchor), // Adjust the constant value as needed
             pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])

         changePageView(page: 0)
     }


     func changePageView(page : Int){
         pageView.setViewControllers(
             [controllers[page]],
             direction: .forward,
             animated: false,
             completion: nil
         )
     }


     func animateTabCell(collectionView : UICollectionView, indexPath : IndexPath){
         // 모든 셀의 배경색을 초기화합니다.
         for visibleTabs in collectionView.indexPathsForVisibleItems {
             let cell = collectionView.cellForItem(at: visibleTabs) as? TabCell
             cell?.getLabelUnderline().backgroundColor = .clear
         }

         let cell = collectionView.cellForItem(at: indexPath) as? TabCell
         cell?.getLabelUnderline().backgroundColor = .textColour
     }

 }

 private func setControllersInContainer(controllers : [UIViewController]) {
     self.controllerList = controllers
     controllers.enumerated().forEach { (index, controller) in
         parentVC?.addChild(controller)
         addSubview(controller.view)
         controller.view.translatesAutoresizingMaskIntoConstraints = false
         controller.view.isHidden = index > 0
         NSLayoutConstraint.activate([
             controller.view.topAnchor.constraint(equalTo: tabBody.topAnchor),
             controller.view.leadingAnchor.constraint(equalTo: tabBody.leadingAnchor),
             controller.view.trailingAnchor.constraint(equalTo: tabBody.trailingAnchor),
             controller.view.bottomAnchor.constraint(equalTo: tabBody.bottomAnchor)
         ])
     }
 }

 private func changePageView(page : Int){
     delegate?.tabLayout(self, didSelectTabAt: page)
     for (index, controller) in controllerList.enumerated() {
         controller.view.isHidden = index != page
     }
 }

 private func animateTabCell(collectionView : UICollectionView, indexPath : IndexPath){
     // 모든 셀의 배경색을 초기화합니다.
     for visibleTabs in collectionView.indexPathsForVisibleItems {
         let cell = collectionView.cellForItem(at: visibleTabs) as? TabCell
         cell?.getLabelUnderline().backgroundColor = .clear
     }

     let cell = collectionView.cellForItem(at: indexPath) as? TabCell
     cell?.getLabelUnderline().backgroundColor = .textColour
 }
 
 lazy var _tabBody : UICollectionView = {
     let layout = UICollectionViewFlowLayout()
     layout.scrollDirection = .horizontal
     layout.minimumInteritemSpacing = 0
     layout.minimumLineSpacing = 0

     let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
     view.showsHorizontalScrollIndicator = false
     view.backgroundColor = .clear
     view.dataSource = self
     view.delegate = self
     view.register(TabBodyCell.self, forCellWithReuseIdentifier: "TabBodyCell")
     view.translatesAutoresizingMaskIntoConstraints = false
     return view
 }()
 
 
 private func removeFromMemory(childVC : UIViewController){
     // 부모에서 자식 뷰 컨트롤러를 제거
     childVC.willMove(toParent: nil)
     childVC.view.removeFromSuperview()
     childVC.removeFromParent()
//        childVC = nil
 }
 private func addChildAtMemory(childVC : UIViewController, parentVC : UIViewController){
     parentVC.addChild(childVC)
     _tabBody.addSubview(childVC.view)
     childVC.view.frame = _tabBody.bounds
     childVC.didMove(toParent: parentVC.self)
 }
 
 */

