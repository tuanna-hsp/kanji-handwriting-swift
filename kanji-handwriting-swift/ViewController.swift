
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultCollectionView: UICollectionView!
    @IBOutlet weak var drawableView: DrawableView!
    
    private lazy var viewModel: HandwritingViewModel = {
        let vm = HandwritingViewModel(canvas: drawableView)
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.layer.borderWidth = 1
        resultCollectionView.layer.borderColor = UIColor.blue.cgColor
        
        drawableView.delegate = self
        
        viewModel.resultUpdated = { [weak self]() in
            self?.resultCollectionView.reloadData()
        }
    }
    
    @IBAction func handleClearAction() {
        drawableView.clear()
        viewModel.clear()
    }
    
    @IBAction func handleUndoAction() {
        drawableView.undo()
        viewModel.clear()
        
        let strokes = drawableView.strokes.map { $0 as! [NSValue] }
        if strokes.count > 0 {
            viewModel.add(strokes)
        }
    }
}

//--------------------------------------------------------------------------------
//  MARK: - UICollectionView delegate
//--------------------------------------------------------------------------------

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ view: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.resultCount()
    }
    
    func collectionView(_ view: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.dequeueReusableCell(withReuseIdentifier: "viewCell", for: indexPath) as! HandwritingCollectionViewCell
        cell.resultLabel.text = viewModel.result(atIndex: indexPath.item)
        return cell
    }
}

//--------------------------------------------------------------------------------
//  MARK: - DrawableView delegate
//--------------------------------------------------------------------------------

extension ViewController: DrawableViewDelegate {
    
    func didDraw(stroke: [NSValue]) {
        viewModel.add(stroke)
    }
}
