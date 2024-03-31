
import Foundation

protocol ListaPaisesPresentable: AnyObject {
    
    var interfazUsuario: ListaPaisesInterfazUsuario? { get }
    var viewModels: [ViewModel] { get }
    
    func onViewAppear()
    func seleccionarCelda(atIndex: Int)
    func onSearch(with searchText: String)
    
}

protocol ListaPaisesInterfazUsuario: AnyObject {
    
    func actualizar(paises: [ViewModel])
    
}

class ListaPaisesPresenter: ListaPaisesPresentable {
    
    weak var interfazUsuario: ListaPaisesInterfazUsuario?
    var viewModels: [ViewModel] = []
    
    private let listaPaisesInteractor : ListaPaisesInteractable
    private var models: [PaisEntidad] = []
    private let mapper: Mapper
    private let router: ListaPaisesRouting
    
    init(
        listaPaisesInteractor: ListaPaisesInteractable,
        mapper: Mapper = Mapper(),
        router: ListaPaisesRouting
    ) {
        self.listaPaisesInteractor = listaPaisesInteractor
        self.mapper = mapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            models = await listaPaisesInteractor.getListaPaises()
            viewModels = models.map(mapper.map(entity:))
            interfazUsuario?.actualizar(paises: viewModels)
        }
    }
    
    func seleccionarCelda(atIndex: Int) {
        let paisName = viewModels[atIndex].name
        router.mostrarDetallePais(withPaisName: paisName)
    }
    
    func onSearch(with searchText: String) {
        Task {
            let filtrarPaises = await listaPaisesInteractor.buscarPais(with: searchText, models: models)
            viewModels = filtrarPaises.map { mapper.map(entity: $0) }
            interfazUsuario?.actualizar(paises: viewModels)
        }
    }
    
}
