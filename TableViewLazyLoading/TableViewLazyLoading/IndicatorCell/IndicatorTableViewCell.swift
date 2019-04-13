//
//  IndicatorTableViewCell.swift
//  TableViewLazyLoading
//
//  Created by Berdil İlyada Karacam on 13.04.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import UIKit

class IndicatorTableViewCell: UITableViewCell {

    private var indicatorView: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoadingAnimation() {
        indicatorView?.startAnimating()
    }
    
    func stopLoadingAnimation() {
        indicatorView?.stopAnimating()
    }
    
    fileprivate func setup() {
        let indicatorView = UIActivityIndicatorView(style: .gray)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorView = indicatorView
        contentView.addSubview(indicatorView)
        
        indicatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
}
