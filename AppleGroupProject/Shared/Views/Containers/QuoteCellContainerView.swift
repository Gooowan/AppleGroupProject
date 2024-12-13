//
//  QuteCellContainerView.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 12.12.2024.
//

import UIKit
import SnapKit

class QuoteCellContainerView: UIView {
    
    private var quoteLabel: UILabel = {
        let label = LabelFactory.build(
            font: ThemeFont.bold(ofSize: 20, isItalic: true),
            textColor: ThemeColor.text,
            textAlignment: .left)
        label.numberOfLines = 4
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private var authorLabel: UILabel = {
        let label = LabelFactory.build(
            font: ThemeFont.bold(ofSize: 20, isItalic: true),
            textColor: .secondaryLabel,
            textAlignment: .left)
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.minimumScaleFactor = 0.9
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(quote: Quote) {
        quoteLabel.text = "\(quote.text)"
        authorLabel.text = "- \(quote.author)"
    }
    
    func setupUI() {
        [quoteLabel, authorLabel].forEach(addSubview(_:))
        
        quoteLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(5)
            $0.height.equalTo(88)
        }
        
        authorLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(quoteLabel)
            $0.top.equalTo(quoteLabel.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().inset(5)
        }
        
        backgroundColor = .systemGray4
        
        addCornerRadius(radius: 10)
        
        addShadow(
            offset: CGSize(width: 0, height: 5),
            color: ThemeColor.shadow,
            radius: 10,
            opacity: 0.2)
    }
}

#if DEBUG

import SwiftUI

struct QuoteCellContainerView_Previews: PreviewProvider {
    
    static func makeView() -> QuoteCellContainerView {
        let view = QuoteCellContainerView()
        let quote = Quote(text: "La-La-Land", author: "Ryan Gosling", color: .yellow, category: .beauty)
        view.configure(quote: quote)
        view.backgroundColor = .systemGray3
        return view
    }
    
    static var previews: some View {
        Group {
            makeView()
                .asPreview()
                .frame(height: 150)
                .padding()
        }
    }
}

extension UIView {
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        var view: UIView

        func makeUIView(context: Context) -> UIView {
            view
        }

        func updateUIView(_ view: UIView, context: Context) {}
    }

    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(view: self)
    }
}

#endif
