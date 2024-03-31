
import Foundation


protocol DetalleDataRepository {
    
    func getDetallePaisData(withName name: String) async throws -> Data
    
}

class DetalleApiDataManager: DetalleDataRepository {
    
    func getDetallePaisData(withName name: String) async throws -> Data {
        if let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let urlString = "https://restcountries.com/v3.1/name/\(encodedName)"
            if let url = URL(string: urlString) {
                let (data, _) = try await URLSession.shared.data(from: url)
                return data
            } else {
                throw NSError(
                    domain: "URL inválida",
                    code: 400,
                    userInfo: nil
                )
            }
        } else {
            throw NSError(
                domain: "Error al codificar el nombre del país",
                code: 400,
                userInfo: nil
            )
        }
    }
    
}

class DetalleApiDataManagerMock: DetalleDataRepository {
    
    func getDetallePaisData(withName name: String) async throws -> Data {
        guard let fileURL = Bundle.main.url(forResource: "Paises", withExtension: "json") else {
            throw NSError(
                domain: "Archivo 'Paises.json' no encontrado",
                code: 404,
                userInfo: nil
            )
        }
        return try Data(contentsOf: fileURL)
    }
    
}
