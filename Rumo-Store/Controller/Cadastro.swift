//
//  Cadastro.swift
//  Rumo-Store
//
//  Created by  Snow on 16/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit
import Alamofire

class Cadastro: UIViewController {
    
    
    @IBOutlet weak var nome: Textfield!
    @IBOutlet weak var email: Textfield!
    @IBOutlet weak var senha: Textfield!
    @IBOutlet weak var repetirSenha: Textfield!
    @IBOutlet weak var carregar: UIActivityIndicatorView!
    @IBOutlet weak var scrollview: UIScrollView!
    var alcance : Reachability?
    
     let url = "https://console.proitappsolutions.com/v1/app"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func registrarButton(_ sender: Any) {
        
         guard  let nome = nome.text, nome.count > 0 else {
            mostrarMensagem(mensagem: "Preencha os Campos")
            return
        }
        
         guard  let email = email.text, email.count > 0 else {
            mostrarMensagem(mensagem: "Preencha os Campos")
            return
        }
        
        guard  let password = senha.text, password.count > 0 else {
            mostrarMensagem(mensagem: "Preencha os Campos")
            return
        }
   
        if senha.text == repetirSenha.text {
            
            self.alcance = Reachability.init()
            if ((self.alcance!.connection) != .none) {
                  cadastrar()
            }else {
                print("Internet Not Avaible")
                mostrarMensagem(mensagem: "Sem Conexão a Internet!")
            }
          
        }else {
            mostrarMensagem(mensagem: "Senhas não Coincidem!")
        }
        
        
        
    }
    
    
    
    
    func cadastrar() {
        repetirSenha.resignFirstResponder()
        self.carregar.startAnimating()
        self.carregar.isHidden = false
        let param = ["nomeCliente" : nome.text!,"email" :  email.text!, "password" : senha.text!] as [String : String]
        
        Alamofire.request(url, method: .post, parameters: param).responseString {
            response in
            
            if response.result.isSuccess {
                print("POST OK")
                self.carregar.stopAnimating()
                self.mostrarMensagem(mensagem: "Cadastro Efetuado com Sucesso")
                let loginPage =  self.storyboard?.instantiateViewController(withIdentifier: "login") as! Login
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = loginPage
                
                
            }else {
                self.carregar.stopAnimating()
                self.mostrarMensagem(mensagem: "Alguma coisa correu mal, verifique os campos ou tente novamente mais tarde!")
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

extension Cadastro: UITextFieldDelegate {
    
    
    //FUNCOES TEXTFIELDS
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollview.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 0
        {
            email.becomeFirstResponder()
        }
        else if textField.tag == 1 {
            senha.becomeFirstResponder()
        }
        else if textField.tag == 2 {
            repetirSenha.becomeFirstResponder()
            
        }
        textField.resignFirstResponder()
        return true
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    
    
    
    
    
}
