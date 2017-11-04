//
//  ScheduleTableViewController.swift
//  test
//
//  Created by WOOD SAMUEL R on 10/29/17.
//  Copyright © 2017 wosa. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {
    
    let red = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0)
    let yellow = UIColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
    let blue = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
    let green = UIColor(red: 0.42, green: 0.66, blue: 0.31, alpha: 1.0)
    
    let pick = UIDatePicker()
    let dateFormatter = DateFormatter()
    var days : [(day: String, timeIn: String, timeOut: String, dateIn: Bool, dateOut: Bool, showTime: Bool)] = []
    var pickerIn : [UIDatePicker] = []
    
    var pickerOut : [UIDatePicker] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Toolbar formatting
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = yellow
        self.navigationController?.navigationBar.tintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        // Actual scheduler logic
        
        dateFormatter.timeStyle = .short
        
        days = [(day: "Monday", timeIn: "9:00 AM", timeOut: "5:00 PM", dateIn: false, dateOut: false, showTime: true),
                (day: "Tuesday", timeIn: "9:00 AM", timeOut: "5:00 PM", dateIn: false, dateOut: false, showTime: true),
                (day: "Wednesday", timeIn: "9:00 AM", timeOut: "5:00 PM", dateIn: false, dateOut: false, showTime: true),
                (day: "Thursday", timeIn: "9:00 AM", timeOut: "5:00 PM", dateIn: false, dateOut: false, showTime: true),
                (day: "Friday", timeIn: "9:00 AM", timeOut: "5:00 PM", dateIn: false, dateOut: false, showTime: true),
                (day: "Saturday", timeIn: "9:00 AM", timeOut: "5:00 PM", dateIn: false, dateOut: false, showTime: true),
                (day: "Sunday", timeIn: "9:00 AM", timeOut: "5:00 PM", dateIn: false, dateOut: false, showTime: true)]
        for i in 0...6
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm a"
            var timeDefault = formatter.date(from: days[i].timeIn)
            let picker1 = UIDatePicker()
            picker1.datePickerMode = UIDatePickerMode.time
            picker1.frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
            picker1.date = timeDefault!
            pickerIn.append(picker1)
            
            let picker2 = UIDatePicker()
            picker2.datePickerMode = UIDatePickerMode.time
            picker2.frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
            picker2.minimumDate = (timeDefault)
            timeDefault = formatter.date(from: days[i].timeOut)
            picker2.date = timeDefault!
            
            pickerOut.append(picker2)
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return days.count
    }
    
    /*
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableCell(withIdentifier: "header")
        header?.textLabel?.text = days[section].day
        return header
    }
   */
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = .lightGray
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = .orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = .blue
        
        return [share, favorite, more]
    }
    
    /*
     override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
     days[indexPath[0]].showTime = !days[indexPath[0]].showTime
     }*/
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        print("oh \(section)")
        if days[section].showTime{
            let button: UIButton = UIButton.init(frame: CGRect(x: view.frame.width * 0.85, y:0 , width: view.frame.width/10, height: view.frame.height * 0.9))
            button.titleLabel?.text = "\(section)"
            button.titleLabel?.isHidden = true
            button.setBackgroundImage(UIImage.init(named: "subtract"), for: UIControlState.normal)
            button.addTarget(self, action: #selector(subtractPressed), for: UIControlEvents.touchUpInside)
            view.addSubview(button)
        }
        else{
            let button: UIButton = UIButton.init(frame: CGRect(x: view.frame.width * 0.85, y: 0 , width: view.frame.width/10, height: view.frame.height * 0.9))
            print(view.frame)
            button.titleLabel?.text = "\(section)"
            button.titleLabel?.isHidden = true
            button.setBackgroundImage(UIImage.init(named: "add"), for: UIControlState.normal)
            button.addTarget(self, action: #selector(addPressed), for: UIControlEvents.touchUpInside)
            view.addSubview(button)
        }
    }
    
    @objc func subtractPressed(sender: UIButton){
        let section : Int = Int((sender.titleLabel?.text)!)!
        days[section].showTime = false
        self.tableView.reloadSections([section], with: UITableViewRowAnimation.automatic)
        let delay = 200
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay), execute: {
            self.tableView.reloadData()
        })
        //self.tableView.reloadSections([section], with: UITableViewRowAnimation.automatic)
        
    }
    
    @objc func addPressed(sender: UIButton){
        let section : Int = Int((sender.titleLabel?.text)!)!
        days[section].showTime = true
        self.tableView.reloadSections([section], with: UITableViewRowAnimation.automatic)
        let delay = 200
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay), execute: {
            self.tableView.reloadData()
        })
        //self.tableView.reloadSections([section], with: UITableViewRowAnimation.automatic)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if days[section].showTime{
            if days[section].dateIn && days[section].dateOut{ return 4 }
            else if days[section].dateIn || days[section].dateOut{ return 3 }
            else{ return 2 }
        }
        else{
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        if indexPath[1] == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
            cell.textLabel?.text = "Time In"
            cell.detailTextLabel?.text = days[indexPath[0]].timeIn
        }
        else if indexPath[1] == 1{
            if days[indexPath[0]].dateIn{
                cell = tableView.dequeueReusableCell(withIdentifier: "datePicker", for: indexPath)
                cell.contentView.removeFromSuperview()
                let view : [UIView] = (cell.subviews)
                for i in view{
                    i.removeFromSuperview()
                }
                pickerIn[indexPath[0]].frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
                //pickerIn[indexPath[0]].date = formatter.date(from: days[indexPath[0]].timeIn)!
                cell.addSubview(pickerIn[indexPath[0]])
                
            }
            else{
                cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
                cell.textLabel?.text = "Time Out"
                cell.detailTextLabel?.text = days[indexPath[0]].timeOut
            }
        }
        else if indexPath[1] == 2{
            
            if days[indexPath[0]].dateIn{
                cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
                cell.textLabel?.text = "Time Out"
                cell.detailTextLabel?.text = days[indexPath[0]].timeOut
            }
            else{
                cell = tableView.dequeueReusableCell(withIdentifier: "datePicker", for: indexPath)
                cell.contentView.removeFromSuperview()
                let view : [UIView] = (cell.subviews)
                for i in view{
                    i.removeFromSuperview()
                }
                pickerOut[indexPath[0]].frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
                //pickerOut[indexPath[0]].date = formatter.date(from: days[indexPath[0]].timeOut)!
                cell.addSubview(pickerOut[indexPath[0]])
                
            }
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "datePicker", for: indexPath)
            cell.contentView.removeFromSuperview()
            let view : [UIView] = (cell.subviews)
            for i in view{
                i.removeFromSuperview()
            }
            pickerOut[indexPath[0]].frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            //pickerOut[indexPath[0]].date = formatter.date(from: days[indexPath[0]].timeOut)!
            cell.addSubview(pickerOut[indexPath[0]])
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section].day
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath[0]
        let row = indexPath[1]
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        if days[section].dateIn && days[section].dateOut{
            if row == 0{
                days[section].dateIn = false
                days[section].timeIn = dateFormatter.string(from: pickerIn[section].date)
                pickerOut[section].minimumDate = pickerIn[section].date
                if formatter.date(from: days[section].timeIn)! > formatter.date(from: days[section].timeOut)! {
                    days[section].dateOut = true
                }
            }
            else if row == 2{
                days[section].dateOut = false
                days[section].timeOut = dateFormatter.string(from: pickerOut[section].date)
                pickerIn[section].maximumDate = pickerOut[section].date
                if formatter.date(from: days[section].timeOut)! < formatter.date(from: days[section].timeIn)! {
                    days[section].dateIn = true
                }
            }
        }
        else if days[section].dateIn{
            if row == 0 {
                days[section].dateIn = false
                days[section].timeIn = dateFormatter.string(from: pickerIn[section].date)
                pickerOut[section].minimumDate = pickerIn[section].date
                if formatter.date(from: days[section].timeIn)! > formatter.date(from: days[section].timeOut)! {
                    days[section].dateOut = true
                }
            }
            else if row == 2{
                days[section].dateOut = true
            }
        }
        else if days[section].dateOut{
            if row == 0 {
                days[section].dateIn = true
            }
            else if row == 1{
                days[section].dateOut = false
                days[section].timeOut = dateFormatter.string(from: pickerOut[section].date)
                pickerIn[section].maximumDate = pickerOut[section].date
                if formatter.date(from: days[section].timeOut)! < formatter.date(from: days[section].timeIn)! {
                    days[section].dateIn = true
                }
            }
        }
        else{
            if row == 0{
                days[section].dateIn = true
            }
            else if row == 1{
                days[section].dateOut = true
            }
        }
        
        self.tableView.reloadSections([indexPath[0]], with: UITableViewRowAnimation.automatic)
        let delay = 200
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay), execute: {
            self.tableView.reloadData()
        })
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
