//
//  LaunchScreen_VC.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/29/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit

class ViewConroller: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
    }
    


}
