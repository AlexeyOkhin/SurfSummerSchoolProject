//
//  TestAuthViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 17.08.2022.
//

import UIKit

class TestAuthViewController: UIViewController {
    
    //MARK: - IBUutlet constraints
    
    @IBOutlet weak var keybordUpConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginLeftConstraint: NSLayoutConstraint!
    
    //MARK: - IBOutlets Views
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var surfBackgrroundImage: UIImageView!
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var loginFloatingLabel: UILabel!
    @IBOutlet weak var devidedLoginView: UIView!
    @IBOutlet weak var errorLoginLabel: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordFloatingLabel: UILabel!
    @IBOutlet weak var deviderPasswordLabel: UIView!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingIndicatorImage: UIImageView!
    
    @IBOutlet weak var passwordSecurityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
}



