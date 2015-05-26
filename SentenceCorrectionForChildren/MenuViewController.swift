//
//  MenuViewController.swift
//  SentenceCorrectionForChildren
//
//  Created by Jhimli Bora on 6/02/2015.
//  Copyright (c) 2015 NewLearnings. All rights reserved.
//


import UIKit


class MenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate

{
   
    @IBOutlet var tableView: UITableView!
    var textMesseges = [String]()
    var totalItems:Int  = 0
    var SelectedRowNumber:Int=0
    var valueToPass:String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getMenuListData()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }

    func getMenuListData()
    {
        
       /* let path = NSBundle.mainBundle().pathForResource("MenuListRepository", ofType: "plist")
        let dict:AnyObject = NSDictionary(contentsOfFile: path!)!
        var dictName="Batches"
        let MenuDict:AnyObject = dict.objectForKey(dictName)!
        
        
        var jCount:Int=0
        if ( MenuDict.objectForKey("Easy") != nil )
        {
           
           jCount = MenuDict.objectForKey("Easy") as! Int

        }
        
      /*  var iCount:Int = 0
        for iCount=0; iCount<jCount ;++iCount
        {
            textMesseges.append("Sentence Set - " + "\(iCount+1)")
        }*/
        */
        textMesseges.append("Easy" )
        textMesseges.append("Medium" )
        textMesseges.append("Advance" )
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "SentenceCorrectionViewControllerSegue"
        {
            let SentenceCorrection = segue.destinationViewController as!  ViewController
            
            if let blogIndex = tableView.indexPathForSelectedRow()?.row
               {
               
                 // SentenceCorrection.sentenceSetVariable = "\(blogIndex + 1)"
                SentenceCorrection.sentenceSetVariable = valueToPass
               // println(SentenceCorrection.sentenceSetVariable)
                 // NSLog("did select and the text is \(blogIndex)")
                }
            else
                {
                  SentenceCorrection.SentenceSetNumber.text = "1"
                }
            }
        

        }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return  textMesseges.count
        
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell
    {
            let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier:"UITableViewCell")
        
        
        
            cell.textLabel?.text = textMesseges[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
        
        valueToPass = currentCell.textLabel!.text
        self.performSegueWithIdentifier("SentenceCorrectionViewControllerSegue", sender: tableView)
               
    }
    
    }