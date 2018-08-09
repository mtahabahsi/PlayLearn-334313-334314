//
//  englishGameController.swift
//  playLearn
//
//  Created by Sierra on 4.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class englishGameController: UIViewController {

    var deger = 1
    var skor = 0
    var random:UInt32?
    var kategori = ""
    var durum = 0
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var rumuz: UILabel!
    @IBOutlet weak var puan: UILabel!
    @IBOutlet weak var sorutext: UILabel!
    
    @IBOutlet weak var cevap1text: UIButton!
    @IBOutlet weak var cevap2text: UIButton!
    @IBOutlet weak var cevap3text: UIButton!
    @IBOutlet weak var cevap4text: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        random = arc4random_uniform(4) + 1
        
        ref.child("rumuz").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let rumuzAd = value?["rumuz"] as? String ?? ""
    
            if rumuzAd == "" {
                let alert = UIAlertController(title: "Kullanıcı Adı", message: "Lütfen Bir Kullanıcı Adı Belirleyin.", preferredStyle: UIAlertControllerStyle.alert)
                
                let belirle = UIAlertAction(title: "Belirle", style: .default, handler: { (action: UIAlertAction!) in
                    
                    let textField = alert.textFields![0] as UITextField
                    textField.keyboardType = UIKeyboardType.numberPad
                    
                    self.ref.child("rumuz").child(userID!).setValue(["rumuz":textField.text])
                    
                    let alert = UIAlertController(title: "Başarılı", message: "Kullanıcı Adı Belirlendi", preferredStyle: UIAlertControllerStyle.alert)
                    self.present(alert, animated: true) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                            guard self?.presentedViewController == alert else { return }
                            
                            self?.dismiss(animated: true) {
                            }
                        }
                    }
                    
                })
                
                alert.addTextField { (textField: UITextField!) in
                    textField.placeholder = "Kullanıcı Adınızı Belirleyin..."
                }
                
                alert.addAction(belirle)
                
                self.present(alert, animated: true, completion: nil)
            } else {
                self.rumuz.text = rumuzAd
            }
            
        })
        
        
        
        ref.child("kategori").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.kategori = value?["secim"] as? String ?? ""
            
            var kayitSayi = 0 // Kayıt Sayısı
            self.ref.child("\(self.kategori)").observe(.value) { snapshot in
                for child in snapshot.children {
                    kayitSayi = kayitSayi + 1
                }
            
            self.deger = Int(arc4random_uniform(UInt32(kayitSayi)) + 1) // Değeri random al
            
            self.ref.child("\(self.kategori)/\(self.deger)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let turkce = value?["turkce"] as? String ?? ""
                let ingilizce = value?["ingilizce"] as? String ?? ""
                
                self.sorutext.text = ingilizce
            
                if self.random! == 1 {
                    self.cevap1text.setTitle(turkce, for: .normal)
                    self.cevap1text.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
                    //self.cevap1text.setImage(UIImage(named: "\(sec2).png"), for: .normal)
                }
                else if self.random! == 2 {
                    self.cevap2text.setTitle(turkce, for: .normal)
                    self.cevap2text.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
                }
                else if self.random! == 3 {
                    self.cevap3text.setTitle(turkce, for: .normal)
                    self.cevap3text.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
                }
                else if self.random! == 4 {
                    self.cevap4text.setTitle(turkce, for: .normal)
                    self.cevap4text.setBackgroundImage(UIImage(named: "\(ingilizce).png"), for: .normal)
                }
                    
            var random1 = arc4random_uniform(UInt32(kayitSayi)) + 1
            var random2 = arc4random_uniform(UInt32(kayitSayi)) + 1
            var random3 = arc4random_uniform(UInt32(kayitSayi)) + 1
            var random4 = arc4random_uniform(UInt32(kayitSayi)) + 1
                    
                    func random1uret() {
                        random1 = arc4random_uniform(UInt32(kayitSayi)) + 1
                    }
                    func random2uret() {
                        random2 = arc4random_uniform(UInt32(kayitSayi)) + 1
                    }
                    func random3uret() {
                        random3 = arc4random_uniform(UInt32(kayitSayi)) + 1
                    }
                    func random4uret() {
                        random4 = arc4random_uniform(UInt32(kayitSayi)) + 1
                    }
                    
                    
                    func kontrolEt() {
                    if random1 == self.deger {
                        random1uret()
                    }
                    if random2 == self.deger || random2 == random1 {
                        random2uret()
                    }
                    if random3 == self.deger || random3 == random2 || random3 == random1 {
                        random3uret()
                    }
                    if random4 == self.deger || random4 == random3 || random4 == random2 || random4 == random1 {
                        random4uret()
                    }
                    }
                    kontrolEt() //Kontrol 1
                    kontrolEt() //Kontrol 2
                    kontrolEt() //Kontrol 3
                    kontrolEt() //Kontrol 4
                    kontrolEt() //Kontrol 5
                    kontrolEt() //Kontrol 6
                    
            
                    
            self.ref.child("\(self.kategori)").child("\(random1)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let sec1 = value?["turkce"] as? String ?? ""
                let ing1 = value?["ingilizce"] as? String ?? ""
                
                if self.random! == 2 {
                    self.cevap1text.setTitle(sec1, for: .normal)
                    self.cevap1text.setBackgroundImage(UIImage(named: "\(ing1).png"), for: .normal)
                }
                else if self.random! == 3 {
                    self.cevap1text.setTitle(sec1, for: .normal)
                    self.cevap1text.setBackgroundImage(UIImage(named: "\(ing1).png"), for: .normal)
                }
                else if self.random! == 4 {
                    self.cevap1text.setTitle(sec1, for: .normal)
                    self.cevap1text.setBackgroundImage(UIImage(named: "\(ing1).png"), for: .normal)
                }
            })
            
            self.ref.child("\(self.kategori)").child("\(random2)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let sec2 = value?["turkce"] as? String ?? ""
                let ing2 = value?["ingilizce"] as? String ?? ""
                
                if self.random! == 1 {
                    self.cevap2text.setTitle(sec2, for: .normal)
                    self.cevap2text.setBackgroundImage(UIImage(named: "\(ing2).png"), for: .normal)
                }
                else if self.random! == 3 {
                    self.cevap2text.setTitle(sec2, for: .normal)
                    self.cevap2text.setBackgroundImage(UIImage(named: "\(ing2).png"), for: .normal)
                }
                else if self.random! == 4 {
                    self.cevap2text.setTitle(sec2, for: .normal)
                    self.cevap2text.setBackgroundImage(UIImage(named: "\(ing2).png"), for: .normal)
                }
            })
            
            self.ref.child("\(self.kategori)").child("\(random3)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let sec3 = value?["turkce"] as? String ?? ""
                let ing3 = value?["ingilizce"] as? String ?? ""
                
                if self.random! == 1 {
                    self.cevap3text.setTitle(sec3, for: .normal)
                    self.cevap3text.setBackgroundImage(UIImage(named: "\(ing3).png"), for: .normal)
                }
                else if self.random! == 2 {
                    self.cevap3text.setTitle(sec3, for: .normal)
                    self.cevap3text.setBackgroundImage(UIImage(named: "\(ing3).png"), for: .normal)
                }
                else if self.random! == 4 {
                    self.cevap3text.setTitle(sec3, for: .normal)
                    self.cevap3text.setBackgroundImage(UIImage(named: "\(ing3).png"), for: .normal)
                }
            })
            
            self.ref.child("\(self.kategori)").child("\(random4)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let sec4 = value?["turkce"] as? String ?? ""
                let ing4 = value?["ingilizce"] as? String ?? ""
                
                if self.random! == 1 {
                    self.cevap4text.setTitle(sec4, for: .normal)
                    self.cevap4text.setBackgroundImage(UIImage(named: "\(ing4).png"), for: .normal)
                }
                else if self.random! == 2 {
                    self.cevap4text.setTitle(sec4, for: .normal)
                    self.cevap4text.setBackgroundImage(UIImage(named: "\(ing4).png"), for: .normal)
                }
                else if self.random! == 3 {
                    self.cevap4text.setTitle(sec4, for: .normal)
                    self.cevap4text.setBackgroundImage(UIImage(named: "\(ing4).png"), for: .normal)
                }
              })
           })
        }// Kayıt Sayısının
    })
}
    
    
    func favoriEkle() {
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
//Puanlama Başlangıcı
        
        var number = 1 // siralama tablosu boyutu
        ref.child("siralama").child(self.kategori).observe(.value) { snapshot in
            for _ in snapshot.children {
                number = number + 1
            }
        }
        
        var kontrolRumuz = "" // siralama tablosunda var mı kontrolü
        var veriTabaniKontrol = 0
        var rumuzAd = ""
        ref.child("rumuz").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            rumuzAd = value?["rumuz"] as? String ?? ""
            
            for _ in 1...number {
                self.ref.child("yuksekpuan").child(self.kategori).child("userID").observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    kontrolRumuz = value?["rumuz"] as? String ?? ""
 
                    if "\(rumuzAd)" == "\(kontrolRumuz)" {
                        veriTabaniKontrol = 1
                    }
                })
            }
        
        
        self.ref.child("yuksekPuan").child(self.kategori).child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let eskiSkor = value?["puan"] as? Int ?? 0
            
            if self.skor > eskiSkor {
                
                if veriTabaniKontrol == 0 {
                    self.ref.child("yuksekPuan").child(self.kategori).child(userID!).setValue(["rumuz":rumuzAd,"puan":self.skor])
                } else {
                    self.ref.child("yuksekPuan").child(self.kategori).child(userID!).setValue(["rumuz":rumuzAd,"puan":self.skor])
                }
                
            }
        })
    })
        // Puanlama Bitişi
        
        var sayi = 1
        ref.child("favoridepo").child(userID!).observe(.value) { snapshot in
            for _ in snapshot.children {
                sayi = sayi + 1
            }}
        
        ref.child("kategori").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.kategori = value?["secim"] as? String ?? ""
            })
        
        var turkce = ""
        var ingilizce = ""
        ref.child("\(self.kategori)").child("\(self.deger)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                turkce = value?["turkce"] as? String ?? ""
                ingilizce = value?["ingilizce"] as? String ?? ""
            })
        
        var kontrolTurkce = ""
        var kontrolIngilizce = ""
        ref.child("depo/\(deger)").observeSingleEvent(of: .value, with: { (snapshot) in
            for i in 0...sayi - 1{
                self.ref.child("favoridepo").child(userID!).child("\(i)").observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    kontrolTurkce = value?["turkce"] as? String ?? ""
                    kontrolIngilizce = value?["ingilizce"] as? String ?? ""
                    
                    if "\(turkce)" == "\(kontrolTurkce)" || "\(ingilizce)" == "\(kontrolIngilizce)" {
                        self.durum = 1
                    }
                })
            } //for
            
            self.ref.child("depo/\(self.deger)").observeSingleEvent(of: .value, with: { (snapshot) in
                if self.durum == 0 {
                    self.ref.child("favoridepo").child(userID!).child("\(sayi)").setValue(["ingilizce":ingilizce,"turkce":turkce,"deger":sayi])
                    
                    let alert = UIAlertController(title: "\(ingilizce) = \(turkce)", message: "Favori Kelimelere Eklendi.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ana Sayfa", style: UIAlertActionStyle.default, handler:{_ in self.performSegue(withIdentifier: "gameOver", sender: self)
                    }))
                    self.present(alert, animated: true, completion:nil)
                }
                else {
                    let alert = UIAlertController(title: "Yanlış Cevap", message: "\(ingilizce) = \(turkce) \n Kelime Favori Kelimelerinizde. \n Bu kelimeye daha fazla çalışmalısınız.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ana Sayfa", style: UIAlertActionStyle.default, handler:{_ in self.performSegue(withIdentifier: "gameOver", sender: self)
                    }))
                    self.present(alert, animated: true, completion:nil)
                }
            })
        })
  }
    
    func skorAyarla() {
        skor = skor + 10
        puan.text = "Puan: \(skor)"
        deger = deger + 1
    }
    /*func uyarı() {
        
        var turkce = ""
        var ingilizce = ""
        ref.child("\(self.kategori)").child("\(self.deger)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            turkce = value?["turkce"] as? String ?? ""
            ingilizce = value?["ingilizce"] as? String ?? ""
        
        
        let alert = UIAlertController(title: "\(ingilizce) = \(turkce)", message: "Favori Kelimelere Eklendi.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ana Sayfa", style: UIAlertActionStyle.default, handler: {_ in self.performSegue(withIdentifier: "gameOver", sender: self)
        }))
        self.present(alert, animated: true, completion:nil)
            
        })
    }*/
    
    @IBAction func cevap1(_ sender: Any) {
        if self.random == 1 {
            skorAyarla()
            viewDidLoad()
        } else {
            favoriEkle()
            //uyarı()
        }
    }
    @IBAction func cevap2(_ sender: Any) {
        if self.random == 2 {
            skorAyarla()
            viewDidLoad()
        } else {
            favoriEkle()
            //uyarı()
        }
    }
    @IBAction func cevap3(_ sender: Any) {
        if self.random == 3 {
            skorAyarla()
            viewDidLoad()
        } else {
            favoriEkle()
            //uyarı()
        }
    }
    
    @IBAction func cevap4(_ sender: Any) {
        if self.random == 4 {
            skorAyarla()
            viewDidLoad()
        } else {
            favoriEkle()
            //uyarı()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
