/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */

class Golosina {
	var property peso = 15
	var property libreGluten = false 
	method peso() = peso
	method precio()

}
class Bombon inherits Golosina(libreGluten = true){
	override method precio() = 6
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
}

class BombonDuro inherits Bombon {
	override method mordisco(){
		peso = 0.max(peso - 1)
	}
	method dureza() = 
		if(peso > 12)
			3
		else
			if(peso.between(8, 12))
				2
			else 1
}

class Alfajor inherits Golosina{
	override method precio() = 12
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
}

class Caramelo inherits Golosina(peso = 5,libreGluten = true){
	var property sabor = frutilla
	override method precio() { return 12 }
	method mordisco() { peso = peso - 1 }
}

class CarameloConChocolate inherits Caramelo {
	override method mordisco() {
		super()
		sabor = chocolate
	}
	override method precio() = super() + 1
}

class Chupetin inherits Golosina(peso = 7,libreGluten = true) {
	override method precio() { return 2 }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
}

class Oblea inherits Golosina(peso = 250){
	override method precio() { return 5 }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
}

class ObleaCrujiente inherits Oblea {
	var mordiscos = 0
	override method mordisco() {
		super()
		if(mordiscos <= 3){
		peso = 0.max(peso - 3) 
		mordiscos += 1
		}
	}
	method estaDebil() = mordiscos > 3
}

class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var comido = 0
	override method precio() { return peso * 0.50 }
	override method peso() { return (peso - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
}

class ChocolatinVIP inherits Chocolatin {
	var property humedad
	override method peso(){
		return super() * 1 + humedad
	}
}

class ChocolatinPREMIUM inherits ChocolatinVIP{
	override method humedad() = humedad * 0.5
}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}