import clientes.*
import centros.*
import geografia.*

class Vendedor {
	const property certificaciones = []
	
	method puedeTrabajarEn(unaCiudad)
	
	method esVersatil(){
		return self.totalCertDeProducto() >= 1and 
		     self.otrosCertificados() >= 1 and
		     self.totalCertificaciones() >= 3
	}
	method totalCertDeProducto(){
		return certificaciones.count({cert => cert.esCertificacionDeProductos()})
	}
	method otrosCertificados(){
		return (self.totalCertificaciones() - self.totalCertDeProducto().max(0))
	}
	method totalCertificaciones(){
		return certificaciones.size()
	}
	method esFirme(){
		return certificaciones.sum({c => c.puntos()}) >= 30
	}
	method esInfluyente()
	
	method agregarCertificacion(unaCertificacion){
		certificaciones.add(unaCertificacion)
	}
	method afinidad(unCentro){
		return self.puedeTrabajarEn(unCentro.ciudad())
	}
	method esGenerico(){
		return self.otrosCertificados() >= 1
	}
	
	method puntajeCertificaciones(){
		return certificaciones.sum({c => c.puntos()})
	}
	method esPersonaFisica(){
		return true
	}
	method esCandidato(unCentro){
		return self.esVersatil() and
		self.afinidad(unCentro)
	}
}

class Fijo inherits Vendedor{
	var property ciudadResidencia = null
	override method puedeTrabajarEn(unaCiudad){
		return unaCiudad == ciudadResidencia
	}
	override method esInfluyente(){
		return false
	}
}

class Viajante inherits Vendedor{
	const property provinciasHabilitadas = []
	//revisar porque depende de la provincia
	override method puedeTrabajarEn(unaCiudad){
		return provinciasHabilitadas.contains(unaCiudad.provincia())
	}
	override method esInfluyente(){
		return provinciasHabilitadas.sum({p => p.poblacion()}) >= 10000000
		}
}

class ComercioCorresponsal  inherits Vendedor{
	var property ciudadSucursales = []
	
	override method puedeTrabajarEn(unaCiudad){
		return ciudadSucursales.contains(unaCiudad)
	}
	override method esInfluyente(){
		return self.totalSucursales() >= 5 or
			    self.totalProvincias() >= 3	  
	}
	method totalSucursales(){
		return ciudadSucursales.size()
	}
	method totalProvincias(){
		return ciudadSucursales.map({c => c.provincia()}).asSet().size()
	}
	override method  afinidad(unCentro){
		return super(unCentro) and
		ciudadSucursales.any({c => not unCentro.puedeCubrir(c)})
	}
	override method esPersonaFisica(){
		return false
	}
}

class Certificaciones {
	var property puntos = 0
	var property esCertificacionDeProductos = true
}
