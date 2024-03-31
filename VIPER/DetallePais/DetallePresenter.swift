
import Foundation

protocol DetallePresenterInterfazUsuario: AnyObject {
    
    func actualizarInterfazUsuario(viewModel: DetallePaisViewModel)
    
}

protocol DetallePresentable: AnyObject {
    
    var interfazUsuario: DetallePresenterInterfazUsuario? { get }
    var paisName: String { get }
    
    func onViewDidLoad()
    
}

class DetallePresenter: DetallePresentable{
    
    weak var interfazUsuario: DetallePresenterInterfazUsuario?
    let paisName: String
    
    private let interactor: DetalleInteractable
    private let mapper: MapperDetallePaisViewModel
    
    init(
        paisName: String,
        interactor: DetalleInteractable,
        mapper: MapperDetallePaisViewModel
    ) {
        self.paisName = paisName
        self.interactor = interactor
        self.mapper = mapper
    }
    
    func onViewDidLoad() {
        Task{
            let model = await interactor.getDetallePais(withName: paisName)
            let viewModel = mapper.map(entity: model!)
            await MainActor.run {
                self.interfazUsuario?.actualizarInterfazUsuario(viewModel: viewModel)
            }
        }
    }
    
}
