
import Foundation

struct MapperDetallePaisViewModel {
    
    func map(entity: DetallePaisEntidad) -> DetallePaisViewModel {
        .init(
            nameSpa: entity.translations.spa.common,
            continent: entity.continents.first!,
            flagURL: URL(string: entity.flags.png),
            capital: entity.capital?.first ?? "No tiene capital",
            region: entity.region,
            population: entity.population,
            alt: entity.flags.alt ?? "No hay descripción de su bandera."
        )
    }
    
}
