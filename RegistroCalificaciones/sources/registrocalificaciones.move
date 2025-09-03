module registrocalificaciones::registrocalificaciones{

use std::String::{String,utf8};
use sui::vec_map::{Vec_map,Self}

/*key,store,drop,copy*/

public struct Registro has key, store{
    id:UID,
     nombre:String, 
    calificacion: VecMap <u8, Calificacion>
        
}

public struct Calificacion has store, drop {
    profesor:String,
    materia:String,
    numero:u8,
    semestre:u8,
    estado:String,
   
}

#[error]
const NUMERO_NO_VALIDO:vector<u8> = b"Numero de materia ya existente, intenta con otro";
const CALIFICACION_NO_VALIDO:u16 = 404 ;

public fun crear_registro(nombre:String, ctx: &mut TxContext){
    let registro=Registro{
    id: object::new(ctx),
    nombre,
    calificacion: vec_map::empty(),

 };
   transfer::transfer(registro,tx_context::sender(ctx))

}

public fun agregar_materias(mut Registro, profesor:String,materia String, numero:u8){


assert!(!Registro.Calificacion.contains(&numero), NUMERO_NO_VALIDO);

    let calificacion=Calificacion{
    profesor,
    materia,
    numero,
    semestre:0,
    estado:utf8(b"Calificacion Exelente"),

};

}

Registro.calificacion.insert(numero, calificacion);

public fun baja_calificacion(mut Registro,numero:u8,semestre:u8){
assert!(!Registro.Calificacion.contains(&numero), CALIFICACION_NO_VALIDO);

let cantidad_semestre=Registro.Calificacion.get_mut(&numero).semestre;
cantidad_semestre=semestre;

let estado_semestre= Registro.Calificacion.get_mut(&numero).semestre;
estado_semestre=semestre;

}

public fun alta_calificacion(mut Registro,numero:u8){
assert!(!Registro.Calificacion.contains(&numero), CALIFICACION_NO_VALIDO);

let cantidad_semestre=Registro.Calificacion.get_mut(&numero).semestre;
cantidad_semestre=semestre;

let estado_semestre= Registro.Calificacion.get_mut(&numero).semestre;
estado_semestre=utf8(b""En central);

}

public fun borrar_ruta(central:&mut Registro,numero:u8)
assert!(!Registro.Calificacion.contains(&numero), CALIFICACION_NO_VALIDO);

registro.calificacion.remove(&numero);

}

