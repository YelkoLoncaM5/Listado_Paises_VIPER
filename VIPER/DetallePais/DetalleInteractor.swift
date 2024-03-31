
import Foundation

protocol DetalleInteractable: AnyObject {
    
    func getDetallePais(withName name: String) async -> DetallePaisEntidad?
    
}

class DetalleInteractor: DetalleInteractable {
    
    private let detalleDataRepositorio: DetalleDataRepository
    
    init(detalleDataRepositorio: DetalleDataRepository) {
        self.detalleDataRepositorio = detalleDataRepositorio
    }
    
    func getDetallePais(withName name: String) async -> DetallePaisEntidad? {
        do {
            let data = try await detalleDataRepositorio.getDetallePaisData(withName: name)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try jsonDecoder.decode([DetallePaisEntidad].self, from: data)
            return response.first
        } catch {
            print("Error al obtener los detalles del país: \(error)")
            return nil
        }
    }
    
}

class DetalleInteractorMock: DetalleInteractable {
    
    private let detalleDataRepositorio: DetalleDataRepository
    
    init(detalleDataRepositorio: DetalleDataRepository) {
        self.detalleDataRepositorio = detalleDataRepositorio
    }
    
    func getDetallePais(withName name: String) async -> DetallePaisEntidad? {
        do {
            let data = try await detalleDataRepositorio.getDetallePaisData(withName: name)
            let response = try JSONDecoder().decode([DetallePaisEntidad].self, from: data)
            let paisDetalle = response.filter { $0.name.common == name }
            if let primerPais = paisDetalle.first {
                return primerPais
            } else {
                print("No se encontró el detalle del país con nombre: \(name)")
                return nil
            }
        } catch {
            print("Error al obtener los detalles del país: \(error)")
            return nil
        }
    }
    
}
