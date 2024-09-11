object bombon {
    
    var property precio = 5
    var property sabor = frutilla
    var property gramos = 15
    var property gluten = true

    method mordisco() {
      gramos = gramos * 0.8 - 1
    }

}

object alfajor {
    var property precio = 12
    var property sabor = chocolate
    var property gramos = 300
    var property gluten = false

    method mordisco() {
      gramos = gramos * 0.8
    }


}

object caramelo {
    var property precio = 1
    var property sabor = frutilla
    var property gramos = 5
    var property gluten = true

    method mordisco() {
      gramos -= 1
    }


}

object chupetin {
    var property precio = 2
    var property sabor = naranja
    var property gramos = 7
    var property gluten = true

    method mordisco() {
        if(gramos > 2) {
            gramos = gramos * 0.9
        }
    }


}

object oblea {
    var property precio = 5
    var property sabor = vainilla
    var property gramos = 250
    var property gluten = false

    method mordisco() {
        if(gramos > 70) {
            gramos = gramos / 2
        } else {
            gramos = gramos * 0.25
        }
    }


}

object chocolatin {
    var property sabor = chocolate
    var property gramos = 0
    var property gluten = false
    var property pesoIni = 0

    method mordisco() {
      gramos -= 2
    }

    method precio() = 0.5 * pesoIni
    method gramos(g) {
      gramos = g
      pesoIni = g
    }


}

object golosinaBaniada {
    var property precio = 5
    var property sabor = null
    var property gramos = 0
    var baniado = 4
    var property gluten = false

    method mordisco(golosina) {
        golosina.mordisco()
        baniado -= 2
    }

    method gramos(golosina) {
      gramos = golosina.gramos() + baniado.max(0)
    }
    method precio(golosina) {
      precio = golosina.precio() + 2
    }
    method gluten(golosina) {
      gluten = golosina.gluten()
    }
    method sabor(golosina) {
      sabor = golosina.sabor()
    }


}

object pastillaTutFrut {
    var property precio = 0
    var property sabor = frutilla
    var property gramos = 5
    var property gluten = false
    var property m = 0

    method mordisco() {
      sabor = sabor.siguiente() 
    }
    method precio() {
        if (gluten) {return 7}
        else {return 10}
    }
    // method sabor() = sabor.siguiente() 

}

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

object mariano {
    const property bolsa = []

    method comprar(golosina) {
      bolsa.add(golosina)
    }
    method desechar(golosina) {
      bolsa.remove(golosina)
    }
    method probarGolosina() {
      bolsa.forEach { g => g.mordisco() }
    }
    method hayGolosinasSinTACC() = bolsa.any { g => g.gluten() }
    method preciosCuidados() = bolsa.all { g => g.precio() < 10 }
    method golosinaDeSabor(sabor) = bolsa.find { g => g.sabor() == sabor }
    method golosinasDeSabor(sabor) = bolsa.filter { g => g.sabor() == sabor}
    method sabores() = bolsa.map{ g => g.sabor() }.asSet()
    method golosinaMasCara() = bolsa.map{g => g.precio()}.max()
    method pesoGolosinas() = bolsa.sum { g => g.gramos() }

    method golosinasFaltantes(golosinasDeseadas) = golosinasDeseadas.filter{ g => !(bolsa.contains(g))}
    method gustosFaltantes(gustosDeseados) = gustosDeseados.filter { s => !(bolsa.any{g => g.sabor() == s})}

}

object juliana {
    const property golosinasDeseadas = #{bombon,chocolatin,alfajor}
    const property gustosDeseados = #{chocolate,frutilla}
}