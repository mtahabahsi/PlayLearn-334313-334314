//
//  gameController.swift
//  playLearn
//
//  Created by Sierra on 13.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class gameController: UIViewController {

    var skor = 0
    var random:UInt32?
    var random1:Int?
    var random2:Int?
    var kategori = ""
    var basamak = ""
    
    @IBOutlet weak var rumuz: UILabel!
    @IBOutlet weak var puan: UILabel!
    @IBOutlet weak var sorutext: UILabel!
    
    @IBOutlet weak var cevap1text: UIButton!
    @IBOutlet weak var cevap2text: UIButton!
    @IBOutlet weak var cevap3text: UIButton!
    @IBOutlet weak var cevap4text: UIButton!
    
    var ref: DatabaseReference!
    
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
        
    
        var min: Int?
        var max: Int?
        var cevapMax: Int?
        var cevapMin: Int?
        var cevap: Int?
        var sec1: Int?
        var sec2: Int?
        var sec3: Int?
        var sec4: Int?
        var karisikRandom:UInt32?
    ref.child("mathKategori").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.kategori = value?["secim"] as? String ?? ""
        
        self.ref.child("mathBasamak").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.basamak = value?["secim"] as? String ?? ""
       
            print("kategori")
            print(self.kategori)
            print("basamak")
            print(self.basamak)
            
            if self.basamak == "bir" {
                min = 1
                max = 10
            }
            if self.basamak == "iki" {
                min = 10
                max = 100
            }
            if self.basamak == "uc" {
                min = 100
                max = 1000
            }
            if self.basamak == "dort" {
                min = 1000
                max = 10000
            }
            if self.basamak == "karisik" {
                karisikRandom = arc4random_uniform(4) + 1
                if karisikRandom == 1 {
                    min = 1
                    max = 10
                }
                if karisikRandom == 2 {
                    min = 10
                    max = 100
                }
                if karisikRandom == 3 {
                    min = 100
                    max = 1000
                }
                if karisikRandom == 4 {
                    min = 1000
                    max = 10000
                }
            }
            
// Karışık Başlangıç
            
            if self.kategori == "karisik" {
                var kategoriRandom = arc4random_uniform(4) + 1
                print("kategoriRandom")
                print(kategoriRandom)
                
                if kategoriRandom == 1 {
                    self.kategori = "toplama"
                }
                if kategoriRandom == 2 {
                    self.kategori = "cikarma"
                }
                if kategoriRandom == 3 {
                    self.kategori = "carpma"
                }
                if kategoriRandom == 4 {
                    self.kategori = "bolme"
                }
                print("Yeni Kategori")
                print(self.kategori)
            }
            
// Karışık Bitiş
            
// Toplama İşlemi Başlangıç
            if self.kategori == "toplama" {
                
                self.random1 = Int.random(min: min!, max: max!)
                self.random2 = Int.random(min: min!, max: max!)
                
                print(self.random1!)
                print(self.random2!)
                
                cevap = self.random1! + self.random2!
                
                    self.sorutext.text = "\(self.random1!) + \(self.random2!)"
                    
                    if self.random! == 1 {
                        self.cevap1text.setTitle("\(cevap!)", for: .normal)
                    }
                    else if self.random! == 2 {
                        self.cevap2text.setTitle("\(cevap!)", for: .normal)
                    }
                    else if self.random! == 3 {
                        self.cevap3text.setTitle("\(cevap!)", for: .normal)
                    }
                    else if self.random! == 4 {
                        self.cevap4text.setTitle("\(cevap!)", for: .normal)
                    }
            }
// Toplama İşlemi Bitiş
            
// Çıkarma İşlemi Başlangıç
            
            if self.kategori == "cikarma" {
                
                self.random1 = Int.random(min: min!, max: max!)
                self.random2 = Int.random(min: min!, max: max!)
                
                print("random1")
                print(self.random1!)
                print("random2")
                print(self.random2!)
                
                func randomUret() {
                    self.random1 = Int.random(min: min!, max: max!)
                    self.random2 = Int.random(min: min!, max: max!)
                    kontrol()
                }
                
                func kontrol() {
                    if self.random1! <= self.random2! {
                        randomUret()
                    } else {
                        cevap = self.random1! - self.random2!
                    }
                }
                kontrol()
                
                
                print("")
                print("random1")
                print(self.random1!)
                print("random2")
                print(self.random2!)
                print("cevap")
                print(cevap!)
                
                self.sorutext.text = "\(self.random1!) - \(self.random2!)"
                
                if self.random! == 1 {
                    self.cevap1text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 2 {
                    self.cevap2text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 3 {
                    self.cevap3text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 4 {
                    self.cevap4text.setTitle("\(cevap!)", for: .normal)
                }
            }
            
// Çıkarma İşlemi Bitiş
        
// Çarpma İşlemi Başlangıç
            
            if self.kategori == "carpma" {
                
                self.random1 = Int.random(min: min!, max: max!)
                self.random2 = Int.random(min: min!, max: max!)
                
                print(self.random1!)
                print(self.random2!)
                
                cevap = self.random1! * self.random2!
                
                self.sorutext.text = "\(self.random1!) * \(self.random2!)"
                
                if self.random! == 1 {
                    self.cevap1text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 2 {
                    self.cevap2text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 3 {
                    self.cevap3text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 4 {
                    self.cevap4text.setTitle("\(cevap!)", for: .normal)
                }
            }
  
// Çarpma İşlemi Bitiş
     
            
// Bölme İşlemi Başlangıç
            
            if self.kategori == "bolme" {
                
                self.random1 = Int.random(min: min!, max: max!)
                self.random2 = Int.random(min: min!, max: max!)
                
                print("random1")
                print(self.random1!)
                print("random2")
                print(self.random2!)
                
                // Bölme Algoritması
                func randomUret() {
                    self.random1 = Int.random(min: min!, max: max!)
                    self.random2 = Int.random(min: min!, max: max!)
                    kontrol()
                }
                
                func kontrol() {
                    if self.random1! <= self.random2! {
                        randomUret()
                    } else {
                        if self.random1! % self.random2! == 0 {
                            cevap = self.random1! / self.random2!
                        } else {
                            randomUret()
                        }
                    }
                }
                kontrol()
                
                /*var al = self.random1! * self.random2!
                cevap = al / self.random2!
                
                print("")
                print("random1")
                print(self.random1!)
                print("random2")
                print(self.random2!)
                print("cevap")
                print(cevap!)
    
                
                self.sorutext.text = "\(al) / \(self.random2!)"*/
                
                cevap = self.random1! / self.random2!
                
                self.sorutext.text = " \(self.random1!) / \(self.random2!) "
                
                if self.random! == 1 {
                    self.cevap1text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 2 {
                    self.cevap2text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 3 {
                    self.cevap3text.setTitle("\(cevap!)", for: .normal)
                }
                else if self.random! == 4 {
                    self.cevap4text.setTitle("\(cevap!)", for: .normal)
                }
            }
            
// Bölme İşlemi Bitiş
            
            
            
// Seçeneklerin Üretimi Başlangıç
            
            cevapMax = cevap! + 5
            cevapMin = cevap! - 5
                
            sec1 = Int.random(min: cevapMin!, max: cevapMax!)
            sec2 = Int.random(min: cevapMin!, max: cevapMax!)
            sec3 = Int.random(min: cevapMin!, max: cevapMax!)
            sec4 = Int.random(min: cevapMin!, max: cevapMax!)
            
            func sec1uret() {
                sec1 = Int.random(min: cevapMin!, max: cevapMax!)
            }
            func sec2uret() {
                sec2 = Int.random(min: cevapMin!, max: cevapMax!)
            }
            func sec3uret() {
                sec3 = Int.random(min: cevapMin!, max: cevapMax!)
            }
            func sec4uret() {
                sec4 = Int.random(min: cevapMin!, max: cevapMax!)
            }
            
            func kontrolEt() {
                if sec1 == cevap {
                    sec1uret()
                }
                if sec2 == cevap || sec2 == sec1 {
                    sec2uret()
                }
                if sec3 == cevap || sec3 == sec2 || sec3 == sec1 {
                    sec3uret()
                }
                if sec4 == cevap || sec4 == sec3 || sec4 == sec2 || sec4 == sec1 {
                    sec4uret()
                }
            }
            kontrolEt() //Kontrol 1
            kontrolEt() //Kontrol 2
            kontrolEt() //Kontrol 3
            kontrolEt() //Kontrol 4
            kontrolEt() //Kontrol 5
            kontrolEt() //Kontrol 6
            
            print("sec1")
            print(sec1!)
            print("sec2")
            print(sec2!)
            print("sec3")
            print(sec3!)
            print("sec4")
            print(sec4!)
            
            
            if self.random! == 1 {
                self.cevap2text.setTitle("\(sec2!)", for: .normal)
                self.cevap3text.setTitle("\(sec3!)", for: .normal)
                self.cevap4text.setTitle("\(sec4!)", for: .normal)
            }
            else if self.random! == 2 {
                self.cevap1text.setTitle("\(sec1!)", for: .normal)
                self.cevap3text.setTitle("\(sec3!)", for: .normal)
                self.cevap4text.setTitle("\(sec4!)", for: .normal)
            }
            else if self.random! == 3 {
                self.cevap1text.setTitle("\(sec1!)", for: .normal)
                self.cevap2text.setTitle("\(sec2!)", for: .normal)
                self.cevap4text.setTitle("\(sec4!)", for: .normal)
            }
            else if self.random! == 4 {
                self.cevap1text.setTitle("\(sec1!)", for: .normal)
                self.cevap2text.setTitle("\(sec2!)", for: .normal)
                self.cevap3text.setTitle("\(sec3!)", for: .normal)
            }
// Seçeneklerin Üretimi Bitiş
            
    })
  })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func skorAyarla() {
        skor = skor + 10
        puan.text = "Puan: \(skor)"
    }
    func uyarı() {
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("mathKategori").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.kategori = value?["secim"] as? String ?? ""
            
        
    
            
            self.ref.child("mathBasamak").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.basamak = value?["secim"] as? String ?? ""
        
                
                self.ref.child("rumuz").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let rumuz = value?["rumuz"] as? String ?? ""

                self.ref.child("mathPuan").child(self.kategori).child(self.basamak).child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let eskiSkor = value?["puan"] as? Int ?? 0
                    
                    if self.skor > eskiSkor {
                        self.ref.child("mathPuan").child(self.kategori).child(self.basamak).child(userID!).setValue(["puan":self.skor,"rumuz":rumuz])
                        
                        let alert = UIAlertController(title: "Yanlış Cevap", message: "Tebrikler :) \n Yeni Yüksek Puan", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ana Sayfa", style: UIAlertActionStyle.default, handler: {_ in self.performSegue(withIdentifier: "mathGameOver", sender: self)
                        }))
                        self.present(alert, animated: true, completion:nil)
                    } else {
                        let alert = UIAlertController(title: "Yanlış Cevap", message: "Üzgünüm :( \n Eski Skorunu Geçemedin.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ana Sayfa", style: UIAlertActionStyle.default, handler: {_ in self.performSegue(withIdentifier: "mathGameOver", sender: self)
                        }))
                        self.present(alert, animated: true, completion:nil)
                        
                    }
                    
                })
            })
        })
    })
        
}


    @IBAction func cevap1(_ sender: Any) {
        if self.random == 1 {
            skorAyarla()
            viewDidLoad()
        } else {
            uyarı()
        }
    }
    @IBAction func cevap2(_ sender: Any) {
        if self.random == 2 {
            skorAyarla()
            viewDidLoad()
        } else {
            uyarı()
        }
    }
    @IBAction func cevap3(_ sender: Any) {
        if self.random == 3 {
            skorAyarla()
            viewDidLoad()
        } else {
            uyarı()
        }
    }
    
    @IBAction func cevap4(_ sender: Any) {
        if self.random == 4 {
            skorAyarla()
            viewDidLoad()
        } else {
            uyarı()
        }
    }
    
}

public extension Int {
    
    public static var random: Int {
        return Int.random(n: Int.max)
    }
    
    public static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    public static func random(min: Int, max: Int) -> Int {
        return Int.random(n: max - min + 1) + min
        
    }
}
