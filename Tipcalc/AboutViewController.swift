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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        let urlRequest = NSURLRequest(url: NSURL(string: "https://www.linkedin.com/in/sathya-venkataraman-1667041")! as URL)
//        LinkedinView.loadRequest(urlRequest as URLRequest)
//        LinkedinView.isUserInteractionEnabled = true
//        LinkedinView.scrollView.isScrollEnabled = true
//        print(self.view.bounds.size)
//        let mainViewSize = self.view.bounds.size
//        self.scrollView.contentSize = CGSize(width: mainViewSize.width * 1.1, height:mainViewSize.height * 2)
//        // Do any additional setup after loading the view.
//        self.scrollView.isScrollEnabled = true
//        self.contentView.sizeThatFits(CGSize(width: mainViewSize.width * 0.9, height:mainViewSize.height * 0.9))
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
