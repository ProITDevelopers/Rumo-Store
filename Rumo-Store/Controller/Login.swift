//
//  Login.swift
//  Rumo-Store
//
//  Created by  Snow on 16/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Login: UIViewController {
    
    @IBOutlet weak var email: Textfield!
    @IBOutlet weak var senha: Textfield!
    @IBOutlet weak var carregar: UIActivityIndicatorView!
    @IBOutlet weak var scrollview: UIScrollView!
    var alcance : Reachability?
    
    let url = "https://console.proitappsolutions.com/v1/app/login"

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func entrarButton(_ sender: Any) {
        if email.text == "" && senha.text == "" {
            mostrarMensagem(mensagem: "Preencha os Campos!")
            
        }else {
            //verifica conexao
            self.alcance = Reachability.init()
            if ((self.alcance!.connection) != .none) {
                 login()
            }else {
                print("Internet Not Avaible")
                mostrarMensagem(mensagem: "Sem Conexão a Internet!")
            }
        }
        
    }
    
    
    
    
    func login() {
        email.resignFirstResponder()
        senha.resignFirstResponder()
        self.carregar.startAnimating()
        self.carregar.isHidden = false
        let param = ["email" : email.text!, "password" : senha.text!] as [String : String]
        
        Alamofire.request(url, method: .post, parameters: param).responseJSON {
            response in
            
            if response.result.isSuccess {
                if response.response?.statusCode != 400 {
                    print("OK")
                    
                    let json: JSON = JSON(response.result.value!)
                    print(json)
                    
                    
                    let nome = json["data"]["nomeCliente"].string
                    let email = json["data"]["email"].string
                 
                    UserDefaults.standard.set(nome, forKey: "nome")
                    UserDefaults.standard.set(email, forKey: "email")
                    
                    
                    self.carregar.stopAnimating()
                    let paginaInicial =  self.storyboard?.instantiateViewController(withIdentifier: "paginainicial") as! SWRevealViewController
                    let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = paginaInicial
                }else {
                    
                    self.carregar.stopAnimating()
                    self.mostrarMensagem(mensagem: "Email ou Senha Invalidos!")
                }
                
              

                
                
            }else if response.result.isFailure {
                self.carregar.stopAnimating()
                self.mostrarMensagem(mensagem: "Alguma coisa correu mal, tente novamente mais tarde!")
                print("Error")
            }
            
        }
        
        
    }
    
    
    
    
    func mostrarMensagem(mensagem: String) {
        let mensagem  = UIAlertController(title: "AVISO", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (actions) in
            mensagem.dismiss(animated: true, completion: nil)
        }
        mensagem.addAction(action)
        self.present(mensagem,animated: true, completion: nil)
        
    }
    
    
    
    
    
    
}

extension Login: UITextFieldDelegate {
    
    
    //FUNCOES TEXTFIELDS
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollview.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 0
        {
            senha.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    
    
    
    
    
}
