//
//  SetupViewController.swift
//  tipcalc
//
//  Created by Sathya Venkataraman on 3/6/17.
//  Copyright © 2017 Sathya Venkataraman. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var tip1: UITextField!

    @IBOutlet weak var tip2: UITextField!
    @IBOutlet weak var tip3: UITextField!
    
    
    let percentPlistPath = NSHomeDirectory()+"/Documents/TipPercents.plist"
    let fileManager = FileManager.default
    var dictionary : NSMutableDictionary!
    var tipPercent:[Double] = [10,20,30]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        checkFile()
        dictionary = NSMutableDictionary(contentsOfFile: percentPlistPath)
        read()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateTipPercent(_ sender: Any) {
        
        view.endEditing(true)    
        let tipPercent1 = Double(tip1.text!) ?? 0
        let tipPercent2 = Double(tip2.text!) ?? 0
        let tipPercent3 = Double(tip3.text!) ?? 0
        
        if ( tipPercent1 == 0 || tipPercent2 == 0 || tipPercent3 == 0){
            alertMessage(header: "Invalid %", body: "One of the % entered is invalid. It must be valid decimal and no '%' sign or special characters allowed")
            
        } else {
            savePercentValues(per1: NSNumber(value:tipPercent1), per2: NSNumber(value:tipPercent2), per3: NSNumber(value:tipPercent3))
        }
        
    }
    
    func alertMessage(header:String, body:String){
        
        let alertController = UIAlertController(title: header, message:
            body, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
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
        
        tip1.text = percent1
        tip2.text = percent2
        tip3.text = percent3
    }
    
    func savePercentValues(per1:NSNumber, per2:NSNumber, per3:NSNumber) {
        
        dictionary.setValue(per1, forKey: "percent1")
        dictionary.setValue(per2, forKey: "percent2")
        dictionary.setValue(per3, forKey: "percent3")
        dictionary.write(toFile: percentPlistPath, atomically: true)
        print("Writtent to plist")
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
