//
//  ogreticiController.swift
//  playLearn
//
//  Created by Sierra on 13.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class ogreticiController: UIViewController {

    var deger = 1
    var random1:Int?
    var random2:Int?
    var kategori: String?
    
    @IBOutlet weak var soruText: UILabel!
    @IBOutlet weak var cevapText: UILabel!
    
    @IBAction func yenile(_ sender: Any) {
        if deger < 4 {
            deger = deger + 1
        } else {
            deger = 1
        }
        viewDidLoad()
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        var min:Int?
        var max:Int?
        
        if deger == 1 {
            min = 1
            max = 10
        }
        if deger == 2 {
            min = 10
            max = 100
        }
        if deger == 3 {
            min = 100
            max = 1000
        }
        if deger == 4 {
            min = 1000
            max = 10000
        }
        
        var cevap:Int?
        ref.child("mathOgreticiKategori").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.kategori = value?["secim"] as? String ?? ""
        
            if self.kategori == "toplama" {
                self.random1 = Int.rastgele(min: min!, max: max!)
                self.random2 = Int.rastgele(min: min!, max: max!)
                
                cevap = self.random1! + self.random2!
                
                self.soruText.text = " \(self.random1!) + \(self.random2!) "
                self.cevapText.text = "\(cevap!)"
            }
            
            if self.kategori == "cikarma" {
                
                self.random1 = Int.rastgele(min: min!, max: max!)
                self.random2 = Int.rastgele(min: min!, max: max!)
                
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
                
                cevap = self.random1! - self.random2!
                
                self.soruText.text = " \(self.random1!) - \(self.random2!) "
                self.cevapText.text = "\(cevap!)"
            }
            
            if self.kategori == "carpma" {
                self.random1 = Int.rastgele(min: min!, max: max!)
                self.random2 = Int.rastgele(min: min!, max: max!)
                
                cevap = self.random1! * self.random2!
                
                self.soruText.text = " \(self.random1!) * \(self.random2!) "
                self.cevapText.text = "\(cevap!)"
            }
            
            
            if self.kategori == "bolme" {
                self.random1 = Int.rastgele(min: min!, max: max!)
                self.random2 = Int.rastgele(min: min!, max: max!)
                
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
                
                cevap = self.random1! / self.random2!
                
                self.soruText.text = " \(self.random1!) / \(self.random2!) "
                self.cevapText.text = "\(cevap!)"
            }
            
            
            
            
            
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

public extension Int {
    
    public static var rastgele: Int {
        return Int.rastgele(n: Int.max)
    }
    
    public static func rastgele(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    public static func rastgele(min: Int, max: Int) -> Int {
        return Int.rastgele(n: max - min + 1) + min
        
    }
}
