//
//  CorrectionTipViewController.swift
//  SentenceCorrectionForChildren
//
//  Created by Jhimli Bora on 5/02/2015.
//  Copyright (c) 2015 NewLearnings. All rights reserved.
//

import Foundation
import UIKit


class CorrectionTipViewController: UIViewController
    
{
    var TipMessage = ""
    //var delegate: CorrectionTipViewControllerDelegate?
    @IBOutlet var DoneButton:UIButton!
    @IBOutlet var CorrectionTipTextView:UITextView!
    
    @IBAction func doneToCorrectionViewController(segue:UIStoryboardSegue)
    {
       dismissViewControllerAnimated(true, completion: nil)
    }
    
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        CorrectionTipTextView.text=TipMessage

       
    }
    
      
    

}