//
//  ogreticiKategoriController.swift
//  playLearn
//
//  Created by Sierra on 13.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class ogreticiKategoriController: UIViewController {

    var ref: DatabaseReference!
    
    @IBAction func toplama(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathOgreticiKategori").child(userID!).setValue(["secim":"toplama"])
        performSegue(withIdentifier: "ogreticiShow", sender: self)
    }
    
    @IBAction func cikarma(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathOgreticiKategori").child(userID!).setValue(["secim":"cikarma"])
        performSegue(withIdentifier: "ogreticiShow", sender: self)
    }
    
    @IBAction func carpma(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathOgreticiKategori").child(userID!).setValue(["secim":"carpma"])
        performSegue(withIdentifier: "ogreticiShow", sender: self)
    }
    
    @IBAction func bolme(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("mathOgreticiKategori").child(userID!).setValue(["secim":"bolme"])
        performSegue(withIdentifier: "ogreticiShow", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
