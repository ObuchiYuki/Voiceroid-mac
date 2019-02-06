import AppKit

extension NSCollectionViewLayoutAttributes {
    func leftAlignFrame(with sectionInset: NSEdgeInsets) {
        var frame = self.frame
        frame.origin.x = sectionInset.left
        self.frame = frame
    }
}

class _VCCollectionViewLeftAlignedLayout: NSCollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: NSRect) -> [NSCollectionViewLayoutAttributes] {
        let originalAttributes = super.layoutAttributesForElements(in: rect)
        var updatedAttributes = originalAttributes
        
        for attributes: NSCollectionViewLayoutAttributes in originalAttributes {
            if !(attributes.representedElementKind != nil) {
                let index = updatedAttributes.index(of: attributes)!
                updatedAttributes[index] = self.layoutAttributesForItem(at: attributes.indexPath!)!
            }
        }
        return updatedAttributes
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> NSCollectionViewLayoutAttributes? {
        let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)!
        let sectionInset = self.evaluatedSectionInsetForItemAtIndex(index: indexPath.section)
        let isFirstItemInSection = indexPath.item == 0
        let layoutWidth = collectionView!.frame.width - sectionInset.left - sectionInset.right
        if isFirstItemInSection {
            currentItemAttributes.leftAlignFrame(with: sectionInset)
            return currentItemAttributes
        }
        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
        let previousFrame = self.layoutAttributesForItem(at: previousIndexPath)!.frame
        let previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width
        let currentFrame = currentItemAttributes.frame
        let strecthedCurrentFrame = CGRect(x: sectionInset.left, y: currentFrame.origin.y, width: layoutWidth, height: currentFrame.size.height)
        let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
        if isFirstItemInRow {
            currentItemAttributes.leftAlignFrame(with: sectionInset)
            return currentItemAttributes
        }
        var frame = currentItemAttributes.frame
        frame.origin.x = previousFrameRightPoint + self.evaluatedMinimumInteritemSpacing(for: indexPath.section)
        currentItemAttributes.frame = frame
        return currentItemAttributes
    }
    func evaluatedMinimumInteritemSpacing(for sectionIndex: Int) -> CGFloat {
        if let layout = self.collectionView?.collectionViewLayout as? NSCollectionViewFlowLayout{
            return layout.minimumInteritemSpacing
        }
        return  self.minimumInteritemSpacing
    }
    
    func evaluatedSectionInsetForItemAtIndex(index: Int) -> NSEdgeInsets {
        if let layout = self.collectionView?.collectionViewLayout as? NSCollectionViewFlowLayout{
            return layout.sectionInset
        }
        return  self.sectionInset
    }
}

protocol NSCollectionViewDelegateLeftAlignedLayout: NSCollectionViewDelegateFlowLayout {
    
}
