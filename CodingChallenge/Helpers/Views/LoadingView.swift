//
//  LoadingView.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    private let indicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(indicator)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard superview != nil else { return }
        size = CGSize(width: indicator.width + 20, height: indicator.height + 20)
        layer.cornerRadius = height/2
        indicator.frame.origin = CGPoint(x: width/2 - indicator.width/2, y: height/2 - indicator.height/2)
        indicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        guard let window = SceneDelegate.delegate?.window, superview == nil else { return }
        window.addSubview(self)
        frame.origin = CGPoint(x: window.frame.width/2 - indicator.width/2, y: window.frame.height/2 - indicator.height/2)
        window.addSubview(self)
        setNeedsLayout()
    }
    
    func hide(){
        indicator.stopAnimating()
        removeFromSuperview()
    }
}

private let loadingView = LoadingView()

func loading(_ show: Bool) {
    if show {
        loadingView.show()
    }else {
        loadingView.hide()
    }
}


func loading(_ show: Bool, delay: Double = 2, completion: @escaping () -> Void ) {
    
    if show {
        loadingView.show()
        
    }else {
        loadingView.hide()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        completion()
    }
}
