//
//  NavigationDismiss.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 25/12/20.
//

import UIKit

protocol NavigationDismissalDelegate {
    func handleDismissal()
}

class NavigationDismiss: UIView {
    var delegate: NavigationDismissalDelegate!
    
    private lazy var NavigationDissmisalView: UIView = {
        let view = UIView()
        view.backgroundColor = .themeColor
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 62, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        
        view.addSubview(movieTitle)
        movieTitle.anchor(top: view.topAnchor, left: backButton.rightAnchor, paddingTop: 62, paddingLeft: 25)
                
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        
        return button
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 1
        label.text = "Favourite Movie"
        
        return label
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
        
        addSubview(NavigationDissmisalView)
        NavigationDissmisalView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 120)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
}
