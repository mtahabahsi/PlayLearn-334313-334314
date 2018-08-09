//
//  basamakController.swift
//  playLearn
//
//  Created by Sierra on 13.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class basamakController: UIViewController {

    @IBOutlet weak var birText: UILabel!
    @IBOutlet weak var ikiText: UILabel!
    @IBOutlet weak var ucText: UILabel!
    @IBOutlet weak var dortText: UILabel!
    @IBOutlet weak var karisikText: UILabel!
    
    var ref: DatabaseReference!
    
    @IBAction func bir(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathBasamak").child(userID!).setValue(["secim":"bir"])
        performSegue(withIdentifier: "mathBasla", sender: self)
    }
    
    @IBAction func iki(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathBasamak").child(userID!).setValue(["secim":"iki"])
        performSegue(withIdentifier: "mathBasla", sender: self)
    }
    
    @IBAction func uc(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathBasamak").child(userID!).setValue(["secim":"uc"])
        performSegue(withIdentifier: "mathBasla", sender: self)
    }
    
    @IBAction func dort(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathBasamak").child(userID!).setValue(["secim":"dort"])
        performSegue(withIdentifier: "mathBasla", sender: self)
    }
    
    @IBAction func karisik(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathBasamak").child(userID!).setValue(["secim":"karisik"])
        performSegue(withIdentifier: "mathBasla", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
         let userID = Auth.auth().currentUser?.uid
        
        var kategori: String?
         ref.child("mathKategori").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
         let value = snapshot.value as? NSDictionary
         kategori = value?["secim"] as? String ?? ""
         
         
         
         
        self.ref.child("mathPuan").child(kategori!).child("bir").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let bir = value?["puan"] as? Int ?? 0
                self.birText.text = "Puan: \(bir)"
         })
            
        self.ref.child("mathPuan").child(kategori!).child("iki").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let iki = value?["puan"] as? Int ?? 0
                self.ikiText.text = "Puan: \(iki)"
            })
            
        self.ref.child("mathPuan").child(kategori!).child("uc").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let uc = value?["puan"] as? Int ?? 0
                self.ucText.text = "Puan: \(uc)"
            })
            
        self.ref.child("mathPuan").child(kategori!).child("dort").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let dort = value?["puan"] as? Int ?? 0
                self.dortText.text = "Puan: \(dort)"
            })
            
        self.ref.child("mathPuan").child(kategori!).child("karisik").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let karisik = value?["puan"] as? Int ?? 0
                self.karisikText.text = "Puan: \(karisik)"
            })
      })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
