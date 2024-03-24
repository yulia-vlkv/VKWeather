//
//  DailyWeatherTableCell.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import UIKit


extension DailyWeatherTableCell: ConfigurableView {
    
    func configure(with model: DailyWeatherTableCellModel) {
        dateLabel.text = model.date
        weatherImage.image = model.icon
        detailsLabel.text = model.description.capitalizedSentence
        temperatureLabel.text = "\(model.lowestTemperature)°-\(model.highestTemperature)°"
    }
}

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}

class DailyWeatherTableCell: UITableViewCell {
    
    private var cells: [DailyWeatherTableCellModel] = []
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.toAutoLayout()
        return view
    }()

    private let frameView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.setColor(style: .almostWhite)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.toAutoLayout()
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 6
        stack.alignment = .center
        stack.toAutoLayout()
        return stack
    }()
    
    private let leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 6
        stack.alignment = .center
        stack.toAutoLayout()
        return stack
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.setColor(style: .almostBlack)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.toAutoLayout()
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.setColor(style: .almostBlack)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.toAutoLayout()
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        
        configureLayout()
    }
    
    // MARK: - Configure Layout

    private func configureLayout(){
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(frameView)
        frameView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(leftStackView)
        leftStackView.addArrangedSubview(dateLabel)
        leftStackView.addArrangedSubview(weatherImage)
        mainStackView.addArrangedSubview(detailsLabel)
        mainStackView.addArrangedSubview(temperatureLabel)

        
        let constraints = [
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: backgroundHeight),
            
            frameView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor),
            frameView.heightAnchor.constraint(equalToConstant: labelHeight),
            frameView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: sideInset),
            frameView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -sideInset),
            
            mainStackView.topAnchor.constraint(equalTo: frameView.topAnchor, constant: topInset),
            mainStackView.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -topInset),
            mainStackView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: sideInset),
            mainStackView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -sideInset),
            
//            leftStackView.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
//            leftStackView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: sideInset),
//            leftStackView.widthAnchor.constraint(equalToConstant: 50),
//            
//            detailsLabel.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
//            detailsLabel.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor, constant: sideInset),
//            detailsLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -sideInset),
//   
//            temperatureLabel.trailingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: -sideInset)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var backgroundHeight: CGFloat { return labelHeight + 10 }
    
    private var labelHeight: CGFloat { return (contentView.layer.frame.width / 4) }
    
    private var sideInset: CGFloat { return (contentView.layer.frame.width / 13) }
    
    private var topInset: CGFloat { return (contentView.layer.frame.width / 25)  }
//
//    private var smallSideInset: CGFloat { return 10 }
    

}


