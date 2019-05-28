//
//  ViewController.swift
//  kissa_eatIn
//
//  Created by Kei Kawamura on 2018/09/03.
//  Copyright © 2018 Kei Kawamura / 2019 Tomohiro Hori . All rights reserved.
//

import UIKit
import Foundation
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TableView: UITableView!
    let number = ["001","002","003","004","005","006","007","008","009","010","011","012","013","014","015","016","017","018","019","020","021","022","023","024"]
    //let number = ["001","002","003","004","005","006","007","008","009","010","011","012","013","014","015","016","017","018","019","020","021","022","023","024","025","026","027","028","029","030","031","032","033","034","035","036","037","038","039","040"]
    var tableNumber : String?
    // インスタンス変数
    var DBRef:DatabaseReference!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = "Order " + number[indexPath.row]
        //cell.detailTextLabel!.text = "空席"
        //席ステータス表示
        var status1 : String?
        var intstatus1 : Int?
        let defaultPlace = DBRef.child("table/status").child(number[indexPath.row])
        //defaultPlace.observe(.value) { (snap: DataSnapshot) in
        defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
            status1 = (snapshot.value! as AnyObject).description
            intstatus1 = Int(status1!)
            if intstatus1! == 0{
                cell.detailTextLabel!.text = "空席"
                cell.backgroundColor = UIColor.clear
            }else if intstatus1! == 1{
                cell.detailTextLabel!.text = "注文完了"
                cell.backgroundColor = UIColor(red:0.81, green:0.91, blue:0.92, alpha:1.0)
            }else if intstatus1! == 2{
                cell.detailTextLabel!.text = "配膳待ち"
                cell.backgroundColor = UIColor(red:0.96, green:0.87, blue:0.90, alpha:1.0)
            }else if intstatus1! == 3{
                cell.detailTextLabel!.text = "食事配膳完了"
                cell.backgroundColor = UIColor(red:0.98, green:0.96, blue:0.70, alpha:1.0)
            }else if intstatus1! == 4{
                cell.detailTextLabel!.text = "全注文配膳完了"
                cell.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.70, alpha:1.0)
            }else if intstatus1! == 5{
                cell.detailTextLabel!.text = "退店済"
                cell.backgroundColor = UIColor(red:0.99, green:0.92, blue:0.82, alpha:1.0)
            }
        })
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableNumber = number[indexPath.row]
        //設定
        //self.DBRef.child("table/order").child(self.number[indexPath.row]).setValue(["W1Amount":0, "W2Amount":0, "P1Amount":0, "P2Amount":0, "S1Amount":0, "S2Amount":0, "S3Amount":0, "D1Amount":0, "time":0])
        //self.DBRef.child("table/allOrder").setValue(["allW1Amount":0, "allW2Amount":0, "allP1Amount":0, "allP2Amount":0, "allS1Amount":0, "allS2Amount":0, "allS3Amount":0, "allD1Amount":0])
        //self.DBRef.child("table/status").child(self.number[indexPath.row]).setValue(0)
        //self.DBRef.child("table/WStatus").child(self.number[indexPath.row]).setValue(0)
        //self.DBRef.child("table/PStatus").child(self.number[indexPath.row]).setValue(0)
        //self.DBRef.child("table/SStatus").child(self.number[indexPath.row]).setValue(0)
        //self.DBRef.child("table/DStatus").child(self.number[indexPath.row]).setValue(0)

        //self.DBRef.child("table/setamount").child(self.number[indexPath.row]).setValue(["bset":0,"sset":0,"bsset":0,"noice":0])

        performSegue(withIdentifier:"toNextView", sender: nil)
        tableView.deselectRow(at: indexPath, animated:true)
    }

    //次のビューに渡す値を設定
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SubViewController
        let _ = nextVC.view
        nextVC.navigationItem.title = "Table " + tableNumber!
        nextVC.tableNumber = tableNumber!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //インスタンスを作成
        DBRef = Database.database().reference()
        
        Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.newArray(_:)),
            userInfo: nil,
            repeats: true
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func newArray(_ sender: Timer) {
        self.TableView.reloadData()
    }

}
