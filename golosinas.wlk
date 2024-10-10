class Golosina {
    var property precio
    var property sabor
    var property gramos
    var property gluten

  method mordisco() {
    gramos = gramos * 0.8 - 1
  }

}


//*****************************************************************
class Bombon inherits Golosina(precio = 5, sabor = frutilla, gramos = 15, gluten = true) {
    // override method mordisco() {
    //   gramos = gramos * 0.8 - 1
    // }
}

//*****************************************************************
class Alfajor inherits Golosina(precio = 12, sabor = chocolate, gramos = 300, gluten = false) {

    override method mordisco() {
      gramos = gramos * 0.8
    }
}

//*****************************************************************
class Caramelo inherits Golosina(precio = 1, sabor = frutilla, gramos = 5, gluten = true) {

    override method mordisco() {
      gramos -= 1
    }
}

//*****************************************************************
class Chupetin inherits Golosina(precio = 2, sabor = naranja, gramos = 7, gluten = true) {

    override method mordisco() {
        if(gramos > 2) {
            gramos = gramos * 0.9
        }
    }
}

//*****************************************************************
class Oblea inherits Golosina(precio = 5, sabor = vainilla, gramos = 250, gluten = false) {

    override method mordisco() {
        if(gramos > 70) {
            gramos = gramos / 2
        } else {
            gramos = gramos * 0.25
        }
    }
}

//*****************************************************************
class Chocolatin inherits Golosina(sabor = chocolate, gluten = false, gramos = pesoIni, precio = 0) {
    
    var property pesoIni = 0

    override method mordisco() {
      gramos -= 2
    }

    override method precio() = 0.5 * pesoIni
    override method gramos(g) {
      gramos = g
      pesoIni = g
    }
}
// const chocolatin = new Chocolatin(pesoIni = 2)

//*****************************************************************
class GolosinaBaniada inherits Golosina(gramos = golosinaBase.gramos() + self.baniado(), precio = golosinaBase.precio(), gluten = golosinaBase.gluten(), sabor = golosinaBase.sabor()) {
    var property baniado = 4
    var property golosinaBase

    override method mordisco() {
        self.golosinaBase().mordisco()
        baniado -= 2
    }

    // method baniarGolosina() {
    //   gramos = self.gramos()
    //   precio = self.precio()
    //   gluten = self.gluten()
    //   sabor = self.sabor()
    // } 

    override method gramos() = self.golosinaBase().gramos() + baniado.max(0)
    override method precio() = self.golosinaBase().precio() + 2
    override method gluten() = self.golosinaBase().gluten()
    override method sabor() = self.golosinaBase().sabor()
}
const carameloBaniado = new GolosinaBaniada( golosinaBase = new Caramelo() )

//*****************************************************************
class PastillaTutFrut inherits Golosina(sabor = frutilla, gramos = 5, precio = 0) {
    var property m = 0

    override method mordisco() {
      sabor = sabor.siguiente() 
    }
    override method precio() {
        return if (self.gluten()) 7 
        else  10 
    }
}
const pastillaSinGluten = new PastillaTutFrut(gluten = false)
const pastillaConGluten = new PastillaTutFrut(gluten = true)

//*****************************************************************
object frutilla {
  method siguiente() = chocolate
}
object chocolate {
  method siguiente() = naranja
}
object naranja {
  method siguiente() = frutilla
}
object vainilla {
  method siguiente() = chocolate
}

//*****************************************************************
object mariano {
  const property bolsa = []

  method comprar(golosina) { bolsa.add(golosina) }
  method desechar(golosina) { bolsa.remove(golosina) }
  method probarGolosinas() { bolsa.forEach { golosina => golosina.mordisco() } }
  method hayGolosinasSinTACC() = bolsa.any { golosina => golosina.gluten() }
  method preciosCuidados() = bolsa.all { golosina => golosina.precio() < 10 }
  method golosinaDeSabor(sabor) = bolsa.find { golosina => golosina.sabor() == sabor }
  method golosinasDeSabor(sabor) = bolsa.filter { golosina => golosina.sabor() == sabor}
  method sabores() = bolsa.map{ golosina => golosina.sabor() }.asSet()
  method golosinaMasCara() = bolsa.max{golosina => golosina.precio()}
  method pesoGolosinas() = bolsa.sum { golosina => golosina.gramos() }

  method golosinasFaltantes(golosinasDeseadas) = golosinasDeseadas.filter{ golosina => !(bolsa.contains(golosina))}
  method gustosFaltantes(gustosDeseados) = gustosDeseados.filter { sabor => !(bolsa.any{golosina => golosina.sabor() == sabor})}

  method baniar(unaGolosina) {
    bolsa.add(new GolosinaBaniada(golosinaBase = unaGolosina))
  }
}

object juliana {
    const property golosinasDeseadas = #{new Bombon(),new Chocolatin(pesoIni = 2), new Alfajor()}
    const property gustosDeseados = #{chocolate,frutilla}
}


//* PARA PROBAR EN CONSOLA REPL
// mariano.baniar(new Caramelo())
// mariano.baniar(new GolosinaBaniada(golosinaBase = new Alfajor()))
// mariano.probarGolosinas()
// mariano.golosinaMasCara()
// mariano.baniar(new Caramelo())
// mariano.bolsa().map{ golosina => golosina.golosinaBase()}
