//
//  MercadoWeb.swift
//  Rumo-Store
//
//  Created by  Snow on 16/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit
import WebKit

class MercadoWeb: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var carregar: UIActivityIndicatorView!
    @IBOutlet weak var menuBotao: UIBarButtonItem!
    @IBOutlet weak var sairBotao: UIBarButtonItem!
    
    var alcance : Reachability?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBotao.target = self.revealViewController()
        menuBotao.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        self.revealViewController()?.rearViewRevealWidth = 305
        
        
        //verifica conexao
        self.alcance = Reachability.init()
        if ((self.alcance!.connection) != .none) {
            
            //fazer o pedido da url
            let request = URLRequest(url: URL(string: "https://www.mercado.co.ao/")!)
            self.webview.load(request)
            self.webview.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
            
            
        }else {
            print("Internet Not Avaible")
            mostrarMensagem(mensagem: "Sem Conexão a Internet!")
        }
        

    }
    
    
    
    @IBAction func sairButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "nome")
        let loginPage =  self.storyboard?.instantiateViewController(withIdentifier: "login") as! Login
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = loginPage
        
    }
    
    
    func mostrarMensagem(mensagem: String) {
        let mensagem  = UIAlertController(title: "AVISO", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (actions) in
            mensagem.dismiss(animated: true, completion: nil)
        }
        mensagem.addAction(action)
        self.present(mensagem,animated: true, completion: nil)
        
    }
    
    
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            
            if webview.isLoading {
                carregar.startAnimating()
                carregar.isHidden = false
                
            }else {
                carregar.stopAnimating()
                
            }
        }
    }
    
    
    
}

