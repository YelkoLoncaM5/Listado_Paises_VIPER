
import Foundation

protocol PaisDataRepository {
    
    func getDatosPaises() async throws -> Data
    
}

class PaisApiDataManager: PaisDataRepository {
    
    func getDatosPaises() async throws -> Data {
        let url = URL(string: "https://restcountries.com/v3.1/all")!
        return try await URLSession.shared.data(from: url).0
    }
    
}

class PaisApiDataManagerMock: PaisDataRepository {
    
    func getDatosPaises() throws -> Data {
        guard let fileURL = Bundle.main.url(forResource: "Paises", withExtension: "json") else {
            throw NSError(
                domain: "Archivo no encontrado",
                code: 404,
                userInfo: nil
            )
        }
        return try Data(contentsOf: fileURL)
    }
    
}
