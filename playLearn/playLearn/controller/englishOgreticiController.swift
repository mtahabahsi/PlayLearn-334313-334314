//
//  englishOgreticiController.swift
//  playLearn
//
//  Created by Sierra on 5.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class englishOgreticiController: UIViewController {
    
    var deger = 1
    var durum = "sonraki"
    
    @IBOutlet weak var soruText: UILabel!
    @IBOutlet weak var cevapText: UILabel!
    @IBOutlet weak var ekran: UIImageView!
    
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

    @IBAction func favoriEkle(_ sender: UIButton) {
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        var sayi = 1
        ref.child("favoridepo").child(userID!).observe(.value) { snapshot in
            for _ in snapshot.children {
                sayi = sayi + 1
            }
        }
        
        var turkce = ""
        var ingilizce = ""
        ref.child("depo/\(deger)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            turkce = value?["turkce"] as? String ?? ""
            ingilizce = value?["ingilizce"] as? String ?? ""
        })
        
        var kontrolIngilizce = ""
        var kontrolTurkce = ""
        var veriTabaniKontrol = 0
        ref.child("depo/\(deger)").observeSingleEvent(of: .value, with: { (snapshot) in
            for i in 0...sayi - 1{
                self.ref.child("favoridepo").child(userID!).child("\(i)").observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    kontrolTurkce = value?["turkce"] as? String ?? ""
                    kontrolIngilizce = value?["ingilizce"] as? String ?? ""
                    
                    if "\(turkce)" == "\(kontrolTurkce)" || "\(ingilizce)" == "\(kontrolIngilizce)" {
                        veriTabaniKontrol = 1
                    }
                })
            } //for
            
            self.ref.child("depo/\(self.deger)").observeSingleEvent(of: .value, with: { (snapshot) in
                if veriTabaniKontrol == 0 {
                    self.ref.child("favoridepo").child(userID!).child("\(sayi)").setValue(["ingilizce": ingilizce,"turkce":turkce,"deger":sayi])
                    
                    let alert = UIAlertController(title: "Ekleme Başarılı", message: "Kelime Favorilerinize Eklendi", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alert, animated: true, completion:nil)
                }
                else {
                    let alert = UIAlertController(title: "Ooopss", message: "Kelime Zaten Favorilerinizde", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alert, animated: true, completion:nil)
                }
            })
        })
        
    } //favoriEkle
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ref = Database.database().reference()
        
        var depoKayitSayi = 0
        ref.child("depo").observe(.value) { snapshot in
            for _ in snapshot.children {
                depoKayitSayi = depoKayitSayi + 1
            }
        }
        
        ref.child("depo/\(self.deger)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let turkce = value?["turkce"] as? String ?? ""
            let ingilizce = value?["ingilizce"] as? String ?? ""
            
            print("SelfSayi")
            print(depoKayitSayi)
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
                    if self.deger - 1 == depoKayitSayi {
                        self.deger = 1
                    } else {
                        self.deger = self.deger + 1
                    }
                }
                else if self.durum == "onceki" {
                    if self.deger == 0 {
                        self.deger = depoKayitSayi
                    } else {
                        self.deger = self.deger - 1
                    }
                }
                self.viewDidLoad()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
