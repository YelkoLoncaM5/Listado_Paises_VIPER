
import Foundation

struct Mapper {
    
    func map(entity: PaisEntidad) -> ViewModel{
        ViewModel(
            name: entity.name.common,
            nameSpa: entity.translations.spa.common,
            continent: entity.continents.first!,
            flagURL: URL(string: entity.flags.png)
        )
    }
    
}
