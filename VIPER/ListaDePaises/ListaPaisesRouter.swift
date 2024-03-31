
import Foundation
import UIKit

protocol ListaPaisesRouting: AnyObject {
    
    var detalleRouter: DetalleRouting? { get }
    var listaPaisesView: ListaPaisesView? { get }
    
    func mostrarListaPaises(window: UIWindow?)
    func mostrarDetallePais(withPaisName paisName: String)
    
}

class ListaPaisesRouter: ListaPaisesRouting {
    
    var detalleRouter: DetalleRouting?
    var listaPaisesView: ListaPaisesView?

    weak var navigationController: UINavigationController?
    
    func mostrarListaPaises(window: UIWindow?) {
        self.detalleRouter = DetalleRouter()
        let paisRepositorio = PaisApiDataManagerMock()
        let interactor = ListaPaisesInteractorMock(paisDataRepositorio: paisRepositorio)
        let presenter = ListaPaisesPresenter(listaPaisesInteractor: interactor, router: self)
        listaPaisesView = ListaPaisesView(presenter: presenter)
        presenter.interfazUsuario = listaPaisesView
        let navigationController = UINavigationController(rootViewController: listaPaisesView!)
        self.navigationController = navigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func mostrarDetallePais(withPaisName paisName: String) {
        guard let fromViewController = listaPaisesView else {
            return
        }
        detalleRouter?.mostrarDetalle(fromViewViewController: fromViewController, withPaisName: paisName)
    }
    
}
