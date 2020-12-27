//
//  NavigationTop.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 25/12/20.
//

import UIKit

protocol NavigationTopDelegate {
    func handleListFavourite()
}

class NavigationTop: UIView {
    
    var delegate_navtop: NavigationTopDelegate!
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .themeColor
        
        view.addSubview(favouriteList)
        favouriteList.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: 74, paddingRight: 32)
        
        view.addSubview(appName)
        appName.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 64, paddingLeft: 22)
        
        return view
    }()
    
    private let appName: UILabel = {
        let user = UILabel()
        user.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        user.textColor = .white
        user.numberOfLines = 0
        user.text = "Movie Land"
        
       return user
    }()
    
    private let favouriteList: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "fav_love").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        btn.imageEdgeInsets = UIEdgeInsets(top: 28, left: 28, bottom: 28, right: 28)
        btn.addTarget(self, action: #selector(handleListFavourite), for: .touchUpInside)
        
       return btn
    }()
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            for subview in subviews {
                if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                    return true
                }
            }
            return false
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 120)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleListFavourite() {
//        print("List Favourite Tapped")
        delegate_navtop?.handleListFavourite()
    }
}
