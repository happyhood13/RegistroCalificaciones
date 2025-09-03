module registrocalificaciones::registrocalificaciones {

    use std::string;
    use sui::vec_map;

  /*key store drop*/
    public struct Registro has key, store {
        id: object::UID,
        nombre: string::String,
        calificaciones: vec_map::VecMap<u8, Calificacion>,
    }

    
    public struct Calificacion has store, drop {
        profesor: string::String,
        materia: string::String,
        numero: u8,
        semestre: u8,
        estado: string::String,
    }

    #[error]
    const NUMERO_NO_VALIDO: u64 = 1;

    #[error]
    const CALIFICACION_NO_VALIDO: u64 = 2;


    public fun crear_registro(nombre: string::String, ctx: &mut tx_context::TxContext): Registro {
        Registro {
            id: object::new(ctx),
            nombre,
            calificaciones: vec_map::empty(),
        }
    }


    public fun agregar_materia(registro: &mut Registro, profesor: string::String, materia: string::String, numero: u8) {
        assert!(!vec_map::contains(&registro.calificaciones, &numero), NUMERO_NO_VALIDO);

        let calificacion = Calificacion {
            profesor,
            materia,
            numero,
            semestre: 0,
            estado: string::utf8(b"Calificacion Excelente"),
        };

        vec_map::insert(&mut registro.calificaciones, numero, calificacion);
    }

    public fun baja_calificacion(registro: &mut Registro, numero: u8, semestre: u8) {
        assert!(vec_map::contains(&registro.calificaciones, &numero), CALIFICACION_NO_VALIDO);

        let calificacion = vec_map::get_mut(&mut registro.calificaciones, &numero);
        calificacion.semestre = semestre;
        calificacion.estado = string::utf8(b"En Baja");
    }


    public fun alta_calificacion(registro: &mut Registro, numero: u8, semestre: u8) {
        assert!(vec_map::contains(&registro.calificaciones, &numero), CALIFICACION_NO_VALIDO);

        let calificacion = vec_map::get_mut(&mut registro.calificaciones, &numero);
        calificacion.semestre = semestre;
        calificacion.estado = string::utf8(b"En Alta");
    }

    public fun borrar_calificacion(registro: &mut Registro, numero: u8) {
        assert!(vec_map::contains(&registro.calificaciones, &numero), CALIFICACION_NO_VALIDO);
        vec_map::remove(&mut registro.calificaciones, &numero);
    }
}
