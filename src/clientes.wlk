import centros.*
import geografia.*
import vendedores.*

class Cliente{
	var property tipoCliente = null
	method puedeSerAtendido(unVendedor)
}
class Inseguro inherits Cliente{
	override method puedeSerAtendido(unVendedor){
		return unVendedor.esVersatil() and unVendedor.esFirme()
	}
}
class Detallista inherits Cliente{
	override method puedeSerAtendido(unVendedor){
		return unVendedor.totalCertDeProducto() >= 3 
	}
}
class Humanista inherits Cliente{
	override method puedeSerAtendido(unVendedor){
		return unVendedor.esPersonaFisica()
	}
}
