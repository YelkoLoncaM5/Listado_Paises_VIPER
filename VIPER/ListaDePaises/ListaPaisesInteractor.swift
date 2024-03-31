
import Foundation

protocol ListaPaisesInteractable: AnyObject {
    
    func getListaPaises() async -> [PaisEntidad]
    func buscarPais(with searchText: String, models: [PaisEntidad]) async -> [PaisEntidad]
    
}

class ListaPaisesInteractor: ListaPaisesInteractable {
    
    private let paisDataRepositorio: PaisDataRepository
    
    init(paisDataRepositorio: PaisDataRepository) {
        self.paisDataRepositorio = paisDataRepositorio
    }
    
    func getListaPaises() async -> [PaisEntidad] {
        do {
            let data = try await paisDataRepositorio.getDatosPaises()
            let response = try JSONDecoder().decode([PaisEntidad].self, from: data)
            return response
        } catch {
            print("Problema al decodificar.")
            return []
        }
    }
    
    func buscarPais(with searchText: String, models: [PaisEntidad]) async -> [PaisEntidad] {
        if searchText.isEmpty {
            return models
        }
        let filtrarPaises = models.filter { $0.translations.spa.common.localizedCaseInsensitiveContains(searchText) }
        return filtrarPaises
    }
    
}

class ListaPaisesInteractorMock: ListaPaisesInteractable {
    
    private let paisDataRepositorio: PaisDataRepository
    
    init(paisDataRepositorio: PaisDataRepository) {
        self.paisDataRepositorio = paisDataRepositorio
    }
    
    func getListaPaises() async -> [PaisEntidad] {
        do {
            let data = try await paisDataRepositorio.getDatosPaises()
            let response = try JSONDecoder().decode([PaisEntidad].self, from: data)
            return response
        } catch {
            print("Error al obtener la lista de países: \(error)")
            return []
        }
    }
    
    func buscarPais(with searchText: String, models: [PaisEntidad]) async -> [PaisEntidad] {
        if searchText.isEmpty {
            return models
        }
        let filtrarPaises = models.filter { $0.translations.spa.common.localizedCaseInsensitiveContains(searchText) }
        return filtrarPaises
    }
    
}
