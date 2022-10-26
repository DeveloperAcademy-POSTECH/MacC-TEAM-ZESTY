//
//  AddPlaceResultViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/24.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit
import Kingfisher

final class AddPlaceResultViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: AddPlaceResultViewModel
    private var cancelBag = Set<AnyCancellable>()
    private let input: PassthroughSubject<AddPlaceResultViewModel.Input, Never> = .init()
    
    private let isSE = UIScreen.main.isLessThan376pt && !UIDevice.current.hasNotch
    
    private lazy var titleView = MainTitleView(title: "맛집 등록 완료 🎉")
    
    private lazy var ticketImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(.img_ticket_bg)
        $0.layer.applyFigmaShadow(color: .black, opacity: 0.25, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        return $0
    }(UIImageView())
    
    private lazy var iconView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.layer.applyFigmaShadow(color: .black, opacity: 0.25, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        return $0
    }(UIImageView())
    
    private lazy var categoryTagLabel: BasePaddingLabel = {
        $0.text = "일식"
        $0.font = .systemFont(ofSize: 11, weight: .bold)
        $0.textColor = .white
        $0.backgroundColor = .zestyColor(.point)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(BasePaddingLabel())
    
    private lazy var placeNameLabel: UILabel = {
        $0.text = "요기쿠시동"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: isSE ? 20 : 22, weight: .bold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var addressLabel: UILabel = {
        $0.text = "경북 포항시 남구 효자동 11길 24-1 1층 요기쿠시동 "
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: isSE ? 10 : 12, weight: .regular)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var orgTitle: UILabel = {
        $0.text = "Orgnization"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: isSE ? 9 : 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var creatorTitle: UILabel = {
        $0.text = "Registered by"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: isSE ? 9 : 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var dateTitle: UILabel = {
        $0.text = "Date"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: isSE ? 9 : 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var orgLabel: UILabel = {
        $0.text = "대학이름"
        $0.textColor = .zestyColor(.gray3C)
        $0.font = .systemFont(ofSize: isSE ? 13 : 16, weight: .medium)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var creatorLabel: UILabel = {
        $0.text = "만든사람"
        $0.textColor = .zestyColor(.gray3C)
        $0.font = .systemFont(ofSize: isSE ? 13 : 16, weight: .medium)
        return $0
    }(UILabel())
    
    private lazy var dateLabel: UILabel = {
        $0.text = "YYYY.MM.DD"
        $0.textColor = .zestyColor(.gray3C)
        $0.font = .systemFont(ofSize: isSE ? 13 : 16, weight: .medium)
        return $0
    }(UILabel())
    
    private lazy var saveButton: UIButton = {
        let config = UIImage.SymbolConfiguration(paletteColors: [.zestyColor(.point) ?? .red])
        let downloadImage = UIImage(systemName: "square.and.arrow.down", withConfiguration: config)
        $0.setImage(downloadImage, for: .normal)
        $0.setTitle(" 리뷰 카드 저장하기", for: .normal)
        $0.setTitleColor(.zestyColor(.point), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var doneButton: FullWidthBlackButton = {
        $0.setTitle("완료", for: .normal)
        $0.addTarget(self, action: #selector(doneButtonDidTap), for: .touchUpInside)
        return $0
    }(FullWidthBlackButton())
    
    // MARK: - LifeCycle
    init(viewModel: AddPlaceResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        input.send(.viewDidLoad)
        configureUI()
        createLayout()
        setNavigationBar()
    }
    
    // MARK: - Function
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonDidTap() {
        // ShareSheet
    }
    
    @objc func doneButtonDidTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

// MARK: - Binding
extension AddPlaceResultViewController {
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loadPlaceResultSucceed(let place):
                    self?.setup(with: place)
                }
            }
            .store(in: &cancelBag)
    }
    
    private func setup(with place: PlaceResult) {
        categoryTagLabel.text = place.category.name
        placeNameLabel.text = place.name
        addressLabel.text = place.address
        orgLabel.text = place.organizationId
        creatorLabel.text = place.creator
        dateLabel.text = place.createdAt.getDateToString(format: "YYYY.MM.dd")
        iconView.kf.setImage(with: URL(string: place.category.imageURL ?? "https://user-images.githubusercontent.com/63157395/197410857-e13c1bbb-b19a-4c59-a493-77501a4a529b.png"))
        
    }
    
}

// MARK: - UI Function

extension AddPlaceResultViewController {
    
    private func configureUI() {
        view.backgroundColor = .white // zestyColor(.backgroundColor)
    }
    
    private func createLayout() {
        view.addSubviews([titleView, ticketImageView, iconView,
                          categoryTagLabel, placeNameLabel, addressLabel,
                          orgTitle, creatorTitle, dateTitle,
                          orgLabel, creatorLabel, dateLabel,
                          saveButton, doneButton])
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        ticketImageView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.77)
            $0.height.equalToSuperview().multipliedBy(0.59)
        }
        
        orgTitle.snp.makeConstraints {
            $0.top.equalTo(ticketImageView).offset(30)
            $0.leading.trailing.equalTo(ticketImageView).inset(isSE ? 40 : 25)
        }
        
        orgLabel.snp.makeConstraints {
            $0.top.equalTo(orgTitle.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(ticketImageView).inset(isSE ? 40 : 25)
        }
        
        creatorTitle.snp.makeConstraints {
            $0.top.equalTo(orgLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(ticketImageView).inset(isSE ? 40 : 25)
        }
        
        creatorLabel.snp.makeConstraints {
            $0.top.equalTo(creatorTitle.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(ticketImageView).inset(isSE ? 40 : 25)
        }
        
        dateTitle.snp.makeConstraints {
            $0.top.equalTo(creatorLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(ticketImageView).inset(isSE ? 40 : 25)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dateTitle.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(ticketImageView).inset(isSE ? 40 : 25)
        }
        
        categoryTagLabel.snp.makeConstraints {
            $0.bottom.equalTo(placeNameLabel.snp.top).offset(-4)
            $0.leading.equalTo(ticketImageView).inset(isSE ? 40 : 25)
        }

        placeNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(addressLabel.snp.top).offset(-4)
            $0.leading.equalTo(ticketImageView).inset(isSE ? 40 : 25)
            $0.trailing.equalTo(iconView.snp.leading).offset(-10)
        }

        addressLabel.snp.makeConstraints {
            $0.bottom.equalTo(ticketImageView.snp.bottom).offset(isSE ? -100 : -130)
            $0.leading.equalTo(ticketImageView).inset(isSE ? 40 : 25)
            $0.trailing.equalTo(iconView.snp.leading).offset(isSE ? -8 : -10)
        }

        iconView.snp.makeConstraints {
            $0.bottom.equalTo(ticketImageView.snp.bottom).offset(isSE ? -100 : -130)
            $0.trailing.equalTo(ticketImageView).offset(-40)
            $0.width.height.equalTo(isSE ? 55 : 65)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(ticketImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
             
    }
    
    private func setNavigationBar() {
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonDidTap))
        leftBarButton.tintColor = .label
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
}

/*
 // MARK: - Previews
 
 struct AddPlaceResultPreview: PreviewProvider {
 
 static var previews: some View {
 AddPlaceResultViewController().toPreview()
 }
 
 }
 */
