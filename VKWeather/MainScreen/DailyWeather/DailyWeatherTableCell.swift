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


class DailyWeatherTableCell: UITableViewCell {
    
    private var cells: [DailyWeatherTableCellModel] = []
    
    // MARK: - Фон
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
    
    // MARK: - Слева дата и иконка
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
    
    // MARK: - В центре описание
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.setColor(style: .almostBlack)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Справа температура
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
    
    // MARK: - Сконфигурировать лэйаут
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
            mainStackView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -sideInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Отступы
    
    private var backgroundHeight: CGFloat { return labelHeight + 10 }
    
    private var labelHeight: CGFloat { return (contentView.layer.frame.width / 4) }
    
    private var sideInset: CGFloat { return (contentView.layer.frame.width / 14) }
    
    private var topInset: CGFloat { return (contentView.layer.frame.width / 25)  }

}


