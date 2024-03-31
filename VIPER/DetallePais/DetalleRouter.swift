
import Foundation
import UIKit

protocol DetalleRouting: AnyObject {
    
    func mostrarDetalle(fromViewViewController: UIViewController, withPaisName paisName: String)
    
}

class DetalleRouter: DetalleRouting {
    
    func mostrarDetalle(fromViewViewController: UIViewController, withPaisName paisName: String) {
        let detalleRepositorio = DetalleApiDataManagerMock()
        let interactor = DetalleInteractorMock(detalleDataRepositorio: detalleRepositorio)
        let presenter = DetallePresenter(paisName: paisName, interactor: interactor, mapper: MapperDetallePaisViewModel())
        let view = DetalleView(presenter: presenter)
        presenter.interfazUsuario = view
        fromViewViewController.present(view, animated: true)
    }
    
}
