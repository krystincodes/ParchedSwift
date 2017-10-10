//
//  Copyright © 2017 Krystin Stutesman. All rights reserved.
//

import UIKit

class SetupViewController: BaseViewController, UITextFieldDelegate, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let screenSize = UIScreen.main.bounds
        addScrollView(screenSize)
        addFirstSection(screenSize)
        addSecondSection(screenSize)
        addThirdSection(screenSize)
        
//        Constraints
        
        
//        Colors
        
    }
    
    //    MARK: View Setup
    private func addScrollView(_ screenSize: CGRect) {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        scrollView.delegate = self
        
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addFirstSection(_ screenSize: CGRect) {
        let container = UIView(frame: screenSize)
        container.backgroundColor = .red
//        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(container)
        
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        container.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Parched!"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        container.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16)
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 32)
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor, constant: -16)
    }
    
    private func addSecondSection(_ screenSize: CGRect) {
        let container = UIView(frame: screenSize)
        container.backgroundColor = .blue
        //        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(container)
        
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        container.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
    }
    
    private func addThirdSection(_ screenSize: CGRect) {
        let container = UIView(frame: screenSize)
        container.backgroundColor = .green
        //        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(container)
        
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        container.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
    }
    
    private func nextStep() {
        
    }
}

// MARK: - ScrollViewDelegate
//class SetupViewController: UIScrollViewDelegate {
//    scroll
//}

