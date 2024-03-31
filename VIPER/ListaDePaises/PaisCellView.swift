
import Foundation
import UIKit
import Kingfisher

class PaisCellView: UITableViewCell {
    
    let paisImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let paisName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let paisContinent: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurarViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurarViews() {
        addSubview(paisImageView)
        addSubview(paisName)
        addSubview(paisContinent)
        NSLayoutConstraint.activate([
            paisImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            paisImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            paisImageView.heightAnchor.constraint(equalToConstant: 100),
            paisImageView.widthAnchor.constraint(equalToConstant: 160),
            paisImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12),
            paisName.leadingAnchor.constraint(equalTo: paisImageView.trailingAnchor, constant: 18),
            paisName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            paisName.topAnchor.constraint(equalTo: paisImageView.topAnchor, constant: 24),
            paisContinent.leadingAnchor.constraint(equalTo: paisImageView.trailingAnchor, constant: 20),
            paisContinent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            paisContinent.topAnchor.constraint(equalTo: paisName.bottomAnchor, constant: 8),
            paisContinent.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12)
        ])
    }
    
    func configurarCelda(model: ViewModel) {
        paisImageView.kf.setImage(with: model.flagURL)
        paisName.text = model.nameSpa
        paisContinent.text = "Continente: \(model.continent)"
    }
    
}
