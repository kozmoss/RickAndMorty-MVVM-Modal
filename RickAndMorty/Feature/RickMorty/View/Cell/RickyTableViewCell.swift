//
//  RickyTableViewCell.swift
//  RickAndMorty
//
//  Created by samet on 23.11.2024.
//

import UIKit
import SnapKit
import AlamofireImage

class RickyTableViewCell: UITableViewCell {
    private let customImage:UIImageView = UIImageView()
    private let customTitle:UILabel = UILabel()
    private let customDescription:UILabel = UILabel()
    private let randomImage:String = "https://picsum.photos/200/300"
    
    enum Iden:String {
        case custom = "vb10"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customTitle)
        addSubview(customImage)
        addSubview(customDescription)
        customTitle.font = .boldSystemFont(ofSize: 18)
        customDescription.font = .italicSystemFont(ofSize: 10)
        customImage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.equalToSuperview()
            make.top.equalTo(contentView)
            make.right.equalToSuperview()
            
        }
        
        customTitle.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
 
        }
        
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(customTitle).offset(5)
            make.left.right.equalTo(customTitle)
            make.bottom.equalToSuperview()
          

        }
    }
    
    func saveModal(modal: Result) {
        customTitle.text = modal.name
        customDescription.text = modal.status
        customImage.af.setImage(withURL: URL(string: modal.image ?? randomImage) ?? URL(string: randomImage)!)
        
    }
    
    
}
