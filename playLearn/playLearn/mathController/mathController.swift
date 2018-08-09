//
//  mathController.swift
//  playLearn
//
//  Created by Sierra on 4.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class mathController: UIViewController {

     var ref: DatabaseReference!
    
    @IBAction func sifirla(_ sender: Any) {
       
            ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
        
        var rumuz = ""
        ref.child("rumuz").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            rumuz = value?["rumuz"] as? String ?? ""
        
            
        self.ref.child("mathPuan").child("toplama").child("bir").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("toplama").child("iki").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("toplama").child("uc").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("toplama").child("dort").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("toplama").child("karisik").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        
        self.ref.child("mathPuan").child("cikarma").child("bir").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("cikarma").child("iki").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("cikarma").child("uc").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("cikarma").child("dort").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("cikarma").child("karisik").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        
        self.ref.child("mathPuan").child("carpma").child("bir").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("carpma").child("iki").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("carpma").child("uc").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("carpma").child("dort").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("carpma").child("karisik").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        
        self.ref.child("mathPuan").child("bolme").child("bir").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("bolme").child("iki").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("bolme").child("uc").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("bolme").child("dort").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("bolme").child("karisik").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        
        self.ref.child("mathPuan").child("karisik").child("bir").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("karisik").child("iki").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("karisik").child("uc").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("karisik").child("dort").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        self.ref.child("mathPuan").child("karisik").child("karisik").child(userID!).setValue(["puan":0,"rumuz":rumuz])
        
    
            })
        }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
