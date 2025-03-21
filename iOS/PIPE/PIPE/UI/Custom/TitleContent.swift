//
//  TitleContent.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/08/23.
//

import Foundation
import UIKit

class TitleContent : UIView {
    
    let container : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let title : UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.required, for: .horizontal) // 추가된 부분
        return view
    }()
    
    private func setUI(setContentView : UIView){
        addSubview(container)
        container.addSubview(title)
        container.addSubview(setContentView)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            title.topAnchor.constraint(equalTo: container.topAnchor),
            title.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            setContentView.topAnchor.constraint(equalTo: container.topAnchor),
            setContentView.leadingAnchor.constraint(equalTo: title.trailingAnchor),
            setContentView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }
    
    init(
        setTitle : String,
        setContent : UIView
    ){
        super.init(frame: .zero)
        title.text = setTitle
        setUI(setContentView: setContent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

