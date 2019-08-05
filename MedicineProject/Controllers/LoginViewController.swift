//
//  LoginViewController.swift
//  MedicineProject
//
//  Created by apple on 04/08/2019.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    
    var email = ""
    var password = ""
    var type = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnLogin(_ sender: Any) {
        loginUser()
    }
    
    
    
    func loginUser()
    {
        let urlString = "\(AppDelegate.WcfUrl)SignInUser"
        let param =
            [
                "email":"\(txtEmail.text!)",
                "password":"\(txtPass.text!)"
        ]
        let hearder = ["Content-Type":"application/json"]
        Alamofire.request(urlString, method: .post, parameters: param, encoding: JSONEncoding.default, headers: hearder).responseJSON
            {
                response in
                print(response.request as Any)
                print(response.response as Any)
                print(response.data as Any)
                print(response.result as Any)
                
                switch response.result
                {
                case .success:
                    if let JSON = response.result.value
                    {
                        let dlc = (JSON as! NSDictionary)
                        print(dlc)
                        let outPut = dlc.value(forKey: "SignInUserResult") as! NSArray
                        for item in outPut
                        {
                            let tempitem = item as! NSDictionary
                            print(tempitem)
                            self.email = tempitem.value(forKey: "email") as! String
                            self.password = tempitem.value(forKey: "password") as! String
                            self.type = tempitem.value(forKey: "type") as! String
                            self.name = tempitem.value(forKey: "name") as! String
                        }
                        if((self.email == "") && (self.password == ""))
                        {
                            let alert = UIAlertController(title: "Sign in", message: "No Record Found", preferredStyle: .alert)
                            let btn = UIAlertAction(title: "Ok", style: .default)
                            alert.addAction(btn)
                            self.present (alert, animated: true, completion: nil)
                        }
                        else
                        {
                            DispatchQueue.main.async
                                {
                                    print("\(self.email) and \(self.password) exists")
                                    //----------------------Checking status and navigating to relevant storyboard------------------------//
                                    if self.type == "Customer"
                                    {
                                        let ac = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardCustomerViewController") as! DashBoardCustomerViewController
                                        ac.customerName = self.name
                                        self.navigationController?.pushViewController(ac, animated: true)
                                    }
                                    else if self.type == "Admin"
                                    {
                                        let ac = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardAdminViewController") as! DashBoardAdminViewController
                                        ac.name = self.name
                                        self.navigationController?.pushViewController(ac, animated: true)
                                    }
                                    else if self.type == "Delivery Boy"
                                    { 
                                        let ac = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardDeliveryViewController") as! DashBoardDeliveryViewController
                                        ac.name = self.name
                                        self.navigationController?.pushViewController(ac, animated: true)
                                    }
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }
        //lblPhone.text = ""
        //lblPwd.text = ""
    }
    
    
    
    
    
}
