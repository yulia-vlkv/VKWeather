//
//  CurrentWeatherTableCell.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//


import UIKit


extension CurrentWeatherTableCell: ConfigurableView {
    
    public func configure(with model: CurrentWeatherTableCellModel) {
        
        currentTemperatureLabel.text = "\(model.currentTemperature)°"
        
        commentLabel.text = model.verbalDescription.capitalized
        
        cloudsLabel.text = "\(model.clouds)%"
        
        windLabel.text = model.windSpeed
        
        humidityLabel.text = "\(model.humidity)%"
        
        sunsetLabel.text = model.sunsetTime
        
        sunriseLabel.text = model.sunriseTime
        
        dateLabel.text = "\(model.dateTime), \(model.dayOfWeek)"
    }
}

class CurrentWeatherTableCell: UITableViewCell {
    
    private var cells: [CurrentWeatherTableCellModel] = []
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.setColor(style: .classicBlue)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.toAutoLayout()
        return view
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 7
        stack.toAutoLayout()
        return stack
    }()
    
    // MARK: - MainInfo
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.textColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let detailsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.toAutoLayout()
        return stack
    }()
    
    // MARK: - Clouds
    
    private let cloudsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.toAutoLayout()
        return stack
    }()
    
    private let cloudsImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud"))
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let cloudsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Wind
    
    private let windStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.toAutoLayout()
        return stack
    }()
    
    private let windImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "wind"))
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Humidity
    
    private let humidityStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.toAutoLayout()
        return stack
    }()
    
    private let humidityImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "humidity"))
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Date and time
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Sunrise
    
    private let sunriseStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.toAutoLayout()
        return stack
    }()
    
    private let sunriseImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sunrise"))
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let sunriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Sunset
    
    private let sunsetStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.toAutoLayout()
        return stack
    }()
    
    private let sunsetImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sunset"))
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        return image
    }()
    
    private let sunsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Semicircle
    
    private func drawSemicircle() {
        let path = UIBezierPath(arcCenter: CGPoint(x: (contentView.layer.frame.width) / 2 + sideInset/2, y: (contentView.layer.frame.width) / 2 ), radius: (contentView.layer.frame.width / 4.5) * 2, startAngle: (-CGFloat.pi + 0.15), endAngle: -0.15, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3
        
        cellBackgroundView.layer.addSublayer(shapeLayer)
    }

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
        drawSemicircle()
        cellBackgroundView.addSubview(contentStack)
        contentStack.addArrangedSubview(currentTemperatureLabel)
        contentStack.addArrangedSubview(commentLabel)
        contentStack.addArrangedSubview(detailsStack)
        detailsStack.addArrangedSubview(cloudsStack)
        cloudsStack.addArrangedSubview(cloudsImage)
        cloudsStack.addArrangedSubview(cloudsLabel)
        detailsStack.addArrangedSubview(windStack)
        windStack.addArrangedSubview(windImage)
        windStack.addArrangedSubview(windLabel)
        detailsStack.addArrangedSubview(humidityStack)
        humidityStack.addArrangedSubview(humidityImage)
        humidityStack.addArrangedSubview(humidityLabel)
        contentStack.addArrangedSubview(dateLabel)
        cellBackgroundView.addSubview(sunriseStack)
        sunriseStack.addArrangedSubview(sunriseImage)
        sunriseStack.addArrangedSubview(sunriseLabel)
        cellBackgroundView.addSubview(sunsetStack)
        sunsetStack.addArrangedSubview(sunsetImage)
        sunsetStack.addArrangedSubview(sunsetLabel)
 
        let constraints = [
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideInset),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: height),
            
            contentStack.centerXAnchor.constraint(equalTo: cellBackgroundView.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor),
            contentStack.widthAnchor.constraint(equalToConstant: contentView.frame.width / 3 * 2),
            
            sunriseStack.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -bottomInset),
            sunriseStack.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: sideInset/2),
            
            sunsetStack.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -bottomInset),
            sunsetStack.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -sideInset/2)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Insets
    
    private var sideInset: CGFloat { return (contentView.layer.frame.width / 13) }
    
    private var bottomInset: CGFloat { return 15 }
    
    private var height: CGFloat { return (contentView.layer.frame.width / 1.5) }
    
}

