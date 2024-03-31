
import Foundation
import UIKit

class ListaPaisesView: UIViewController {
    
    private let presenter: ListaPaisesPresentable
    private let searchController: UISearchController
    
    private var paisesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PaisCellView.self, forCellReuseIdentifier: "PaisCellView")
        return tableView
    }()
    
    init(presenter: ListaPaisesPresentable) {
        self.presenter = presenter
        self.searchController = UISearchController(searchResultsController: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Listado de Países"
        configurarTableView()
        configurarSearchController()
        presenter.onViewDidLoad()
    }
    
    private func configurarTableView() {
        view.addSubview(paisesTableView)
        NSLayoutConstraint.activate([
            paisesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paisesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paisesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            paisesTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        paisesTableView.dataSource = self
        paisesTableView.delegate = self
    }
    
    private func configurarSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
}

extension ListaPaisesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "PaisCellView", for: indexPath) as! PaisCellView
        let model = presenter.viewModels[indexPath.row]
        celda.configurarCelda(model: model)
        return celda
    }
    
}

extension ListaPaisesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.seleccionarCelda(atIndex: indexPath.row)
    }
    
}

extension ListaPaisesView: ListaPaisesInterfazUsuario{
    
    func actualizar(paises: [ViewModel]) {
        DispatchQueue.main.async {
            self.paisesTableView.reloadData()
        }
    }
    
}

extension ListaPaisesView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        presenter.onSearch(with: searchText)
    }
    
}
