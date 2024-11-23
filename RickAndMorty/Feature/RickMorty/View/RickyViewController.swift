//
//  RickyViewController.swift
//  RickAndMorty
//
//  Created by samet on 23.11.2024.
//

import UIKit
import SnapKit


protocol RickyMortyProtocol {
    func changeLoading(load:Bool)
    func saveDatas(values:[Result])
}

final class RickyViewController: UIViewController {
    private let labelTitle:UILabel = UILabel()
    private let tableView:UITableView = UITableView()
    private lazy var results:[Result] = []
    private let indicator:UIActivityIndicatorView = UIActivityIndicatorView()
    lazy var viewModal:RickyMortyViewModal = RickyMortyViewModal()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModal.getItem()
        viewModal.setDelegate(output: self)
        configure()
        
    }
    
   private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        makeDesign()
        maketableView()
        makeLabel()
        makeIndicator()
        
    }
    
    func makeDesign()  {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(RickyTableViewCell.self, forCellReuseIdentifier: RickyTableViewCell.Iden.custom.rawValue)
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.indicator.startAnimating()
            self.labelTitle.text = "Ricky And Morty"
        }
    }
    
}


extension RickyViewController: RickyMortyProtocol {
    func changeLoading(load: Bool) {
        load ? self.indicator.startAnimating() : self.indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
}


extension RickyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:RickyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickyTableViewCell.Iden.custom.rawValue) as? RickyTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModal(modal: results[indexPath.row])
        return cell

    }
    
    
}


extension RickyViewController {
   private func maketableView() {
       tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.right.left.equalTo(labelTitle)
            
        }
    }
    
  private func makeLabel() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
  private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
    
    
}
