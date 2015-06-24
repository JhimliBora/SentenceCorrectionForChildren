//
//  ViewController.swift
//  SentenceCorrectionForChildren
//
//  Created by Jhimli Bora on 27/01/2015.
//  Copyright (c) 2015 NewLearnings. All rights reserved.
//

import UIKit
//import "CorrectionTipViewController.swift"

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var SentenceTextView: UITextView!
    @IBOutlet var TotalMistakesTextField: UITextField!
    @IBOutlet var MessageLabel: UILabel!
    @IBOutlet var ImageKids: UIImageView!
    @IBOutlet var SentenceNumberTextField: UITextField!
    @IBOutlet var ResetButton:UIButton!
    @IBOutlet var NextButton:UIButton!
    @IBOutlet var TotalSentencesTextField: UITextField!
    @IBOutlet var ImageCongratulations: UIImageView!
    @IBOutlet var SentenceSetNumber: UITextField!
    
    var correctSentenceVariable=""
    var sentenceSetVariable=""
    
 
    var TipMessageText=""
   
    @IBAction func doneToMenuViewController(segue:UIStoryboardSegue)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func ResetButtonClicked(sender:AnyObject)
    {
         LoadSentence(SentenceNumberTextField.text.toInt()!-1)
    }
    
    @IBAction func NextButtonClickled(sender:AnyObject)
        
    {
       
          LoadSentence(SentenceNumberTextField.text.toInt()!)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SentenceTextView.delegate = self
        InitializeData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    func InitializeData()
    {
        //let fileURL = NSBundle.mainBundle().URLForResource("ImgKids", withExtension: "jpg")
        //let beginImage = CIImage(contentsOfURL: fileURL)
        //let newImage = UIImage(CIImage: beginImage)
       // ImageKids.image = newImage
        
        correctSentenceVariable = ""
        TotalMistakesTextField.text = "0"
        SentenceTextView.text = ""
        MessageLabel.text = "Set Not Found!!!"
        SentenceNumberTextField.text = ""
        TotalSentencesTextField.text=""
        SentenceSetNumber.text=sentenceSetVariable
        
        SentenceNumberTextField.font=UIFont.boldSystemFontOfSize(14)
        TotalSentencesTextField.font=UIFont.boldSystemFontOfSize(14)
        
        LoadSentence(0)
        //NextButton.setTitle("here", forState: UIControlState.Normal)
        
        
    }
    
    func LoadSentence(var SentenceNumber:Int)
    {
        
        let path = NSBundle.mainBundle().pathForResource("SentenceListRepository", ofType: "plist")
        let dict:AnyObject = NSDictionary(contentsOfFile: path!)!
        
        
        //var dictName = "Set"+" "+"\(SentenceSetNumber.text)"
        var dictName = SentenceSetNumber.text
        
        
        if ( dict.objectForKey(dictName) != nil )
        {
            SentenceNumberTextField.text = "\(SentenceNumber+1)"
            
            let SentenceDict1:AnyObject = dict.objectForKey(dictName)!
            TotalSentencesTextField.text = "\(SentenceDict1.count)"
            var dictName1 = "Sentence"+" "+"\(SentenceNumber)"
            let SentenceDict:AnyObject = SentenceDict1.objectForKey(dictName1)!

       
            if ( SentenceDict.objectForKey("IncorrectCount") != nil )
            {
              TotalMistakesTextField.text = SentenceDict.objectForKey("IncorrectCount") as! String
            }
        
            if ( SentenceDict.objectForKey("Incorrect") != nil )
            {
              SentenceTextView.text = SentenceDict.objectForKey("Incorrect") as! String
            }
        
            if ( SentenceDict.objectForKey("correct") != nil )
            {
              correctSentenceVariable = SentenceDict.objectForKey("correct") as! String
            }
        
            if ( SentenceDict.objectForKey("tip") != nil )
            {
              TipMessageText = SentenceDict.objectForKey("tip") as! String
            }

            MessageLabel.text = "NOTE: Correct the above sentence.Total Mistakes must be 0 for a correct sentence."
            MessageLabel.textColor = UIColor.blackColor()

      }
       /* else
        {
            SentenceNumberTextField.text=""
            TotalSentencesTextField.text=""
            
            TotalMistakesTextField.text = "0"
             SentenceTextView.text = ""
             correctSentenceVariable = ""
             TipMessageText = "-"
             MessageLabel.text = "Set Not Found!!!"
        }*/
      
        
        NextButton.enabled=false
        ResetButton.enabled=false
       
        
        let fileURL = NSBundle.mainBundle().URLForResource("ImgStart", withExtension: "png")
        let beginImage = CIImage(contentsOfURL: fileURL)
        let newImage = UIImage(CIImage: beginImage)
        ImageCongratulations.image = newImage
        
        
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText: String) -> Bool
    {
        
        if(replacementText == "\n")
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }


    func textViewDidEndEditing(textView: UITextView)
    {
        var a : Int
        a=compareSentences()
        TotalMistakesTextField.text = "\(a)"
        
        if TotalMistakesTextField.text.toInt()>0
        {
            if TotalMistakesTextField.text.toInt()>10
            {
                MessageLabel.text = "hmmm!!! too many mistakes buddy. Please click on Reset Button above and try again."
                MessageLabel.textColor = UIColor.blackColor()
                NextButton.enabled=false
                ResetButton.enabled=true
                let fileURL = NSBundle.mainBundle().URLForResource("ImgSad", withExtension: "png")
                let beginImage = CIImage(contentsOfURL: fileURL)
                let newImage = UIImage(CIImage: beginImage)
                ImageCongratulations.image = newImage
                
            }
            else
            {
                MessageLabel.text = "NOTE: Correct the above sentence.Total Mistakes must be 0 for a correct sentence."
                MessageLabel.textColor = UIColor.blackColor()
                NextButton.enabled=false
                ResetButton.enabled=true
            }
        }
        else
        {
           

            if ( SentenceNumberTextField.text.toInt()! + 1 <= TotalSentencesTextField.text.toInt())
            {
               MessageLabel.text = "Congratulations!!! You did it. Well Done.Now go to the Next Sentence."
               MessageLabel.textColor = UIColor.redColor()
               NextButton.enabled=true
            }
            else
            {
               MessageLabel.text = "Congratulations!!! Test Completes. Go back to Menu."
               MessageLabel.textColor = UIColor.redColor()
            }
                
               
            ResetButton.enabled=false
            
            let fileURL = NSBundle.mainBundle().URLForResource("ImgCongratulations", withExtension: "jpg")
            let beginImage = CIImage(contentsOfURL: fileURL)
            let newImage = UIImage(CIImage: beginImage)
            ImageCongratulations.image = newImage
            
            
            
        }
    }
    
    func compareSentences()->Int
    {
        var i:Int=0
        var IncorrectCount:Int=0
    
        
         for i=0; i<count(correctSentenceVariable);++i
         {
           
            let index = advance(correctSentenceVariable.startIndex, i)
            let index2 = advance(SentenceTextView.text.startIndex, i)
            
            println(index)
            println(index2)
            println(correctSentenceVariable[index])
            println(SentenceTextView.text[index2])
           
            if correctSentenceVariable[index] !=  SentenceTextView.text[index2]
            {
               ++IncorrectCount
             }
          }
       
          return IncorrectCount
    
       }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "CorrectionTipViewControllerSegue"
        {
            if let destinationVC = segue.destinationViewController as? CorrectionTipViewController
            {
                destinationVC.TipMessage = TipMessageText
                //No errors while passing to a variable instead of a IBOutlet
            }
        }


     }


}