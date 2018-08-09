//
//  siralamaController.swift
//  playLearn
//
//  Created by Sierra on 15.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class siralamaController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref:DatabaseReference!
    var kategori = "toplama"
    var basamak = "bir"
    
    @IBAction func toplama(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraKategori").child(userID!).setValue(["secim":"toplama"])
        viewDidLoad()
    }
    
    @IBAction func cikarma(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraKategori").child(userID!).setValue(["secim":"cikarma"])
        viewDidLoad()
    }
    
    @IBAction func carpma(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraKategori").child(userID!).setValue(["secim":"carpma"])
        viewDidLoad()
    }
    
    @IBAction func bolme(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraKategori").child(userID!).setValue(["secim":"bolme"])
        viewDidLoad()
    }
    
    @IBAction func karisik(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraKategori").child(userID!).setValue(["secim":"karisik"])
        viewDidLoad()
    }
    
    
    
    @IBAction func bir(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraBasamak").child(userID!).setValue(["secim":"bir"])
        viewDidLoad()
    }
    
    @IBAction func iki(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraBasamak").child(userID!).setValue(["secim":"iki"])
        viewDidLoad()
    }
    
    @IBAction func uc(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraBasamak").child(userID!).setValue(["secim":"uc"])
        viewDidLoad()
    }
    
    @IBAction func dort(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraBasamak").child(userID!).setValue(["secim":"dort"])
        viewDidLoad()
    }
    
    @IBAction func karisikSayi(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathSiraBasamak").child(userID!).setValue(["secim":"karisik"])
        viewDidLoad()
    }
    
    var posts = [veriModal]()
    
    @IBOutlet weak var tablo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tablo.delegate = self
        self.tablo.dataSource = self
        ref = Database.database().reference()
        cek()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cek() {
        
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("mathSiraKategori").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.kategori = value?["secim"] as? String ?? ""
            
            
            self.ref.child("mathSiraBasamak").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.basamak = value?["secim"] as? String ?? ""
        
                if self.kategori == "" {
                    self.kategori = "toplama"
                }
                if self.basamak == "" {
                    self.basamak = "bir"
                }
                
                    
                    self.ref.child("mathPuan").child(self.kategori).child(self.basamak).observe(.value, with: {(snapshot) in
                        self.posts.removeAll()
                        for gelen in snapshot.children.allObjects {
                            let gelenSira = gelen as? DataSnapshot
                            let sira = gelenSira?.value as? NSDictionary
                            let rumuz = sira!["rumuz"] as! String
                            let puan = sira!["puan"] as! Int
                            let puanlama = veriModal(rumuz: rumuz, puan: puan)
                            self.posts.append(puanlama)
                        }
                        self.tablo.reloadData()
                    })
            
            })
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MathSiralamaCell") as! mathSiralamaTableViewCell
        cell.puan.text = "\(posts[indexPath.row].puan!)"
        cell.rumuz.text = posts[indexPath.row].rumuz
        
        return cell
    }

}
