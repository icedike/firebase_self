//
//  ViewController.swift
//  FireBase_Self_Test
//
//  Created by LIN TINGMIN on 17/11/2016.
//  Copyright © 2016 MarkRobotDesign. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signIn(withEmail: "icedike@gg.com", password: "12345678", completion: { (user, error) in
            if error != nil{
                print(error?.localizedDescription ?? "")
                return
            }
            print("email:\(user?.email)")
            print("uid:\(user?.uid)")
            
        })
        
        let user = FIRAuth.auth()?.currentUser!
        print("email:\(user?.email)")
        print("uid:\(user?.uid)")
        let ref = FIRDatabase.database().reference()
        if let okEmail = user?.email, let okUid = user?.uid {
            ref.child(okUid).setValue(["user":okEmail])
        }
        
        if let okUid = user?.uid{
            ref.child("\(okUid)/user").setValue("icedike")
        }
        
        guard let okUid = user?.uid else{return}
        
        ref.child(okUid).observe(.value, with:{
            (snapshot) in
            let data = snapshot.value as? [String:Any] ?? [:]
            print(data)
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

