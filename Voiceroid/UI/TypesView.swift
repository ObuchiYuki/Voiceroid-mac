import Cocoa

class TyepsView:NSVisualEffectView{
    var typeCells:[TypeCellView]
    init(typeCells:[TypeCellView]) {
        self.typeCells = typeCells
        super.init(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 149, height: 100)))
        
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
