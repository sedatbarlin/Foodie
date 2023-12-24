//
//  CustomTabBarViewController.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//

import UIKit

//MARK: TabBar öğemin tasarlanması

class CustomTabBarViewController: UIViewController {
    @IBOutlet weak var bottomTabView: UIView?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var selectedStateViews: [UIView]?
    
    var main: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Foodie"
        bottomTabView?.layer.cornerRadius = (bottomTabView?.frame.size.height ?? 0.0) / 2.0
        handleSelectedViews(current: 0)
        let controller = main.instantiateViewController(withIdentifier: String(describing: HomeViewController.self))
        handleConstraint(controller)
    }
    
    @IBAction func tabTapped(_ sender: UIButton) { //Tabbar'da bulunan 3 öğenin tıklanma özellikleri
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
    
    func handleConstraint(_ controller: UIViewController){
        addChild(controller)
        containerView.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    //views
    func handleSelectedViews(current state: Int){
        selectedStateViews?.forEach(){ selectedView in
            selectedView.isHidden = (selectedView.tag != state)
        }
    }
}
