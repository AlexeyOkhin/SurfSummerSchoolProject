//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var infoItem: UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            infoItem = try UserInfoStorage().getUserInfo()
        } catch {
            
        }
        
        print(infoItem)
        
        
    }
}
