//
//  SubViewController.swift
//  kissa_eatIn
//
//  Created by Kei Kawamura on 2018/09/03.
//  Modified by Tomohiro Hori from 2019/03/14~.
//  Copyright © 2018 Kei Kawamura / 2019 Tomohiro Hori . All rights reserved.
//

import Foundation
import UIKit
import Firebase
class SubViewController: UITableViewController{
    //ラベルのコネクション
    @IBOutlet weak var W1AmountLabel: UILabel!
    @IBOutlet weak var W2AmountLabel: UILabel!
    @IBOutlet weak var P1AmountLabel: UILabel!
    @IBOutlet weak var P2AmountLabel: UILabel!
    @IBOutlet weak var S1AmountLabel: UILabel!
    @IBOutlet weak var S2AmountLabel: UILabel!
    @IBOutlet weak var S3AmountLabel: UILabel!
    @IBOutlet weak var D1AmountLabel: UILabel!
    
    @IBOutlet weak var W1StepperValue: UIStepper!
    @IBOutlet weak var W2StepperValue: UIStepper!
    @IBOutlet weak var P1StepperValue: UIStepper!
    @IBOutlet weak var P2StepperValue: UIStepper!
    @IBOutlet weak var S1StepperValue: UIStepper!
    @IBOutlet weak var S2StepperValue: UIStepper!
    @IBOutlet weak var S3StepperValue: UIStepper!
    @IBOutlet weak var D1StepperValue: UIStepper!
    
    @IBOutlet weak var AllW1AmountLabel: UILabel!
    @IBOutlet weak var AllW2AmountLabel: UILabel!
    @IBOutlet weak var AllP1AmountLabel: UILabel!
    @IBOutlet weak var AllP2AmountLabel: UILabel!
    @IBOutlet weak var AllS1AmountLabel: UILabel!
    @IBOutlet weak var AllS2AmountLabel: UILabel!
    @IBOutlet weak var AllS3AmountLabel: UILabel!
    @IBOutlet weak var AllD1AmountLabel: UILabel!
    
    @IBOutlet weak var orderButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    //    @IBOutlet weak var BStatus: UILabel!
    //    @IBOutlet weak var SStatus: UILabel!
    //    @IBOutlet weak var DStatus: UILabel!
    //    @IBOutlet weak var DXStatus: UILabel!
    //    @IBOutlet weak var DeStatus: UILabel!
    
    var tableNumber : String?
    var DBRef1:DatabaseReference!
    var status : String?
    var status2 : String?
    var intstatus2 : Int?
    //    var Bstatus : String?
    //    var Pstatus : String?
    //    var Sstatus : String?
    //    var Dstatus : String?
    var W1Amount : String?
    var W2Amount : String?
    var P1Amount : String?
    var P2Amount : String?
    var S1Amount : String?
    var S2Amount : String?
    var S3Amount : String?
    var D1Amount : String?
    var hoge : String?
    var WAmount = 0
    var PAmount = 0
    var SAmount = 0
    var DAmount = 0
    var allW1Amount : String?
    var allW2Amount : String?
    var allP1Amount : String?
    var allP2Amount : String?
    var allS1Amount : String?
    var allS2Amount : String?
    var allS3Amount : String?
    var allD1Amount : String?
    var newAllW1Amount : Int?
    var newAllW2Amount : Int?
    var newAllP1Amount : Int?
    var newAllP2Amount : Int?
    var newAllS1Amount : Int?
    var newAllS2Amount : Int?
    var newAllS3Amount : Int?
    var newAllD1Amount : Int?
    
    
    //Stepper
    @IBAction func W1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        W1AmountLabel.text = "\(Amount)"
    }
    @IBAction func W2Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        W2AmountLabel.text = "\(Amount)"
    }
    @IBAction func P1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        P1AmountLabel.text = "\(Amount)"
    }
    @IBAction func P2Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        P2AmountLabel.text = "\(Amount)"
    }
    @IBAction func S1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        S1AmountLabel.text = "\(Amount)"
    }
    @IBAction func S2Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        S2AmountLabel.text = "\(Amount)"
    }
    @IBAction func S3Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        S3AmountLabel.text = "\(Amount)"
    }
    @IBAction func D1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D1AmountLabel.text = "\(Amount)"
    }
    
    
    
    
    //各ボタン機能
    @IBAction func add(_ sender: Any) {
        self.WAmount = Int(self.W1AmountLabel.text!)! + Int(self.W2AmountLabel.text!)!
        self.PAmount = Int(self.P1AmountLabel.text!)! + Int(self.P2AmountLabel.text!)!
        self.SAmount = Int(self.S1AmountLabel.text!)! + Int(self.S2AmountLabel.text!)! + Int(self.S3AmountLabel.text!)!
        self.DAmount = Int(self.D1AmountLabel.text!)!
        
        let alertController1 = UIAlertController(title: "注文",message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction1 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            let defaultPlacex = self.DBRef1.child("table/status").child(self.tableNumber!)
            defaultPlacex.observeSingleEvent(of: .value, with: { (snapshot) in
                self.status = (snapshot.value! as AnyObject).description
                if Int(self.status!) == 1{
                    let alertController = UIAlertController(title: "変更はキャンセル後に行ってください",message: "", preferredStyle: UIAlertController.Style.alert)
                    let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alertController.addAction(OKButton)
                    self.present(alertController,animated: true,completion: nil)
                }else if Int(self.status!) == 2 || Int(self.status!) == 3 || Int(self.status!) == 4{
                    let alertController = UIAlertController(title: "調理中の商品があります",message: "誰かにいってね", preferredStyle: UIAlertController.Style.alert)
                    let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alertController.addAction(OKButton)
                    self.present(alertController,animated: true,completion: nil)
                    //                }else if self.damount < self.samount||self.damount < self.bamount||self.bamount + self.samount < self.damount{
                    //                    let alertController = UIAlertController(title: "注文が無効です",message: "", preferredStyle: UIAlertController.Style.alert)
                    //                    let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    //                    alertController.addAction(OKButton)
                    //                    self.present(alertController,animated: true,completion: nil)
                }else{
                    //オーダーの入力
                    self.W1Amount = self.W1AmountLabel.text
                    self.W2Amount = self.W2AmountLabel.text
                    self.P1Amount = self.P1AmountLabel.text
                    self.P2Amount = self.P2AmountLabel.text
                    self.S1Amount = self.S1AmountLabel.text
                    self.S2Amount = self.S2AmountLabel.text
                    self.S3Amount = self.S3AmountLabel.text
                    self.D1Amount = self.D1AmountLabel.text
                    //            self.Bsetamount = self.damount - self.samount
                    //            self.Ssetamount = self.damount - self.bamount
                    //            self.BSsetamount = self.bamount + self.samount - self.damount
                    //            self.noIceAmount = self.damount - self.deamount
                    
                    self.DBRef1.child("table/order").child(self.tableNumber!).setValue(["W1Amount":self.W1Amount!, "W2Amount":self.W2Amount!, "P1Amount":self.P1Amount!, "P2Amount":self.P2Amount!, "S1Amount":self.S1Amount!, "S2Amount":self.S2Amount!, "S3Amount":self.S3Amount!, "D1Amount":self.D1Amount!, "time":ServerValue.timestamp()])
                    self.DBRef1.child("table/status").child(self.tableNumber!).setValue(1)
                    //                    self.DBRef1.child("table/setamount").child(self.tableNumber!).setValue(["bset":self.Bsetamount,"sset":self.Ssetamount,"bsset":self.BSsetamount,"noice":self.noIceAmount])
                    
                    //オーダーキーの設定
                    let key = self.DBRef1.child("table/orderorder").childByAutoId().key;
                    self.DBRef1.child("table/orderorder").child(key!).setValue(self.tableNumber!)
                    self.DBRef1.child("table/orderkey").child(self.tableNumber!).setValue(key)
                    //データセット
                    self.DBRef1.child("inData").child(key!).setValue(["time":ServerValue.timestamp(), "table":self.tableNumber!, "W1":self.W1Amount!, "W2":self.W2Amount!, "P1":self.P1Amount!, "P2":self.P2Amount!, "S1":self.S1Amount!, "S2":self.S2Amount!, "S3":self.S3Amount!, "D1":self.D1Amount!])
                    //"bset":self.Bsetamount,"sset":self.Ssetamount,"bsset":self.BSsetamount,"noice":self.noIceAmount]
                    
                    //全食数の更新
                    let defaultPlaceW1 = self.DBRef1.child("table/allOrder/allW1Amount")
                    defaultPlaceW1.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.allW1Amount = (snapshot.value! as AnyObject).description
                        self.newAllW1Amount = Int(self.allW1Amount!)! - Int(self.W1Amount!)!
                        self.DBRef1.child("table/allOrder/allW1Amount").setValue(self.newAllW1Amount)
                    })
                    let defaultPlaceW2 = self.DBRef1.child("table/allOrder/allW2Amount")
                    defaultPlaceW2.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.allW2Amount = (snapshot.value! as AnyObject).description
                        self.newAllW2Amount = Int(self.allW2Amount!)! - Int(self.W2Amount!)!
                        self.DBRef1.child("table/allOrder/allW2Amount").setValue(self.newAllW2Amount)
                    })
                    let defaultPlaceP1 = self.DBRef1.child("table/allOrder/allP1Amount")
                    defaultPlaceP1.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.allP1Amount = (snapshot.value! as AnyObject).description
                        self.newAllP1Amount = Int(self.allP1Amount!)! - Int(self.P1Amount!)!
                        self.DBRef1.child("table/allOrder/allP1Amount").setValue(self.newAllP1Amount)
                    })
                    let defaultPlaceP2 = self.DBRef1.child("table/allOrder/allP2Amount")
                    defaultPlaceP2.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.allP2Amount = (snapshot.value! as AnyObject).description
                        self.newAllP2Amount = Int(self.allP2Amount!)! - Int(self.P2Amount!)!
                        self.DBRef1.child("table/allOrder/allP2Amount").setValue(self.newAllP2Amount)
                    })
                    let defaultPlaceS1 = self.DBRef1.child("table/allOrder/allS1Amount")
                    defaultPlaceS1.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.allS1Amount = (snapshot.value! as AnyObject).description
                        self.newAllS1Amount = Int(self.allS1Amount!)! - Int(self.S1Amount!)!
                        self.DBRef1.child("table/allOrder/allS1Amount").setValue(self.newAllS1Amount)
                    })
                    let defaultPlaceS2 = self.DBRef1.child("table/allOrder/allS2Amount")
                    defaultPlaceS2.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.allS2Amount = (snapshot.value! as AnyObject).description
                        self.newAllS2Amount = Int(self.allS2Amount!)! - Int(self.S2Amount!)!
                        self.DBRef1.child("table/allOrder/allS2Amount").setValue(self.newAllS2Amount)
                    })
                    let defaultPlaceS3 = self.DBRef1.child("table/allOrder/allS3Amount")
                    defaultPlaceS3.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.allS3Amount = (snapshot.value! as AnyObject).description
                        self.newAllS3Amount = Int(self.allS3Amount!)! - Int(self.S3Amount!)!
                        self.DBRef1.child("table/allOrder/allS3Amount").setValue(self.newAllS3Amount)
                    })
                    let defaultPlaceD1 = self.DBRef1.child("table/allOrder/allD1Amount")
                    defaultPlaceD1.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.allD1Amount = (snapshot.value! as AnyObject).description
                        self.newAllD1Amount = Int(self.allD1Amount!)! - Int(self.D1Amount!)!
                        self.DBRef1.child("table/allOrder/allD1Amount").setValue(self.newAllD1Amount)
                    })
                }})}
        let cancelButton1 = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController1.addAction(okAction1)
        alertController1.addAction(cancelButton1)
        present(alertController1,animated: true,completion: nil)
    }
    
    
    @IBAction func dlete(_ sender: Any) {
        self.WAmount = Int(self.W1AmountLabel.text!)! + Int(self.W2AmountLabel.text!)!
        self.PAmount = Int(self.P1AmountLabel.text!)! + Int(self.P2AmountLabel.text!)!
        self.SAmount = Int(self.S1AmountLabel.text!)! + Int(self.S2AmountLabel.text!)! + Int(self.S3AmountLabel.text!)!
        self.DAmount = Int(self.D1AmountLabel.text!)!
        
        let alertController3 = UIAlertController(title: "キャンセル",message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction3 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            //self.Ssetamount = self.damount - self.bamount
            //全食数の更新
            let defaultPlaceW1 = self.DBRef1.child("table/allOrder/allW1Amount")
            defaultPlaceW1.observeSingleEvent(of: .value, with: { (snapshot) in
                self.allW1Amount = (snapshot.value! as AnyObject).description
                self.newAllW1Amount = Int(self.allW1Amount!)! + Int(self.W1Amount!)!
                self.DBRef1.child("table/allOrder/allW1Amount").setValue(self.newAllW1Amount)
                self.DBRef1.child("table/order").child(self.tableNumber!).child("W1Amount").setValue(0)
            })
            let defaultPlaceW2 = self.DBRef1.child("table/allOrder/allW2Amount")
            defaultPlaceW2.observeSingleEvent(of: .value, with: { (snapshot) in
                self.allW2Amount = (snapshot.value! as AnyObject).description
                self.newAllW2Amount = Int(self.allW2Amount!)! + Int(self.W2Amount!)!
                self.DBRef1.child("table/allOrder/allW2Amount").setValue(self.newAllW2Amount)
                self.DBRef1.child("table/order").child(self.tableNumber!).child("W2Amount").setValue(0)
            })
            let defaultPlaceP1 = self.DBRef1.child("table/allOrder/allP1Amount")
            defaultPlaceP1.observeSingleEvent(of: .value, with: { (snapshot) in
                self.allP1Amount = (snapshot.value! as AnyObject).description
                self.newAllP1Amount = Int(self.allP1Amount!)! + Int(self.P1Amount!)!
                self.DBRef1.child("table/allOrder/allP1Amount").setValue(self.newAllP1Amount)
                self.DBRef1.child("table/order").child(self.tableNumber!).child("P1Amount").setValue(0)
            })
            let defaultPlaceP2 = self.DBRef1.child("table/allOrder/allP2Amount")
            defaultPlaceP2.observeSingleEvent(of: .value, with: { (snapshot) in
                self.allP2Amount = (snapshot.value! as AnyObject).description
                self.newAllP2Amount = Int(self.allP2Amount!)! + Int(self.P2Amount!)!
                self.DBRef1.child("table/allOrder/allP2Amount").setValue(self.newAllP2Amount)
                self.DBRef1.child("table/order").child(self.tableNumber!).child("P2Amount").setValue(0)
            })
            let defaultPlaceS1 = self.DBRef1.child("table/allOrder/allS1Amount")
            defaultPlaceS1.observeSingleEvent(of: .value, with: { (snapshot) in
                self.allS1Amount = (snapshot.value! as AnyObject).description
                self.newAllS1Amount = Int(self.allS1Amount!)! + Int(self.S1Amount!)!
                self.DBRef1.child("table/allOrder/allS1Amount").setValue(self.newAllS1Amount)
                self.DBRef1.child("table/order").child(self.tableNumber!).child("S1Amount").setValue(0)
            })
            let defaultPlaceS2 = self.DBRef1.child("table/allOrder/allS2Amount")
            defaultPlaceS2.observeSingleEvent(of: .value, with: { (snapshot) in
                self.allS2Amount = (snapshot.value! as AnyObject).description
                self.newAllS2Amount = Int(self.allS2Amount!)! + Int(self.S2Amount!)!
                self.DBRef1.child("table/allOrder/allS2Amount").setValue(self.newAllS2Amount)
                self.DBRef1.child("table/order").child(self.tableNumber!).child("S2Amount").setValue(0)
            })
            let defaultPlaceS3 = self.DBRef1.child("table/allOrder/allS3Amount")
            defaultPlaceS3.observeSingleEvent(of: .value, with: { (snapshot) in
                self.allS3Amount = (snapshot.value! as AnyObject).description
                self.newAllS3Amount = Int(self.allS3Amount!)! + Int(self.S3Amount!)!
                self.DBRef1.child("table/allOrder/allS3Amount").setValue(self.newAllS3Amount)
                self.DBRef1.child("table/order").child(self.tableNumber!).child("S3Amount").setValue(0)
            })
            let defaultPlaceD1 = self.DBRef1.child("table/allOrder/allD1Amount")
            defaultPlaceD1.observeSingleEvent(of: .value, with: { (snapshot) in
                self.allD1Amount = (snapshot.value! as AnyObject).description
                self.newAllD1Amount = Int(self.allD1Amount!)! + Int(self.D1Amount!)!
                self.DBRef1.child("table/allOrder/allD1Amount").setValue(self.newAllD1Amount)
                self.DBRef1.child("table/order").child(self.tableNumber!).child("D1Amount").setValue(0)
            })
            
            //オーダーリセット
            self.DBRef1.child("table/order").child(self.tableNumber!).child("time").setValue(0)
            self.DBRef1.child("table/order").child(self.tableNumber!).child("completetime").setValue(0)
            self.DBRef1.child("table/status").child(self.tableNumber!).setValue(0)
            //            self.DBRef1.child("table/WStatus").child(self.tableNumber!).setValue(0)
            //            self.DBRef1.child("table/PStatus").child(self.tableNumber!).setValue(0)
            //            self.DBRef1.child("table/SStatus").child(self.tableNumber!).setValue(0)
            //            self.DBRef1.child("table/DStatus").child(self.tableNumber!).setValue(0)
            //self.DBRef1.child("table/setamount").child(self.tableNumber!).setValue(["bset":0,"sset":0,"bsset":0,"noice":0])
            //オーダーキーのリセット
            var hogekey : String?
            let defaultPlaceOK = self.DBRef1.child("table/orderKey").child(self.tableNumber!)
            defaultPlaceOK.observeSingleEvent(of: .value, with: { (snapshot) in
                hogekey = (snapshot.value! as AnyObject).description
                self.DBRef1.child("inData").child(hogekey!).setValue(nil)
                self.DBRef1.child("table/orderOrder").child(hogekey!).setValue(nil)
                self.DBRef1.child("table/orderKey").child(self.tableNumber!).setValue(nil)
            })
        }
        let cancelButton3 = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController3.addAction(okAction3)
        alertController3.addAction(cancelButton3)
        present(alertController3,animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef1 = Database.database().reference()
        Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(self.amountload(_:)),
            userInfo: nil,
            repeats: false
        )
        //        Timer.scheduledTimer(
        //            timeInterval: 0.1,
        //            target: self,
        //            selector: #selector(self.status(_:)),
        //            userInfo: nil,
        //            repeats: false
        //        )
    }
    
    @objc func amountload(_ sender: Timer) {
        //注文ボタン
        let defaultPlace = DBRef1.child("table/status").child(tableNumber!)
        defaultPlace.observe(DataEventType.value, with: { (snapshot) in
            self.status = (snapshot.value! as AnyObject).description
            if Int(self.status!) == 0{
                self.orderButton.isEnabled = true
                self.cancelButton.isEnabled = false
            }else{
                self.orderButton.isEnabled = false
                self.cancelButton.isEnabled = true
            }
        })
        
        //初期値取得
        let defaultPlaceW1 = DBRef1.child("table/order").child(tableNumber!).child("W1Amount")
        defaultPlaceW1.observeSingleEvent(of: .value, with: { (snapshot) in self.W1Amount = (snapshot.value! as AnyObject).description
            self.W1AmountLabel.text = self.W1Amount!
            self.W1StepperValue.value = Double(Int(self.W1Amount!)!)
        })
        let defaultPlaceW2 = DBRef1.child("table/order").child(tableNumber!).child("W2Amount")
        defaultPlaceW2.observeSingleEvent(of: .value, with: { (snapshot) in self.W2Amount = (snapshot.value! as AnyObject).description
            self.W2AmountLabel.text = self.W2Amount!
            self.W2StepperValue.value = Double(Int(self.W2Amount!)!)
        })
        let defaultPlaceP1 = DBRef1.child("table/order").child(tableNumber!).child("P1Amount")
        defaultPlaceP1.observeSingleEvent(of: .value, with: { (snapshot) in self.P1Amount = (snapshot.value! as AnyObject).description
            self.P1AmountLabel.text = self.P1Amount!
            self.P1StepperValue.value = Double(Int(self.P1Amount!)!)
        })
        let defaultPlaceP2 = DBRef1.child("table/order").child(tableNumber!).child("P2Amount")
        defaultPlaceP2.observeSingleEvent(of: .value, with: { (snapshot) in self.P2Amount = (snapshot.value! as AnyObject).description
            self.P2AmountLabel.text = self.P2Amount!
            self.P2StepperValue.value = Double(Int(self.P2Amount!)!)
        })
        let defaultPlaceS1 = DBRef1.child("table/order").child(tableNumber!).child("S1Amount")
        defaultPlaceS1.observeSingleEvent(of: .value, with: { (snapshot) in self.S1Amount = (snapshot.value! as AnyObject).description
            self.S1AmountLabel.text = self.S1Amount!
            self.S1StepperValue.value = Double(Int(self.S1Amount!)!)
        })
        let defaultPlaceS2 = DBRef1.child("table/order").child(tableNumber!).child("S2Amount")
        defaultPlaceS2.observeSingleEvent(of: .value, with: { (snapshot) in self.S2Amount = (snapshot.value! as AnyObject).description
            self.S2AmountLabel.text = self.S2Amount!
            self.S2StepperValue.value = Double(Int(self.S2Amount!)!)
        })
        let defaultPlaceS3 = DBRef1.child("table/order").child(tableNumber!).child("S3Amount")
        defaultPlaceS3.observeSingleEvent(of: .value, with: { (snapshot) in self.S3Amount = (snapshot.value! as AnyObject).description
            self.S3AmountLabel.text = self.S3Amount!
            self.S3StepperValue.value = Double(Int(self.S3Amount!)!)
        })
        let defaultPlaceD1 = DBRef1.child("table/order").child(tableNumber!).child("D1Amount")
        defaultPlaceD1.observeSingleEvent(of: .value, with: { (snapshot) in self.D1Amount = (snapshot.value! as AnyObject).description
            self.D1AmountLabel.text = self.D1Amount!
            self.D1StepperValue.value = Double(Int(self.D1Amount!)!)
        })
        
        //全食数の取得
        let defaultPlaceW12 = self.DBRef1.child("table/allOrder/allW1Amount")
        defaultPlaceW12.observe(DataEventType.value, with: { (snapshot) in
            self.AllW1AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceW22 = self.DBRef1.child("table/allOrder/allW2Amount")
        defaultPlaceW22.observe(DataEventType.value, with: { (snapshot) in
            self.AllW2AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceP12 = self.DBRef1.child("table/allOrder/allP1Amount")
        defaultPlaceP12.observe(DataEventType.value, with: { (snapshot) in
            self.AllP1AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceP22 = self.DBRef1.child("table/allOrder/allP2Amount")
        defaultPlaceP22.observe(DataEventType.value, with: { (snapshot) in
            self.AllP2AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceS12 = self.DBRef1.child("table/allOrder/allS1Amount")
        defaultPlaceS12.observe(DataEventType.value, with: { (snapshot) in
            self.AllS1AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceS22 = self.DBRef1.child("table/allOrder/allS2Amount")
        defaultPlaceS22.observe(DataEventType.value, with: { (snapshot) in
            self.AllS2AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceS32 = self.DBRef1.child("table/allOrder/allS3Amount")
        defaultPlaceS32.observe(DataEventType.value, with: { (snapshot) in
            self.AllS3AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD12 = self.DBRef1.child("table/allOrder/allD1Amount")
        defaultPlaceD12.observe(DataEventType.value, with: { (snapshot) in
            self.AllD1AmountLabel.text = (snapshot.value! as AnyObject).description
        })
    }
    
    //    @objc func status(_ sender: Timer) {
    //        let defaultPlace = DBRef1.child("table/bstatus").child(self.tableNumber!)
    //        defaultPlace.observe(.value) { (snap: DataSnapshot) in self.bstatus = (snap.value! as AnyObject).description
    //            if Int(self.bstatus!) == 1{
    //                self.BStatus.backgroundColor = UIColor.magenta
    //            }else if Int(self.bstatus!) == 2{
    //                self.BStatus.backgroundColor = UIColor.cyan
    //            }else{
    //                self.BStatus.backgroundColor = UIColor.white
    //            }
    //        }
    //        let defaultPlace1 = DBRef1.child("table/sstatus").child(self.tableNumber!)
    //        defaultPlace1.observe(.value) { (snap: DataSnapshot) in self.sstatus = (snap.value! as AnyObject).description
    //            if Int(self.sstatus!) == 1{
    //                self.SStatus.backgroundColor = UIColor.magenta
    //            }else if Int(self.sstatus!) == 2{
    //                self.SStatus.backgroundColor = UIColor.cyan
    //            }else{
    //                self.SStatus.backgroundColor = UIColor.white
    //            }
    //        }
    //        let defaultPlace2 = DBRef1.child("table/dstatus").child(self.tableNumber!)
    //        defaultPlace2.observe(.value) { (snap: DataSnapshot) in self.dstatus = (snap.value! as AnyObject).description
    //            if Int(self.dstatus!) == 1{
    //                self.DStatus.backgroundColor = UIColor.magenta
    //            }else if Int(self.dstatus!) == 2{
    //                self.DStatus.backgroundColor = UIColor.cyan
    //            }else{
    //                self.DStatus.backgroundColor = UIColor.white
    //            }
    //        }
    //        let defaultPlace4 = DBRef1.child("table/dxstatus").child(self.tableNumber!)
    //        defaultPlace4.observe(.value) { (snap: DataSnapshot) in self.dxstatus = (snap.value! as AnyObject).description
    //            if Int(self.dxstatus!) == 1{
    //                self.DXStatus.backgroundColor = UIColor.magenta
    //            }else if Int(self.dxstatus!) == 2{
    //                self.DXStatus.backgroundColor = UIColor.cyan
    //            }else{
    //                self.DXStatus.backgroundColor = UIColor.white
    //            }
    //        }
    //        let defaultPlace3 = DBRef1.child("table/destatus").child(self.tableNumber!)
    //        defaultPlace3.observe(.value) { (snap: DataSnapshot) in self.destatus = (snap.value! as AnyObject).description
    //            if Int(self.destatus!) == 1{
    //                self.DeStatus.backgroundColor = UIColor.magenta
    //            }else if Int(self.destatus!) == 2{
    //                self.DeStatus.backgroundColor = UIColor.cyan
    //            }else{
    //                self.DeStatus.backgroundColor = UIColor.white
    //            }
    //        }
    //
    //
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
