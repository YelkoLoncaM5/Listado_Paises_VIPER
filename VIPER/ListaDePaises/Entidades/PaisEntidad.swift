
import Foundation

struct PaisEntidad: Decodable {
    
    var name: NombrePaisEntidad
    var capital: [String]?
    var region: String
    var translations: TraduccionesEntidad
    var population: Int
    var continents: [String]
    var flags: BanderaEntidad
    
    enum CodingKeys: String, CodingKey {
        case name, capital, region
        case translations, population, continents, flags
    }
    
}
