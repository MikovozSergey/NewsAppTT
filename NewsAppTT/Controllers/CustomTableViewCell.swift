//
//  CustomTableViewCell.swift
//  NewsAppTT
//
//  Created by Дарья Станкевич on 7/10/20.
//  Copyright © 2020 Sergey Mikovoz. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private var imageOfArticle: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var showMoreButton: UIButton!
    
    
    private var maxCountOfLine = 3
    private var model: Article?
    
    var showMoreDidTapHandler: (() -> Void)?
    
    func configure(with model: Article) {
        self.model = model
        
        self.titleLabel.text =  model.title
    
        self.subtitleLabel.text =  model.description
        self.subtitleLabel.textColor = UIColor(rgb: 0x464748)
        
        self.showMoreButton.isHidden = isHiddenShowMoreButton()
        
        DispatchQueue.main.async {
            if let url = URL(string: model.urlToImage) {
                if let data = try? Data(contentsOf: url) {
                    
                    self.imageOfArticle.image = UIImage(data: data)
                    self.imageOfArticle.layer.cornerRadius = self.imageOfArticle.frame.size.height / 2
                    self.imageOfArticle.clipsToBounds = true
                }
            }
        }
    
        setupHandlng()
        self.selectionStyle = .none
    }
    
    private func setupHandling() {
        showMoreButton.addTarget(self, action: #selector(showMoreButtonTapped), for: .touchUpInside)
    }
    
    @objc func showMoreButtonTapped () {
        
        model?.isHiddenShowMoreButton.toggle()
        guard let isHidden = model?.isHiddenShowMoreButton else { return }
        
        
        subtitleLabel.numberOfLines = isHidden ? 0 : 3
        subtitleLabel.layoutIfNeeded()
        showMoreButton.setTitle(model?.isHiddenShowMoreButton ?? false ? "Show less" : "Show more", for: .normal)
        showMoreDidTapHandler?()
    }
    
    private func getDescriptionWidth(with value: String) -> CGFloat {
        guard let font = UIFont(name: "Apple SD Gothic Neo", size: 15) else { return -1 }
        return value.widthOfString(usingFont: font)
    }
    
    private func isHiddenShowMoreButton() -> Bool {
        guard let description = model?.description else { return true }
        let countLine = ceil(getDescriptionWidth(with: description) / subtitleLabel.frame.width)
        return countLine >= 3 ? false : true
    }
    
}
