import clientes.*
import geografia.*
import vendedores.*

class Centro {
	var property ciudad = null
	var property vendedores = []
	
	method agregarVendedor(unVendedor){
		if (not vendedores.contains(unVendedor)){
			vendedores.add(unVendedor)
		}else{
			self.error("El vendedor ya esta en la nomina")
		}
	}
	method vendedodorEstrella(){
		return vendedores.max({v => v.puntajeCertificaciones()})	
	}
	method puedeCubrir(unaCiudad){
		return vendedores.any({v => v.puedeTrabajarEn(unaCiudad)})
	}
	method vendedoresGenericos(){
		return vendedores.filter({v => v.esGenerico()})
	}
	method esRobusto(){
		return vendedores.count({v => v.esFirme()}) >= 3
	}
	method repartirCertificacion(unaCertificacion){
		return vendedores.forEach({v => v.agregarCertificacion(unaCertificacion)})
	}
}
