//
//  CustomTabBarViewController.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//

import UIKit

//MARK: TabBar öğemin tasarlanması

final class CustomTabBarViewController: UIViewController {
    @IBOutlet private weak var bottomTabView: UIView?
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private var selectedStateViews: [UIView]?
    
    private var main: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Foodie"
        callHome()
        configureTabView()
    }
    private func callHome(){
        let controller = main.instantiateViewController(withIdentifier: String(describing: HomeViewController.self))
        handleConstraint(controller)
    }
    private func configureTabView(){
        bottomTabView?.layer.cornerRadius = (bottomTabView?.frame.size.height ?? 0.0) / 2.0
        handleSelectedViews(current: 0)
    }
    @IBAction private func tabTapped(_ sender: UIButton) { //Tabbar'da bulunan 3 öğenin tıklanma özellikleri
        var controller: UIViewController!
        let tag = sender.tag
        //handle view bottom
        handleSelectedViews(current: tag)
        if tag == 0{
            controller = main.instantiateViewController(withIdentifier: String(describing: HomeViewController.self))
            handleConstraint(controller)
        }else if tag == 1{
            controller = main.instantiateViewController(withIdentifier: String(describing: CartViewController.self))
        }else if tag == 2{
            controller = main.instantiateViewController(withIdentifier: String(describing: ProfileViewController.self))
        }
        handleConstraint(controller)
    }
    
    private func handleConstraint(_ controller: UIViewController){
        addChild(controller)
        containerView.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    //views
    private func handleSelectedViews(current state: Int){
        selectedStateViews?.forEach(){ selectedView in
            selectedView.isHidden = (selectedView.tag != state)
        }
    }
}
