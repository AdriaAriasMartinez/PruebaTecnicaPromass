//
//  FireBaseViewModel.swift
//  PruebaPromass
//
//  Created by MacBookMBA11 on 14/06/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class FireBaseViewModel {
    
    let db = Firestore.firestore()
    var usersCollection: CollectionReference? = nil
    var userDocument: DocumentReference? = nil
    
    let coreViewmodel = CoreViewModel()
    func GetByName(){
        
        usersCollection = db.collection("usuarios")
        userDocument = usersCollection!.document("Usuario1")
        
        
        userDocument!.getDocument { document, error in
            if let document = document, document.exists {
                
            } else {
                print("El documento no existe o ha ocurrido un error:", error?.localizedDescription ?? "")
            }
        }
    }
    
    func getAll1(result: @escaping([Post]?, Error?)-> Void){
        var posts = [Post]()
        usersCollection = db.collection("usuarios")
        userDocument = usersCollection!.document("Usuario1")
        
        usersCollection?.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                result(nil, error)
            }
            
            guard let querySnapshot = querySnapshot else {
                print("No documents found")
                return
            }
            for obj in querySnapshot.documents {
                
                
                let documentData = obj.data()
                
                let objTitulo = documentData["titulo"] as! String
                let objAutor = documentData["autor"] as! String
                let objFecha = documentData["fecha"] as! String
                let objContenido = documentData["contenido"] as! [String]
                let objImagen = documentData["imagen"] as! String
                
                let post = Post(autor: objAutor , contenido: objContenido, fecha: objFecha , titulo: objTitulo, imagen: objImagen )
                posts.append(post)
            }
            result(posts, nil)
        })
    }
    func add(id: String, post: Post) -> Bool{
        var result: Bool = false
        var content: String = ""
        
        for i in 0..<post.contenido.count{
            content = content + "" + post.contenido[i] + " "
        }
        
        
        let collectionRef = db.collection("usuarios")
        let data = toDictionary(post: post)
        
        collectionRef.document(id).setData(data){ error in
            if let error = error{
                result = false
                fatalError("Error agregando el documento: \(error.localizedDescription)")
            }else{
                print("Document added successfully")
                result = true
            }
        }
        return result
    }
    
    func toDictionary(post: Post) -> [String: Any] {
        return [
            "titulo": post.titulo,
            "autor": post.autor,
            "fecha": post.fecha,
            "contenido": post.contenido,
            "imagen": post.imagen
        ]
    }
    func getById(id: String, result: @escaping( Post?, Error?)-> Void){
        
        let collectionRef = db.collection("usuarios")
        collectionRef.document(id).getDocument { documentSnapshot, error in
            if let documentData = documentSnapshot?.data() {
                //print("Error al buscar documento: \(error.localizedDescription)")
                let post = Post(dictionary: documentData)
                result(post, nil)
                
                
            } else {
                result(nil, error)
                
            }
        }
    }
    func getByAutor(autor: String, result: @escaping([Post]?, Error?)->Void){
        var posts = [Post]()
        let collectionRef = db.collection("usuarios")
        collectionRef.whereField("autor", isGreaterThanOrEqualTo: autor).whereField("autor", isLessThan: autor + "\u{f8ff}").getDocuments { querySnapshots, error in
            if let error = error {
                result(nil, error)
            }
            guard let querySnapshots = querySnapshots else {
                print("No documents found")
                return
            }
            for obj in querySnapshots.documents {
                
                
                let documentData = obj.data()
                
                
                let keys = documentData.keys
                print("Keys: \(keys)")
                
                
                let objTitulo = documentData["titulo"] as! String
                let objAutor = documentData["autor"] as! String
                let objFecha = documentData["fecha"] as! String
                let objContenido = documentData["contenido"] as! [String]
                let objImagen = documentData["imagen"] as! String
                
                let post = Post(autor: objAutor , contenido: objContenido , fecha: objFecha , titulo: objTitulo, imagen: objImagen )
                
                posts.append(post)
            }
            result(posts, nil)
        }
    }
    
    func getByContent(content: [String], result: @escaping([Post]?, Error?)->Void){
        var posts = [Post]()
        let collectionRef = db.collection("usuarios")
        
        /*collectionRef.whereField("contenido", isGreaterThanOrEqualTo: "\u{f8ff}" + content).whereField("contenido", isLessThan: content + "\u{f8ff}").getDocuments*/
        collectionRef.whereField("contenido", arrayContainsAny: content).getDocuments { querySnapshots, error in
            if let error = error {
                result(nil, error)
            }
            guard let querySnapshots = querySnapshots else {
                print("No documents found")
                return
            }
            
            for obj in querySnapshots.documents {
                
                let documentData = obj.data()
                
                let objTitulo = documentData["titulo"] as! String
                let objAutor = documentData["autor"] as! String
                let objFecha = documentData["fecha"] as! String
                let objContenido = documentData["contenido"] as! [String]
                let objImagen = documentData["imagen"] as! String
                
                let post = Post(autor: objAutor , contenido: objContenido , fecha: objFecha , titulo: objTitulo, imagen: objImagen )
                
                posts.append(post)
            }
            result(posts, nil)
        }
    }
    
    func getByTitulo(titulo: String, result: @escaping([Post]?, Error?)->Void){
        var posts = [Post]()
        let collectionRef = db.collection("usuarios")
        collectionRef.whereField("titulo", isGreaterThanOrEqualTo: titulo).whereField("titulo", isLessThan: titulo + "\u{f8ff}").getDocuments { querySnapshots, error in
            if let error = error {
                result(nil, error)
            }
            guard let querySnapshots = querySnapshots else {
                print("No documents found")
                return
            }
            for obj in querySnapshots.documents {
                
                
                let documentData = obj.data()
                let keys = documentData.keys
                
                let objTitulo = documentData["titulo"] as! String
                let objAutor = documentData["autor"] as! String
                let objFecha = documentData["fecha"] as! String
                let objContenido = documentData["contenido"] as! [String]
                let objImagen = documentData["imagen"] as! String
                
                let post = Post(autor: objAutor , contenido: objContenido , fecha: objFecha , titulo: objTitulo, imagen: objImagen )
                
                posts.append(post)
            }
            result(posts, nil)
        }
    }
    func Delete(id: String, result: @escaping([Post]?, Error?)->Void){
        
        let collectionRef = db.collection("usuarios")
        let documentRef = collectionRef.document(id)
        
        documentRef.delete { error in
            if error != nil{
                
            }else{
                print("Eliminado correctamente")
            }
        }
    }
    func Update(post: Post){
        let documentRef = db.collection("usuarios").document(post.titulo)
        
        let data = toDictionary(post: post)
        
        documentRef.updateData(data) { error in
            if let error = error{
                print(error)
            }else{
                print("Actualizado correctramente")
            }
        }
    }
}
