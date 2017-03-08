//
//  AboutViewController.swift
//  tipcalc
//
//  Created by Sathya Venkataraman on 3/5/17.
//  Copyright © 2017 Sathya Venkataraman. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var LinkedinView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlRequest = NSURLRequest(url: NSURL(string: "https://www.linkedin.com/in/sathya-venkataraman-1667041")! as URL)
        LinkedinView.loadRequest(urlRequest as URLRequest)
        LinkedinView.isUserInteractionEnabled = true
        LinkedinView.scrollView.isScrollEnabled = true

        // Do any additional setup after loading the view.
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
