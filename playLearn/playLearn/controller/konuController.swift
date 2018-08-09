//
//  konuController.swift
//  playLearn
//
//  Created by Sierra on 4.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class konuController: UIViewController {

    @IBAction func cikis(_ sender: Any) {
        
            let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out : %@", signOutError)
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("rumuz").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let rumuz = value?["rumuz"] as? String ?? ""
            
            if rumuz == "" {
                let alert = UIAlertController(title: "Kullanıcı Adı", message: "Lütfen Bir Kullanıcı Adı Belirleyin.", preferredStyle: UIAlertControllerStyle.alert)
                
                let simdiDegil = UIAlertAction(title: "Şimdi Değil", style: .default, handler: { (action: UIAlertAction!) in })
                
                let belirle = UIAlertAction(title: "Belirle", style: .default, handler: { (action: UIAlertAction!) in
                    
                    let textField = alert.textFields![0] as UITextField
                    textField.keyboardType = UIKeyboardType.numberPad
                    
                    ref.child("rumuz").child(userID!).setValue(["rumuz":textField.text])
                    
                    let alert = UIAlertController(title: "Başarılı", message: "Kullanıcı Adı Belirlendi", preferredStyle: UIAlertControllerStyle.alert)
                    // Otomatik Kapan
                    self.present(alert, animated: true) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                            guard self?.presentedViewController == alert else { return }
                            
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }
                })
                
                
                alert.addTextField { (textField: UITextField!) in
                     textField.placeholder = "Kullanıcı Adınızı Buraya Giriniz..."
                }
                
                alert.addAction(simdiDegil)
                alert.addAction(belirle)
                
                self.present(alert, animated: true, completion: nil)
                
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
