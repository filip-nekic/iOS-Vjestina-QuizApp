//
//  MyFlowLayout.swift
//  QuizApp
//
//  Created by five on 14/04/2021.
//

import Foundation
import UIKit

class MyFlowLayout: UICollectionViewFlowLayout {
    
    override func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader,
            at: [originalAttributes.indexPath])
        
        context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionFooter,                                                 at: [originalAttributes.indexPath])
        return context
    }
    
}
