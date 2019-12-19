//
//  TableMenuViewController.swift
//  kissa_eatIn
//
//  Created by Tomohiro Hori on 2019/07/02.
//  Copyright © 2019 Tomihiro Hori. All rights reserved.
//

import UIKit
import Firebase

class TableMenuViewController: UIViewController {

    @IBOutlet var tableButtonCollection: [UIButton]!
    var orderNumber : String?
    var DBRef:DatabaseReference!
    var tableStatus : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        DBRef = Database.database().reference()
        Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(self.status(_:)),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func status(_ sender: Timer) {
      for tableButton in tableButtonCollection {
        let tableNumber = Int(tableButton.titleLabel!.text!)
        let defaultPlace = DBRef.child("table/table").child(String(tableNumber!))
        defaultPlace.observe(.value, with: { snapshot in
            self.tableStatus = (snapshot.value! as AnyObject).description
            if self.tableStatus! == self.orderNumber! {
            tableButton.backgroundColor = UIColor(red:0.96, green:0.87, blue:0.90, alpha:1.0)
          } else if self.tableStatus! == "0" {
            tableButton.backgroundColor = UIColor(red:0.81, green:0.91, blue:0.92, alpha:1.0)
            } else if self.tableStatus! == "5" {
                tableButton.backgroundColor = UIColor(red:0.79, green:0.78, blue:0.87, alpha:1.0)
            } else {
            tableButton.backgroundColor = UIColor.lightGray
          }
        })
      }
    }

    @IBAction func tableSelect(_ sender: UIButton) {
        let tableNumber = sender.titleLabel!.text
        let defaultPlace = DBRef.child("table/table").child(String(tableNumber!))
      defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
        self.tableStatus = (snapshot.value! as AnyObject).description
        if self.orderNumber == "999"{
            if self.tableStatus! == "5" {
                defaultPlace.setValue(0)
            } else if self.tableStatus! == "0" {
                defaultPlace.setValue(5)
            } else {
                let alertController = UIAlertController(title: "空席",message: "座席を空席にします", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                    defaultPlace.setValue(0)
                }
                let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
                alertController.addAction(okAction)
                alertController.addAction(cancelButton)
                self.present(alertController,animated: true,completion: nil)
            }
        } else {
            if self.tableStatus! == self.orderNumber! {
                defaultPlace.setValue(0)
            } else if self.tableStatus! == "0" {
                defaultPlace.setValue(self.orderNumber!)
            }
        }
      })
    }

    @IBAction func exitButton(_ sender: UIButton) {
      self.dismiss(animated: true, completion: nil)
    }

}
