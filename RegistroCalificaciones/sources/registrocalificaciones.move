module registrocalificaciones::registrocalificaciones {

    use std::{string};
    use sui::{vec_map};
    use sui::{object};
    use sui::{tx_context};
    use sui::{transfer};

    /* key, store, drop, copy */

    public struct Registro has key, store {
        id: object::UID,
        nombre: string::String,
        calificacion: vec_map::VecMap<u8, Calificacion>,
    }

    public struct Calificacion has store, drop {
        profesor: string::String,
        materia: string::String,
        numero: u8,
        semestre: u8,
        estado: string::String,
    }

    #[error]
   const NUMERO_NO_VALIDO:vector<u8> = b"Numero de materia ya existente, intenta con otro";

    #[error]
    const CALIFICACION_NO_VALIDO: u64 = 444;

    public fun crear_registro(nombre: string::String, ctx: &mut tx_context::TxContext) {
        let registro = Registro {
            id: object::new(ctx),
            nombre,
            calificacion: vec_map::empty(),
        };
        transfer::transfer(registro, tx_context::sender(ctx));
    }


    public fun agregar_materias(registro: &mut Registro, profesor: string::String, materia: string::String, numero: u8) {
        assert!(!vec_map::contains(&registro.calificacion, &numero), NUMERO_NO_VALIDO);

        let calificacion = Calificacion {
            profesor,
            materia,
            numero,
            semestre: 0,
            estado: string::utf8(b"Calificacion Excelente"),
        };

        vec_map::insert(&mut registro.calificacion, numero, calificacion);
    }

    public fun baja_calificacion(registro: &mut Registro, numero: u8, semestre: u8) {
        assert!(vec_map::contains(&registro.calificacion, &numero), CALIFICACION_NO_VALIDO);

        let calificacion = vec_map::get_mut(&mut registro.calificacion, &numero);
        calificacion.semestre = semestre;
        calificacion.estado = string::utf8(b"En Baja");
    }


    public fun alta_calificacion(registro: &mut Registro, numero: u8, semestre: u8) {
        assert!(vec_map::contains(&registro.calificacion, &numero), CALIFICACION_NO_VALIDO);

        let calificacion = vec_map::get_mut(&mut registro.calificacion, &numero);
        calificacion.semestre = semestre;
        calificacion.estado = string::utf8(b"En Alta");
    }

  
    public fun borrar_ruta(registro: &mut Registro, numero: u8) {
        assert!(vec_map::contains(&registro.calificacion, &numero), CALIFICACION_NO_VALIDO);
        vec_map::remove(&mut registro.calificacion, &numero);
    }
}
