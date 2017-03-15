//
//  ViewController.swift
//  tipcalc
//
//  Created by Sathya Venkataraman on 3/5/17.
//  Copyright © 2017 Sathya Venkataraman. All rights reserved.
//

import UIKit
import VSStepper

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var splitStepper: VSStepper!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!

    @IBOutlet weak var splitAmountLabel: UILabel!
    @IBOutlet weak var splitAmount: UILabel!

    @IBOutlet var scrollView: UIScrollView!
        
    let formatter = NumberFormatter()
    
    let percentPlistPath = NSHomeDirectory()+"/Documents/TipPercents.plist"
    let fileManager = FileManager.default
    var dictionary : NSMutableDictionary!
    var tipPercent:[Double] = [10,20,30]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //splitNum.text = String(1)
        splitAmount.isHidden = true
        splitAmountLabel.isHidden = true
        
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        

        splitStepper.addTarget(self, action: #selector(ViewController.splitVAlueChanged), for: .valueChanged)
  
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: UIControlState.selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: UIControlState.normal)

       // view.addBackground()
        
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
        
       // billField.keyboardType = UIKeyboardType.numbersAndPunctuation
        
    }
    
    
    func setFontSize(){
        
        var fontSize = 10
        let fontName = "HelveticaNeue-Bold"
        
        if (UIDevice.current.orientation.isLandscape) {
            if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact){
                fontSize = 17
            }
        }
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: CGFloat(fontSize))!], for: UIControlState.normal)
        UISegmentedControl.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: CGFloat(fontSize))!], for: UIControlState.selected)

        splitStepper.labelFont = UIFont(name: fontName, size: CGFloat(fontSize))!
        splitStepper.buttonsFont = UIFont(name: fontName, size: CGFloat(fontSize))!
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        print("view did appear ****")
        self.tabBarController?.navigationItem.title = "Tip Calc"
        checkFile()
        dictionary = NSMutableDictionary(contentsOfFile: percentPlistPath)
        read()
        calcTip()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
    @IBAction func splitVAlueChanged(_ sender: Any) {
    
 //       let splitNo = Double(splitStepper.value)
        
//        if splitNo <= 1 {
//            splitAmount.isHidden = true
//            splitAmountLabel.isHidden = true
//        } else {
//            splitAmount.isHidden = false
//            splitAmountLabel.isHidden = false
//        }
        calcTip()
    }
    
    func calcTip(){
        
        let splitValue:Int = Int(splitStepper.value)        

        let billAmt = Double(billField.text!) ?? 0
        
        let tip = billAmt * (tipPercent[tipControl.selectedSegmentIndex] / 100)
        let total = billAmt + tip
        let splitAmt = total / Double(splitValue)
        
        if let formattedTipAmount = formatter.string(from: tip as NSNumber) {
            tipLabel.text = "\(formattedTipAmount)"
        }
        
        
        if let totalAmt = formatter.string(from: total as NSNumber) {
            totalLabel.text = "\(totalAmt)"
        }
        
//        print(splitValue)
//        print(billAmt)
        if splitValue <= 1 {
            splitAmount.isHidden = true
            splitAmountLabel.isHidden = true
        } else {
            if (billAmt > 0 ) {
                splitAmount.isHidden = false
                splitAmountLabel.isHidden = false
                splitAmount.text = String(format: "$%.2f",splitAmt)
            }
        }
        
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calcTip()
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)    }

    func initTipPercent(){
        read()
        
    }

   
    func checkFile() {
        
        if !fileManager.fileExists(atPath: percentPlistPath) {
            print("File not exist!")
            let srcPath = Bundle.main.path(forResource: "TipPercents", ofType: "plist")!
            do {
                //Copy the project plist file to the documents directory.
                try fileManager.copyItem(atPath: srcPath, toPath: percentPlistPath)
            } catch {
                print("File copy error!")
            }
        }
    }
    
    func read() {
        print("This is in read")
        let percent1 = "\(dictionary!.object(forKey: "percent1")!)"
        let percent2 = "\(dictionary!.object(forKey: "percent2")!)"
        let percent3 = "\(dictionary!.object(forKey: "percent3")!)"
        print(percent1, percent2,percent3)
        
        if (tipPercent.count>0){
            tipPercent.removeAll()
        }
        tipPercent.append(Double(percent1) ?? 10)
        tipPercent.append(Double(percent2) ?? 10)
        tipPercent.append(Double(percent3) ?? 10)
    
        
        tipControl.setTitle(percent1+"%", forSegmentAt: 0)
        tipControl.setTitle(percent2+"%", forSegmentAt: 1)
        tipControl.setTitle(percent3+"%", forSegmentAt: 2)

    }
    
    @IBAction func cancelEdit(segue:UIStoryboardSegue){
    }
    
    @IBAction func saveEdit(segue:UIStoryboardSegue){
        //tableView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
          setFontSize()
    }
    
//    func write() {
//        dictionary.setValue(num, forKey: "Num")
//        dictionary.writeToFile(path, atomically: true)
//        print("write")
//    }

}
