//
//  BaseViewController.swift
//  PDP_StoryboardContact
//
//  Created by Otabek Tuychiev Muzaffar Ugli on 19/02/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Methods...
    
    private func appDelegate() -> AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    private func sceneDelegate() -> SceneDelegate {
        (UIApplication.shared.connectedScenes.first! .delegate as? SceneDelegate)!
    }

}
