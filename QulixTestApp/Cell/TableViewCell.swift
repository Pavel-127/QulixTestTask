//
//  TableViewCell.swift
//  QulixTestApp
//
//  Created by macbook on 22.02.22.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "TableViewCell"
    
    var movies: [Movies] = []
    
    private var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCell() {
        self.contentView.addSubview(name)
        
        self.setNeedsUpdateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func updateConstraints() {
        self.name.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview().offset(10)
        }
        
        super.updateConstraints()
    }
    
    func setCellData(name: Movies) {
        self.name.text = name.title
        
        self.setNeedsUpdateConstraints()
    }
}
