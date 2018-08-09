/*
import UIKit
import Firebase

class englishSiralamaController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var gelenVeri = [veriModal]()
    var ref: DatabaseReference!
    var dbYol: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        dbYol = ref.child("siralama").child("hayvanlar").child("1").observe(DataEventType.value , with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.gelenVeri.removeAll()
                
                for siralama in snapshot.children.allObjects as![DataSnapshot] {
                    let value = siralama.value as? [String: AnyObject]
                    let alrumuz = value?["rumuz"]
                    let alpuan = value?["puan"]
                    
                    let al = veriModal(rumuz: alrumuz as! String?, puan: alpuan as! String?)
                    
                    self.gelenVeri.append(al)
                }
                self.tableview.reloadData()
            }
        })
        
        self.tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gelenVeri.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! englishSiralamaTableViewCell
        
        let veri: veriModal
        
        veri = gelenVeri[indexPath.row]
        
        cell.rumuz.text = veri.rumuz
        cell.puan.text = veri.puan
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}*/

import UIKit
import Firebase

class englishSiralamaController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref:DatabaseReference!
    var posts = [veriModal]()
    var kategori = "hayvanlar"
    
    @IBAction func hayvan(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("englishSiraKategori").child(userID!).setValue(["secim":"hayvanlar"])
        viewDidLoad()
    }
    
    @IBAction func meyve(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("englishSiraKategori").child(userID!).setValue(["secim":"meyveler"])
        viewDidLoad()
    }
    
    @IBAction func nesne(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("englishSiraKategori").child(userID!).setValue(["secim":"nesneler"])
        viewDidLoad()
    }
    
    @IBAction func renk(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("englishSiraKategori").child(userID!).setValue(["secim":"renkler"])
        viewDidLoad()
    }
    
    @IBAction func sayi(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("englishSiraKategori").child(userID!).setValue(["secim":"sayilar"])
        viewDidLoad()
    }
    
    @IBAction func karisik(_ sender: Any) {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("englishSiraKategori").child(userID!).setValue(["secim":"depo"])
        viewDidLoad()
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        ref = Database.database().reference()
        cek()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cek() {
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("englishSiraKategori").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.kategori = value?["secim"] as? String ?? ""
        
            if self.kategori == "" {
                self.kategori = "hayvanlar"
            }
            
            self.ref.child("yuksekPuan").child(self.kategori).observe(.value, with: {(snapshot) in
            self.posts.removeAll()
            for gelen in snapshot.children.allObjects {
                let gelenSira = gelen as? DataSnapshot
                let sira = gelenSira?.value as? NSDictionary
                let rumuz = sira!["rumuz"] as! String
                let puan = sira!["puan"] as! Int
                let puanlama = veriModal(rumuz: rumuz, puan: puan)
                self.posts.append(puanlama)
            }
            self.tableview.reloadData()
        })
      })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "englishSiralamaCell") as! englishSiralamaTableViewCell
        cell.puan.text = "\(posts[indexPath.row].puan!)"
        cell.rumuz.text = posts[indexPath.row].rumuz
        
        return cell
    }
    
}
