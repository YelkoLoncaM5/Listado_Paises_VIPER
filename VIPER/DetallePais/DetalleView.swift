
import Foundation
import UIKit

class DetalleView: UIViewController {
    
    private let presenter: DetallePresentable
    
    let paisImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let paisName: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32, weight:.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let paisContinent: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let paisCapital: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let paisRegion: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let paisPopulation: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let paisAltBandera: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(presenter: DetallePresentable){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.onViewDidLoad()
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(paisImageView)
        view.addSubview(paisName)
        view.addSubview(paisContinent)
        view.addSubview(paisCapital)
        view.addSubview(paisRegion)
        view.addSubview(paisPopulation)
        view.addSubview(paisAltBandera)
        NSLayoutConstraint.activate([
            paisName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paisName.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            paisImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paisImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paisImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            paisImageView.topAnchor.constraint(equalTo: paisName.bottomAnchor, constant: 20),
            paisCapital.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paisCapital.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            paisCapital.topAnchor.constraint(equalTo: paisImageView.bottomAnchor, constant: 20),
            paisContinent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paisContinent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            paisContinent.topAnchor.constraint(equalTo: paisCapital.bottomAnchor, constant: 20),
            paisRegion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paisRegion.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            paisRegion.topAnchor.constraint(equalTo: paisContinent.bottomAnchor, constant: 20),
            paisPopulation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paisPopulation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            paisPopulation.topAnchor.constraint(equalTo: paisRegion.bottomAnchor, constant: 20),
            paisAltBandera.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paisAltBandera.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            paisAltBandera.topAnchor.constraint(equalTo: paisPopulation.bottomAnchor, constant: 20)
        ])
    }
    
}

extension DetalleView: DetallePresenterInterfazUsuario {
    
    func actualizarInterfazUsuario(viewModel: DetallePaisViewModel) {
        paisImageView.kf.setImage(with: viewModel.flagURL)
        paisName.text = viewModel.nameSpa
        paisContinent.text = "Continente: \(viewModel.continent)."
        paisCapital.text = "Capital: \(viewModel.capital)."
        paisRegion.text = "Pertenece a la región: \(viewModel.region)."
        paisPopulation.text = "Su población es : \(viewModel.population) habitantes."
        paisAltBandera.text = viewModel.alt
    }
    
}
