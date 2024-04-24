//
//  GamesViewController.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol!
    let configurator: HomeConfiguratorProtocol = HomeConfigurator()
    
    private var greetingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greeting")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Welcome to Chamala!
        Study Tatar playing games!
        """
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Futura Bold",
                            size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var startButton: StandartButton = {
        let button = StandartButton()
        button.setTitle("Select game",
                        for: .normal)
        button.setBackgroundColor(UIColor(named: "green")!)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    private lazy var gamePopUp: PopUp = {
        let popUp = PopUp()
        popUp.createButtonsWithTitles(with: ["Mode 1",
                                            "Mode 2",
                                            "Mode 3"])
        popUp.delegate = self
        popUp.baseLayout()
        return popUp
    }()
}

extension HomeViewController: HomeViewProtocol {
    
    func presentGamePopUP() {
        view.presentPopUp(popUp: gamePopUp,
                          size: .big)
    }
    
    func setUpView() {
        view.backgroundColor = .white
        
        [stackView,
         startButton].forEach { sV in
            view.addSubview(sV)
            sV.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // MARK: - stack
        stackView.addArrangedSubviews(greetingImageView,
                                      greetingLabel)
        
        NSLayoutConstraint.activate([stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     stackView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                                      multiplier: 0.8),
                                     stackView.heightAnchor.constraint(equalTo: view.widthAnchor,
                                                                       multiplier: 0.8)])
        
        // MARK: - button
        NSLayoutConstraint.activate([startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                        constant: -40),
                                    
                                     startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                         constant: 16),
                                     startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                          constant: -16),
                                    
                                     startButton.heightAnchor.constraint(equalToConstant: 59)])
        
        startButton.addTarget(self,
                              action: #selector(goToGameSelection),
                              for: .touchUpInside)
        
    }
    
    @objc func goToGameSelection() {
        presenter.presentGamePopUp()
    }
}

extension HomeViewController: PopUpDelegate {
    @objc func gameButtonPressed(_ sender: UIButton) {
        presenter.gameButtonPressed(sender)
    }
}
