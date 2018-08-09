//
//  englishController.swift
//  playLearn
//
//  Created by Sierra on 4.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class englishController: UIViewController {

    var ref: DatabaseReference!
    
    @IBAction func sifirla(_ sender: Any) {
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("rumuz").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let rumuz = value?["rumuz"] as? String ?? ""
        
            self.ref.child("yuksekPuan").child("hayvanlar").child(userID!).setValue(["rumuz":rumuz,"puan":0])
            self.ref.child("yuksekPuan").child("meyveler").child(userID!).setValue(["rumuz":rumuz,"puan":0])
            self.ref.child("yuksekPuan").child("nesneler").child(userID!).setValue(["rumuz":rumuz,"puan":0])
            self.ref.child("yuksekPuan").child("renkler").child(userID!).setValue(["rumuz":rumuz,"puan":0])
            self.ref.child("yuksekPuan").child("sayilar").child(userID!).setValue(["rumuz":rumuz,"puan":0])
            self.ref.child("yuksekPuan").child("depo").child(userID!).setValue(["rumuz":rumuz,"puan":0])
       
    })
}
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
