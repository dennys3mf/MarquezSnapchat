//
//  ViewController.swift
//  MarquezSnapchat
//
//  Created by Dennys Gabriel Marquez Flores on 7/11/23.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class iniciarSesionViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func iniciarGoogle(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            // Manejar el caso en el que no se pueda obtener el clientID, por ejemplo, mostrar un mensaje de error.
            print("Error: No se pudo obtener el clientID de Firebase.")
            return
        }

        // Crear el objeto de configuración para Google Sign In.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Iniciar el flujo de inicio de sesión de Google.
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if let error = error {
                // Manejar el error al iniciar sesión con Google, por ejemplo, mostrar un mensaje de error.
                print("Error al iniciar sesión con Google: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user,
                let idToken = user.idToken?.tokenString else {
                    // Manejar el caso en el que no se puedan obtener los datos del usuario, por ejemplo, mostrar un mensaje de error.
                    print("Error: No se pudieron obtener los datos del usuario.")
                    return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            // Utilizar el credential para autenticar con Firebase.
            // ...
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){(user, error)in
            print("Intentando Iniciar Sesion")
            if error != nil{
                print("Se presento el siguiente error:\(error)")
            }else{
                print("Inicio de sesion exitoso")
            }
        }
    }
}

