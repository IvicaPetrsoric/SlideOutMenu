//
//  ChatroomMenuCell.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 23/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class ChatroomMenuCell: UITableViewCell {
    
    var titleText: String? {
        didSet {
            guard let titleText = titleText else { return }
            
            let attributedText = NSMutableAttributedString(string: "#  ", attributes:
                [.foregroundColor:  #colorLiteral(red: 0.4745098039, green: 0.4078431373, blue: 0.4666666667, alpha: 1), .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
            attributedText.append(NSAttributedString(string: titleText, attributes: [.foregroundColor: UIColor.white]))
            textLabel?.attributedText = attributedText            
        }
    }
    
    private let customBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        addSubview(customBackgroundView)
        
        customBackgroundView.fillSuperview(padding: .init(top: 4, left: 4, bottom: 4, right: 4))
        sendSubviewToBack(customBackgroundView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        customBackgroundView.isHidden = !selected
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
