//
//  englishFavoriController.swift
//  playLearn
//
//  Created by Sierra on 5.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class englishFavoriController: UIViewController {

    var sayi = 0
    var deger = 1
    var durum = "sonraki"
    @IBOutlet weak var ekran: imageStyle!
    
    @IBOutlet weak var soruText: UILabel!
    @IBOutlet weak var cevapText: UILabel!
    
    @IBAction func sonraki(_ sender: UIButton) {
        deger = deger + 1
        durum = "sonraki"
        viewDidLoad()
    }
    @IBAction func onceki(_ sender: UIButton) {
        deger = deger - 1
        durum = "onceki"
        viewDidLoad()
    }
    var ref: DatabaseReference!
    
    @IBAction func favoriCikar(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("favoridepo").child(userID!).child("\(deger)").setValue(["ingilizce": nil,"turkce":nil,"deger":"\(deger)"])
        viewDidLoad()
        let alert = UIAlertController(title: "Çıkarma Başarılı", message: "Kelime Favorilerden Çıkarıldı", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: {_ in self.viewDidLoad() }))
        self.present(alert, animated: true, completion:nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        self.sayi = 0
        ref.child("favoridepo").child(userID!).observe(.value) { snapshot in
            for _ in snapshot.children {
                self.sayi = self.sayi + 1
            }
        }
        
        ref.child("favoridepo").child(userID!).child("\(deger)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let turkce = value?["turkce"] as? String ?? ""
            let ingilizce = value?["ingilizce"] as? String ?? ""
            
            print("SelfSayi")
            print(self.sayi)
            print("SelfDeğer")
            print(self.deger)
            print("SelfDurum")
            print(self.durum)
            
            if turkce != "" {
                self.soruText.text = ingilizce
                self.ekran.image = UIImage(named:"\(ingilizce).png")
                self.cevapText.text = turkce
                print(turkce)
            } else {
                if self.durum == "sonraki" {
                    if self.deger - 1 == self.sayi {
                        self.deger = 1
                    } else {
                    self.deger = self.deger + 1
                    }
                }
                else if self.durum == "onceki" {
                    if self.deger == 0 {
                        self.deger = self.sayi
                    } else {
                    self.deger = self.deger - 1
                    }
                }
                self.viewDidLoad()
                print(ingilizce)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
