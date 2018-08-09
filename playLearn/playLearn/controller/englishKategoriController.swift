//
//  englishKategoriController.swift
//  playLearn
//
//  Created by Sierra on 4.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class englishKategoriController: UIViewController {
    
    @IBOutlet weak var hayvanText: UILabel!
    @IBOutlet weak var meyveText: UILabel!
    @IBOutlet weak var nesneText: UILabel!
    @IBOutlet weak var renkText: UILabel!
    @IBOutlet weak var sayiText: UILabel!
    @IBOutlet weak var karisikText: UILabel!
    
    @IBOutlet weak var hayvanButton: buttonStyle!
    @IBOutlet weak var meyveButton: buttonStyle!
    @IBOutlet weak var nesneButton: buttonStyle!
    @IBOutlet weak var sayiButton: buttonStyle!
    @IBOutlet weak var renkButton: buttonStyle!
    @IBOutlet weak var karisikButton: buttonStyle!
    
    
    var ref: DatabaseReference!
    
    @IBAction func hayvan(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("kategori").child(userID!).setValue(["secim":"hayvanlar"])
        performSegue(withIdentifier: "basla", sender: self)
        }
    
    @IBAction func meyve(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("kategori").child(userID!).setValue(["secim":"meyveler"])
        performSegue(withIdentifier: "basla", sender: self)
    }
    
    @IBAction func nesne(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("kategori").child(userID!).setValue(["secim":"nesneler"])
        performSegue(withIdentifier: "basla", sender: self)
    }
    
    @IBAction func renk(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("kategori").child(userID!).setValue(["secim":"renkler"])
        performSegue(withIdentifier: "basla", sender: self)
    }
    
    @IBAction func sayi(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("kategori").child(userID!).setValue(["secim":"sayilar"])
        performSegue(withIdentifier: "basla", sender: self)
    }
    
    @IBAction func karisik(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("kategori").child(userID!).setValue(["secim":"depo"])
        performSegue(withIdentifier: "basla", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        let random = arc4random_uniform(10) + 1
        
        ref.child("hayvanlar/\(random)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let ingilizce = value?["ingilizce"] as? String ?? ""
            self.hayvanButton.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
        })
        
        ref.child("meyveler/\(random)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let ingilizce = value?["ingilizce"] as? String ?? ""
            self.meyveButton.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
        })
        
        ref.child("nesneler/\(random)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let ingilizce = value?["ingilizce"] as? String ?? ""
            self.nesneButton.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
        })
        
        ref.child("sayilar/\(random)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let ingilizce = value?["ingilizce"] as? String ?? ""
            self.sayiButton.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
        })
        
        ref.child("renkler/\(random)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let ingilizce = value?["ingilizce"] as? String ?? ""
            self.renkButton.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
        })
        
        let yenirandom = arc4random_uniform(40) + 1
        ref.child("depo/\(yenirandom)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let ingilizce = value?["ingilizce"] as? String ?? ""
            self.karisikButton.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
        })
        
        ref.child("yuksekPuan").child("hayvanlar").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let hayvanSkor = value?["puan"] as? Int ?? 0
            self.hayvanText.text = "Puan: \(hayvanSkor)"
        })
    
        ref.child("yuksekPuan").child("meyveler").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let meyveSkor = value?["puan"] as? Int ?? 0
            self.meyveText.text = "Puan: \(meyveSkor)"
        })
    
        ref.child("yuksekPuan").child("nesneler").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let nesneSkor = value?["puan"] as? Int ?? 0
            self.nesneText.text = "Puan: \(nesneSkor)"
        })
        
        ref.child("yuksekPuan").child("renkler").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let renkSkor = value?["puan"] as? Int ?? 0
            self.renkText.text = "Puan: \(renkSkor)"
        })
        
        ref.child("yuksekPuan").child("sayilar").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let sayiSkor = value?["puan"] as? Int ?? 0
            self.sayiText.text = "Puan: \(sayiSkor)"
        })
        
        ref.child("yuksekPuan").child("depo").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let karisikSkor = value?["puan"] as? Int ?? 0
            self.karisikText.text = "Puan: \(karisikSkor)"
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
