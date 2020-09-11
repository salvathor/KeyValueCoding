import Foundation

//Clase sin KeyValueCoding (NSObject)
class Carrito2 {
  var articulo: String
  var cantidad: Int
  
  init(){
    self.articulo = ""
    self.cantidad = 0
  }
}

var carrito2 = Carrito2()

carrito2.articulo
carrito2.cantidad

// Metodos de KeyValueCoding //Error
//carrito2.setValue("jabon", forKey: "articulo") //Error
//carrito2.setValue(4, forKey: "cantidad") //Error

// Metodo value de NSObject
//carrito2.value(forKey: "articulo") //Error
//carrito2.value(forKey: "cantidad") //Error



//Clase con KeyValueCoding (NSObject)

//Usamos dynamic para notificarle al GCD que administre ese recurso.
//@objc es un requisito para dynamic.

class Carrito: NSObject{
  @objc dynamic var articulo: String
  @objc dynamic var cantidad: Int
  
  override init() {
    self.articulo = ""
    self.cantidad = 0
    super.init()
  }
}

var carrito = Carrito()

carrito.articulo
carrito.cantidad

// Metodos de KeyValueCoding

// Metodo setValue de NSObject
carrito.setValue("jabon", forKey: "articulo")
carrito.setValue(4, forKey: "cantidad")

// Metodo value de NSObject
carrito.value(forKey: "articulo")
carrito.value(forKey: "cantidad")



// Clase Observador
class Observador: NSObject{
  
  override init(){
    print("Se ha creado el observador...")
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    
    guard let keyPath = keyPath, let change = change else {
      return
    }
    
    if let newValue = change[NSKeyValueChangeKey.newKey], let oldValue = change[NSKeyValueChangeKey.oldKey]{
      // Realizar acciones con el nuevo valo, por ejemplo, refrescar una tabla, un collection view, hacer un llamado a un ws, etc.
      print("La propiedad \(keyPath) antes era: \(oldValue) y ahora el valor es: \(newValue)")
    }
    
  }
  
}

let carritoObservado = Carrito()

let observer = Observador()

carritoObservado.addObserver(observer, forKeyPath: #keyPath(Carrito.cantidad), options: [.new, .old], context: nil)

print(carritoObservado.value(forKey: "articulo")!)
print(carritoObservado.value(forKey: "cantidad")!)

carritoObservado.setValue("jabon", forKey: "articulo")

print(carritoObservado.value(forKey: "articulo")!)
print(carritoObservado.value(forKey: "cantidad")!)

carritoObservado.cantidad = 4
