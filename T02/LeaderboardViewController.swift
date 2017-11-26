//
//  LeaderboardViewController.swift
//  T02
//
//  Created by MYERS BENJAMIN D on 11/3/17.
//  Copyright © 2017 Brightest Orange. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    let red = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0)
    let yellow = UIColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
    let blue = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
    let green = UIColor(red: 0.42, green: 0.66, blue: 0.31, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = red
        self.navigationController?.navigationBar.tintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Just tell me what", size: 20) ?? nil, NSAttributedStringKey.foregroundColor:UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
