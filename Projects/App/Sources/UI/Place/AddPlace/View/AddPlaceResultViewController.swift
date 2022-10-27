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
    
    private let isSE = UIScreen.main.isHeightLessThan670pt
    
    private lazy var titleView = MainTitleView(title: "맛집 등록 완료 🎉")
    
    private let placeCard = PlaceCardView()
    
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
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func saveButtonDidTap() {
        // ShareSheet
        let reviewCard = placeCard.transfromToImage() ?? UIImage()
        saveImage(with: reviewCard)
    }
    
    @objc func doneButtonDidTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func saveImage(with image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
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
                    self?.placeCard.setup(with: place)
                }
            }
            .store(in: &cancelBag)
    }
    

}

// MARK: - UI Function

extension AddPlaceResultViewController {
    
    private func configureUI() {
        view.backgroundColor = .white // zestyColor(.backgroundColor)
    }
    
    private func createLayout() {
        view.addSubviews([titleView, placeCard,
                          saveButton, doneButton])
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        placeCard.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(400)
        }

        saveButton.snp.makeConstraints {
            $0.top.equalTo(placeCard.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
             
    }
    
    private func setNavigationBar() {
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButtonDidTap))
        rightBarButton.tintColor = .label
        navigationItem.leftBarButtonItem = rightBarButton
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
