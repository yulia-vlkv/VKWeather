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
        detailsLabel.text = model.description
        temperatureLabel.text = "\(model.lowestTemperature)°-\(model.highestTemperature)°"
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

    private let frameView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = CustomColors.setColor(style: .almostWhite)
        stack.layer.cornerRadius = 5
        stack.clipsToBounds = true
        stack.distribution = .fillEqually
        stack.spacing = 6
        stack.alignment = .center
        stack.toAutoLayout()
        return stack
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.setColor(style: .almostBlack)
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
        label.numberOfLines = 1
        label.textColor = CustomColors.setColor(style: .almostBlack)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
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
        frameView.addSubview(dateLabel)
        frameView.addSubview(weatherImage)
        frameView.addSubview(detailsLabel)
        frameView.addSubview(temperatureLabel)
        
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
            
            frameView.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
            frameView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: smallSideInset),
            frameView.widthAnchor.constraint(equalToConstant: 50),
            
//            detailsLabel.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
//            detailsLabel.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor, constant: regularSideInset),
//            detailsLabel.trailingAnchor.constraint(equalTo: rightStackView.leadingAnchor, constant: -regularSideInset),
//            
//            rightStackView.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
//            rightStackView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -smallSideInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var backgroundHeight: CGFloat { return 66 }
    
    private var labelHeight: CGFloat { return 56 }
    
    private var sideInset: CGFloat { return 16 }
    
    private var regularSideInset: CGFloat { return 13 }
    
    private var smallSideInset: CGFloat { return 10 }
    

}


