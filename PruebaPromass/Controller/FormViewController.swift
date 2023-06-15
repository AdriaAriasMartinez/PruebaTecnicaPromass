//
//  FormViewController.swift
//  PruebaPromass
//
//  Created by MacBookMBA11 on 14/06/23.
//

import UIKit

class FormViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var contenidoTextView: UITextView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var autorTextField: UITextField!
    @IBOutlet weak var postOutlet: UIButton!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var formView: UIView!
    
    var id: String = ""
    let coreViewModel = CoreViewModel()
    let imagePicker = UIImagePickerController()
    var imagen: UIImage? = nil
    var imgstr: String = ""
    
    @IBAction func selecImageButton(_ sender: UIButton) {
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func postButton(_ sender: UIButton) {
        
        if sender.currentTitle == "Enviar"{
            
            guard let titulo = tituloTextField.text, titulo != "" else { return
                
            }
            guard let autor = autorTextField.text, autor != "" else { return
                
            }
            guard let contenido = contenidoTextView.text, contenido != "" else { return
                
            }
            
            let contenidoArreglo = contenido.components(separatedBy: " ")
            
            guard let imagen = self.imagen, imagen != nil else {
                let alert = UIAlertController(title: "Aviso", message: "Debes seleccionar una imagen de la galería", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
                return
            }
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyy"
            let date = dateFormatter.string(from: Date())
            
            let post = Post(autor: autor, contenido: contenidoArreglo, fecha: date, titulo: titulo, imagen: self.imgstr)
            
            coreViewModel.add(post: post)
            fireBaseViewModel.getById(id: post.titulo) { data, error in
                if  data != nil {
                    
                    let alert = UIAlertController(title: "Aviso", message: "El post ya se encuentra creado", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(ok)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                    
                } else {
                    _ = self.fireBaseViewModel.add(id: post.titulo, post: post)
                    
                    let alert = UIAlertController(title: "Aviso", message: "Post creado correctamente", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default){ action in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true)
                }
            }
        }else{
            guard let titulo = tituloTextField.text, titulo != "" else { return
                
            }
            guard let autor = autorTextField.text, autor != "" else { return
                
            }
            guard let contenido = contenidoTextView.text, contenido != "" else { return
                
            }
            let contenidoArreglo = contenido.components(separatedBy: " ")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyy"
            let date = dateFormatter.string(from: Date())
            
            let post = Post(autor: autor, contenido: contenidoArreglo, fecha: date, titulo: titulo, imagen: self.imgstr)
            fireBaseViewModel.Update(post: post)
            let alert = UIAlertController(title: "Aviso", message: "Post actualizado correctamente", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(ok)
            self.present(alert, animated: true)
            
        }
    }
    
    func validar(id: String){
        if id != ""{
            self.postOutlet.setTitle("Actualizar", for: .normal)
            self.fireBaseViewModel.getById(id: id) { data, error in
                if let data = data{
                    DispatchQueue.main.async {
                        self.autorTextField.text = data.autor
                        var content = ""
                        for i in 0..<data.contenido.count{
                            content = content + "" + data.contenido[i] + " "
                        }
                        
                        self.contenidoTextView.text = content
                        self.tituloTextField.text = data.titulo
                        self.tituloTextField.isUserInteractionEnabled = false
                        let image = Data(base64Encoded: data.imagen)
                        self.selectedImageView.image = UIImage(data: image!)
                        self.imgstr = data.imagen
                    }
                }
            }
            
        }else{
            self.postOutlet.setTitle("Enviar", for: .normal)
            self.selectedImageView.image = UIImage(named: "subir")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hexString = "BDCDD6"
        
        if let color = UIColor(hexString: hexString) {
            
            view.backgroundColor = color
        } else {
            
            print("Valor hexadecimal no válido")
        }
        formView.layer.cornerRadius = 20
        formView.layer.borderWidth = 4.0
        formView.layer.borderColor = UIColor(named: "BordeAzul")?.cgColor
        contenidoTextView.delegate = self
        tituloTextField.delegate = self
        autorTextField.delegate = self
        imagePicker.delegate = self
        contenidoTextView.delegate = self
        validar(id: self.id)
        
    }
    
    let fireBaseViewModel = FireBaseViewModel()
    var post = Post()
    
    func textViewDidChange(_ textView: UITextView) {
        
        if contenidoTextView.text == "" {
            contenidoTextView.text = "Ingrese el contenido"
            contenidoTextView.textColor = UIColor.lightGray
        } else if contenidoTextView.textColor == UIColor.lightGray && !contenidoTextView.text.isEmpty {
            contenidoTextView.text = nil
            contenidoTextView.textColor = UIColor.black
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            
            selectedImageView.image = selectedImage
            imagen = selectedImage
            let imageData = imagen!.jpegData(compressionQuality: 0.1)
            let base64String = imageData!.base64EncodedString()
            self.imgstr = base64String
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
