//
//  ViewController.swift
//  UiElementsProgrametically
//
//  Created by Abhi on 12/1/18.
//  Copyright © 2018 Abhishek Prajapati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let square = UIView(frame: CGRect(x: self.view.frame.width/2 - 50, y: self.view.frame.height/2 - 50, width: 100, height: 100))
        square.backgroundColor = UIColor.red
        
        self.view.addSubview(square)
    }


}

