//
//  CoreViewModel.swift
//  PruebaPromass
//
//  Created by MacBookMBA11 on 14/06/23.
//

import Foundation
import UIKit
import CoreData

class CoreViewModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func add(post: Post){
        let context =  appDelegate.persistentContainer.viewContext
        let entidad = NSEntityDescription.entity(forEntityName: "Posts", in: context)
        let postCoredata = NSManagedObject(entity: entidad!, insertInto: context)
        
        var content = ""
        for i in 0..<post.contenido.count {
            content = content + "" + post.contenido[i] + " "
        }
        
        do{
            
            postCoredata.setValue(post.titulo, forKey: "titulo")
            postCoredata.setValue(post.autor, forKey: "autor")
            postCoredata.setValue(post.fecha, forKey: "fecha")
            postCoredata.setValue(content, forKey: "contenido")
            postCoredata.setValue(post.imagen, forKey: "imagen")
            
            try! context.save()
            print("Agregado correctamente")
        }catch let error{
            fatalError("Error al agregar \(error.localizedDescription)")
        }
    }
    
    func GetAll () -> [Post]{
        var postsExistentes = [Post]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        var posts: [Post] = []
        do {
            if let fetchedObjects = try context.fetch(request) as? [NSManagedObject] {
                
                for post in fetchedObjects {
                    guard let property1 = post.value(forKey: "titulo") as? String,
                          let property2 = post.value(forKey: "autor") as? String,
                          let property3 = post.value(forKey: "fecha") as? String,
                          
                            let property5 = post.value(forKey: "imagen") as? String,
                          let property4 = post.value(forKey: "contenido") as? [String]
                            
                    else {
                        continue
                    }
                    
                    let newPost = Post(autor: property2, contenido: property4, fecha: property3, titulo: property1, imagen: property5)
                    posts.append(newPost)
                }
            }
        } catch let error as NSError {
            fatalError("Error al obtener los objetos: \(error), \(error.userInfo)")
        }
        return posts
    }
}
