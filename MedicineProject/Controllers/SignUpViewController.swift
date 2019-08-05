//
//  SignUpViewController.swift
//  MedicineProject
//
//  Created by apple on 01/08/2019.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    
    var status = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SignUp(_ sender: Any) {
        SaveSignUpData()
    }
    
   
    
    func SaveSignUpData()
    {
        let urlString = "\(AppDelegate.WcfUrl)Employee_Signup"
        let param =
            [
                "name":"\(txtName.text!)",
                "email":"\(txtEmail.text!)",
                "password":"\(txtPassword.text!)",
                "type":"\("Customer")"
            ]
        let header = ["Content-Type":"application/json"]
        Alamofire.request(urlString, method: .post, parameters: param, encoding: JSONEncoding.default, headers:header).responseJSON
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
                        print("Data Saved Successfully")
                    }
                case .failure(let error):
                    print(error)
                }
        
    }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
