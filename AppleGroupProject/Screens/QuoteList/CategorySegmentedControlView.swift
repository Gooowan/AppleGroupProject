//
//  CategorySegmentedControl.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 12.12.2024.
//

import UIKit
import SnapKit

class CategorySegmentedControlView: UIView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    var selectedSegmentIndex: Int {
        get { segmentedControl.selectedSegmentIndex }
        set { segmentedControl.selectedSegmentIndex = newValue }
    }
    
    var valueChangeHandler: ((Int) -> Void)?

    init<T: RawRepresentable & CaseIterable>(items: T.Type) where T.RawValue == String {
        super.init(frame: .zero)
        setupUI()
        setupSegments(items: items)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(segmentedControl)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupSegments<T: RawRepresentable & CaseIterable>(items: T.Type) where T.RawValue == String {
        items.allCases.enumerated().forEach { index, item in
            segmentedControl.insertSegment(withTitle: item.rawValue, at: index, animated: false)
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.addTarget(self, action: #selector(segmentTapped), for: .touchUpInside)
            segmentedControl.sizeToFit()
            
            scrollView.contentSize = CGSize(
                width: segmentedControl.frame.width,
                height: bounds.height)
        }
    }
    
    @objc func segmentTapped() {
        valueChangeHandler?(segmentedControl.selectedSegmentIndex)
    }
}

#if DEBUG

import SwiftUI

struct CategorySegmentedControlPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> CategorySegmentedControlView {
        let view = CategorySegmentedControlView(items: QuoteCategory.self)
        return view
    }

    func updateUIView(_ uiView: CategorySegmentedControlView, context: Context) {
        // No updates needed for this simple example
    }
}

struct CategorySegmentedControlViewPreview: PreviewProvider {
    static var previews: some View {
        CategorySegmentedControlPreview()
            .frame(height: 50)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

#endif
