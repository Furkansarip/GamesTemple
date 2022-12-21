//
//  LoadingManager.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 18.12.2022.
//

import UIKit

//MARK: - Loading
protocol Loading {
    func show()
    func hide()
}

// MARK: - LoadingManager
final class LoadingManager: Loading {
    
    // MARK: Properties
    static let shared: LoadingManager = .init()
    
    enum Constants {
        static let cornerRadius = 8.0
        static let loadingViewWidth = 74.0
        static let loadingViewHeight = 74.0
        static let activtyIndicatorWidth = 66.0
        static let activtyIndicatorHeight = 66.0
    }
    
    // MARK: Views
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .black
        return activityIndicator
    }()
}

// MARK: - Functions
extension LoadingManager {
    /// Show loading view
    func show() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.setupLoadingView(on: window)
                }
            }
        }
    }
    
    /// Hide loading view
    func hide() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    
                    self.loadingView.removeFromSuperview()
                    window.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    private func setupLoadingView(on window: UIWindow) {
        window.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        window.bringSubviewToFront(loadingView)
        window.isUserInteractionEnabled = false
        
        loadingView.setConstarint(
            centerX: window.centerXAnchor,
            centerY: window.centerYAnchor,
            width: Constants.loadingViewWidth,
            height: Constants.loadingViewHeight
        )
        
        activityIndicator.setConstarint(
            centerX: loadingView.centerXAnchor,
            centerY: loadingView.centerYAnchor,
            width: Constants.activtyIndicatorWidth,
            height: Constants.activtyIndicatorHeight
        )
    }
}


extension UIView {
    /// Setup your view's constaints
    func setConstarint(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        topConstraint: CGFloat? = nil,
        leadingConstraint: CGFloat? = nil,
        bottomConstraint: CGFloat? = nil,
        trailingConstraint: CGFloat? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top, let topConstraint = topConstraint {
            self.topAnchor.constraint(equalTo: top, constant: topConstraint).isActive = true
        }
        
        if let leading = leading, let leadingConstraint = leadingConstraint {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingConstraint).isActive = true
        }
        
        if let bottom = bottom, let bottomConstraint = bottomConstraint {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstraint).isActive = true
        }
        
        if let trailing = trailing, let trailingConstraint = trailingConstraint {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstraint).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
