//
//  SelectGameViewController.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import UIKit

class HearSentencesGameViewController: UIViewController,
                                       TranslateSentenceHeaderBlockDelegate,
                                       GapSentencesBlockDelegate,
                                       CustomProgressViewDelegate {
    func setSelfAsDelegate(forBlock block: CustomProgressView) {
        block.setUp(withDelegate: self)
    }
    
    func gameButtonPressed(_ sender: UIButton) {
        answer = [sender.tag]
        if state == 0 {
            gapSentances.selectButton(sender.tag)
        }
        checkButton.setBackgroundColor(UIColor(named: "green")!)
    }
    
    func setSelfAsDelegate(forBlock block: GapSentencesBlock) {
        block.setUp(withDelegate: self)
    }
    
    func setSelfAsDelegate(forBlock block: TranslateSentenceHeaderBlock) {
        block.setUp(withDelegate: self)
    }
    
    
    var presenter: HearSentencesGamePresenterProtocol!
    let configurator: HearSentencesGameConfiguratorProtocol = HearSentencesGameConfigurator()
    
    private var backButton = BackButton()
    
    var resultPopUp: PopUp?
    
    var cells: [[CellData]] = [[], []] {
        didSet {
            if cells.first!.isEmpty {
                checkButton.setBackgroundColor(.systemGray)
            }
            else {
                checkButton.setBackgroundColor(UIColor(named: "green")!)
            }
        }
    } // планируем совместить две коллекции поэтому массив один
    
    var translations: [ClickableCellData] = []
    
    var options: [String] = []
    
    var answer: [Int] = []
    
    var currentTask = -1
    
    var state = 0 {
        didSet {
            switch state {
            case 1:
                [wordConstructorBlock.collectionViewWaiting,
                 wordConstructorBlock.collectionViewSelected,
                 translateSentenceHeaderBlock.wordCloudCollection].forEach { cv in
                    cv.allowsSelection = false
                }
            default:
                [wordConstructorBlock.collectionViewWaiting,
                 wordConstructorBlock.collectionViewSelected,
                 translateSentenceHeaderBlock.wordCloudCollection].forEach { cv in
                    cv.allowsSelection = true
                }
            }
        }
    }
    
    var taskLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura Bold",
                            size: 17)
        return label
    }()
    
    var hearIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image 1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var audioIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - blocks
    
    var wordConstructorBlock = WordBlocksCollectionsBlock()
    
    var translateSentenceHeaderBlock = TranslateSentenceHeaderBlock()
    
    var gapSentances = GapSentencesBlock()
    
    var progress = CustomProgressView()
    
    // MARK: - buttons
    
    var checkButton = StandartButton()
    var cantListenButton = StandartButton()
    
    // MARK: - mode
    var mode: GameMode = .hearSentance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurator.configure(HearSentencesGameBar: self)
        presenter.configureView(mode: mode)
    }
    
    func setUpMode(mode: GameMode) {
        self.mode = mode
    }
}

extension HearSentencesGameViewController: HearSentencesGameViewProtocol {
    func nextTask() {
        if currentTask < 5 {
            currentTask += 1
            progress.updateCollectionViewsData()
        }
        else {
            dismiss(animated: true)
        }
    }
    
    func updateCollectionViewAppearance(with data: [ClickableCellData]) {
        translations = data
        // пофиксить костыль
        if mode != .gap {
            generateLines()
        }
        gapSentances.updateCollectionViewsData()
        translateSentenceHeaderBlock.updateCollectionViewsData()
    }
    
    func updateCollectionViewAppearance(with data: [[CellData]]) {
        cells = data
        generateLines()
        wordConstructorBlock.updateCollectionViewsData()
    }
    
    func updateCollectionViewAppearance(with data: [ClickableCellData],
                                        options: [String]) {
        translations = data
        gapSentances.setUpButtons(withOption: options)
        checkButton.setBackgroundColor(.systemGray)
        gapSentances.updateCollectionViewsData()
    }
    
    func returnWidth() -> CGFloat {
        return view.frame.width
    }
    
    func presentCheck(_ isRight: Bool,
                      rightAnswer: String) {
        state = 1
        resultPopUp = PopUp(rightAnserText: "\(rightAnswer)",
                            isRight: isRight)
        showPopUp()
    }
    
    @objc func check() {
        answer = []
        for i in cells[0] {
            answer.append(i.tag)
        }
        if !(resultPopUp?.superview == view) {
            if !answer.isEmpty {
                progress.updateCollectionViewsData()
                presenter.presentResults(answer: answer,
                                              gameMode: mode)
            }
            else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Empty sentence!",
                                                  message: "To continue make any sentence",
                                                  preferredStyle: .actionSheet)
                    let continueAction = UIAlertAction(title: "Continue",
                                                       style: .default) { _ in
                    }
                    alert.addAction(continueAction)
                    self.present(alert,
                                 animated: true)
                }
            }
        }
        else {
            DispatchQueue.main.async {
                self.presenter.presentTask(gameMode: self.mode)
                self.resultPopUp?.removeFromSuperview()
                self.state = 0
            }
        }
    }
    
    @objc func checkGap() {
        if !(resultPopUp?.superview == view) {
            if !answer.isEmpty {
                presenter.presentResults(answer: answer,
                                              gameMode: mode)
            }
            else {
                let alert = UIAlertController(title: "Empty answer!",
                                              message: "To continue select any answer",
                                              preferredStyle: .actionSheet)
                let continueAction = UIAlertAction(title: "Continue",
                                                   style: .default) { _ in
                    
                }
                alert.addAction(continueAction)
                present(alert,
                        animated: true)
            }
        }
        else {
            DispatchQueue.main.async {
                self.answer = []
                self.presenter.presentTask(gameMode: self.mode)
                self.resultPopUp?.removeFromSuperview()
                self.state = 0
            }
        }
    }
    
    func setUpView() {
        backButton.delegate = self
        [backButton,
         progress,
         taskLabel,
         cantListenButton,
         checkButton].forEach { sV in
            view.addSubview(sV)
            sV.translatesAutoresizingMaskIntoConstraints = false
        }
        cantListenButton.isEnabled = false
        
        progress.setUp(withDelegate: self)
        progress.updateCollectionViewsData()
        
        NSLayoutConstraint.activate([backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                         constant: 32),
                                     backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                     constant: 20),
                                     backButton.widthAnchor.constraint(equalToConstant: 18),
                                     
                                     progress.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
                                     progress.leadingAnchor.constraint(equalTo: backButton.trailingAnchor,
                                                                       constant: 20),
                                     progress.heightAnchor.constraint(equalToConstant: 9),
                                     progress.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                        constant: -32),
                                     
                                     taskLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor,
                                                                    constant: 20),
                                     taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                        constant: 32),
                                     taskLabel.heightAnchor.constraint(equalToConstant: 27),
                                     
                                     cantListenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     cantListenButton.bottomAnchor.constraint(equalTo: checkButton.topAnchor,
                                                                              constant: -10),
                                     checkButton.heightAnchor.constraint(equalToConstant: 59),
                                     cantListenButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                                             multiplier: 0.9),
                                     cantListenButton.heightAnchor.constraint(equalToConstant: 59),
                                     
                                     checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     checkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                         constant: -50),
                                     checkButton.heightAnchor.constraint(equalToConstant: 59),
                                     checkButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                                        multiplier: 0.9),
                                     checkButton.heightAnchor.constraint(equalToConstant: 59),
                                     
        ])
        switch mode {
        case .hearSentance:
            setUpHearSentenceMode()
        case .translateSentance:
            setUpTranslateMode()
        case .gap:
            setUpGapSentancesMode()
        case .hear:
            break
        }
        presenter.presentTask(gameMode: mode)
        checkButton.setBackgroundColor(.systemGray)
        checkButton.setTitle("Continue",
                             for: .normal)
        cantListenButton.setTitle("Can’s listen now",
                                  for: .normal)
        cantListenButton.titleLabel?.textColor = .systemGray
        
    }
    
    func setUpGapSentancesMode() {
        taskLabel.text = "Fill in the blank:"
        checkButton.setBackgroundColor(.systemGray)
        cantListenButton.removeFromSuperview()
        
        gapSentances.setUp(withDelegate: self)
        
        [gapSentances].forEach { sV in
            view.addSubview(sV)
            sV.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            gapSentances.topAnchor.constraint(equalTo: taskLabel.bottomAnchor,
                                              constant: 10),
            gapSentances.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gapSentances.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                multiplier: 0.9),
            gapSentances.bottomAnchor.constraint(equalTo: view.centerYAnchor,
                                                 constant: 105)
        ])
        checkButton.addTarget(self,
                              action: #selector(checkGap),
                              for: .touchUpInside)
    }
    
    func setUpTranslateMode() {
        taskLabel.text = "Translate this sentence:"
        translateSentenceHeaderBlock.setUp(withDelegate: self)
        wordConstructorBlock.setUp(withDelegate: self)
        [translateSentenceHeaderBlock,
         wordConstructorBlock].forEach { sV in
            view.addSubview(sV)
            sV.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            translateSentenceHeaderBlock.topAnchor.constraint(equalTo: taskLabel.bottomAnchor,
                                                              constant: 10),
            translateSentenceHeaderBlock.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            translateSentenceHeaderBlock.heightAnchor.constraint(equalToConstant: 140),
            translateSentenceHeaderBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                  constant: 32),
            translateSentenceHeaderBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                   constant: -32),
            
            
            wordConstructorBlock.topAnchor.constraint(equalTo: translateSentenceHeaderBlock.bottomAnchor,
                                                      constant: 30),
            wordConstructorBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                          constant: 32),
            wordConstructorBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                           constant: -32),
            wordConstructorBlock.bottomAnchor.constraint(equalTo: cantListenButton.topAnchor)
        ])
        checkButton.addTarget(self,
                              action: #selector(check),
                              for: .touchUpInside)
    }
    
    func setUpHearSentenceMode() {
        wordConstructorBlock.setUp(withDelegate: self)
        taskLabel.text = "Tap what you hear:"
        [hearIcon,
         audioIcon,
         wordConstructorBlock].forEach { sV in
            view.addSubview(sV)
            sV.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([hearIcon.topAnchor.constraint(equalTo: taskLabel.bottomAnchor,
                                                                   constant: 10),
                                     hearIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     hearIcon.widthAnchor.constraint(equalToConstant: 100),
                                     hearIcon.heightAnchor.constraint(equalToConstant: 100),
                                     
                                     audioIcon.topAnchor.constraint(equalTo: hearIcon.bottomAnchor,
                                                                    constant: 10),
                                     audioIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     audioIcon.heightAnchor.constraint(equalToConstant: 50),
                                     audioIcon.widthAnchor.constraint(equalToConstant: 290),
                                     
                                     wordConstructorBlock.topAnchor.constraint(equalTo: audioIcon.bottomAnchor,
                                                                               constant: 20),
                                     wordConstructorBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                                   constant: 32),
                                     wordConstructorBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                                    constant: -32),
                                     wordConstructorBlock.bottomAnchor.constraint(equalTo: cantListenButton.topAnchor)
        ])
        checkButton.addTarget(self,
                              action: #selector(check),
                              for: .touchUpInside)
    }
    
    func generateLines() {
        for i in 0...5 {
            if let viewToRemove = view.viewWithTag(20 + i) {
                viewToRemove.removeFromSuperview()
            }
        }
        for i in 0..<min(max(3,
                             cells.count + 1),
                         4) {
            let line = UIView(frame: CGRect.zero)
            line.tag = 20 + i
            line.backgroundColor = .systemGray
            line.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(line)
            view.sendSubviewToBack(line)
            NSLayoutConstraint.activate([line.topAnchor.constraint(equalTo: wordConstructorBlock.topAnchor,
                                                                   constant: CGFloat(50 * (i - 1) + 46)),
                                         line.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                         line.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                                     multiplier: 0.9),
                                         line.heightAnchor.constraint(equalToConstant: 2)])
        }
    }
    
    func showPopUp() {
        view.addSubview(resultPopUp!)
        resultPopUp?.translatesAutoresizingMaskIntoConstraints = false
        resultPopUp?.layer.opacity = 0
        UIView.animate(withDuration: 0.35) {
            self.resultPopUp?.layer.opacity = 1
        }
        view.sendSubviewToBack(cantListenButton)
        switch mode {
        case .gap:
            resultPopUp?.bottomAnchor.constraint(equalTo: checkButton.topAnchor,
                                                 constant: -12).isActive = true
            resultPopUp?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            resultPopUp?.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                multiplier: 0.9).isActive = true
            resultPopUp?.heightAnchor.constraint(equalToConstant: 175).isActive = true
        default:
            resultPopUp?.bottomAnchor.constraint(equalTo: checkButton.topAnchor,
                                                 constant: -12).isActive = true
            resultPopUp?.topAnchor.constraint(equalTo: wordConstructorBlock.centerYAnchor,
                                              constant: -8).isActive = true
            resultPopUp?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            resultPopUp?.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                multiplier: 0.9).isActive = true

        }
        
        view.layoutIfNeeded()
    }
}

extension HearSentencesGameViewController: BackButtonDelegate {
    func back() {
        presenter.back()
    }
}


extension HearSentencesGameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 10:
            cells[0].remove(at: indexPath.item)
            DispatchQueue.main.async {
                self.wordConstructorBlock.updateCollectionViewsData()
            }
            
        case 11:
            if !cells[0].containsItemWithTag(tag: cells[indexPath.section + 1][indexPath.row].tag) {
                cells[0].append(cells[indexPath.section + 1][indexPath.row])
                DispatchQueue.main.async {
                    self.wordConstructorBlock.updateCollectionViewsData()
                }
            }
        default:
            break
        }
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        canMoveItemAt indexPath: IndexPath) -> Bool {
        switch collectionView.tag {
        case 10:
            return true
        default:
            return false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        targetIndexPathForMoveOfItemFromOriginalIndexPath originalIndexPath: IndexPath,
                        atCurrentIndexPath currentIndexPath: IndexPath,
                        toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        var item: CellData?
        if collectionView.tag == 10 {
            item = cells[0].remove(at: currentIndexPath.row)
            cells[0].insert(item!, at: proposedIndexPath.row)
            return proposedIndexPath
        }
        return originalIndexPath
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath) {
    }
}

extension HearSentencesGameViewController: UICollectionViewDataSource,
                                            UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView.tag {
        case 10, 12, 13, 15:
            1
        default:
            cells.count - 1
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 10:
            return cells[0].count
        case 12, 13:
            return translations.count
        case 15:
            return 7
        default:
            return cells[section + 1].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 12:
            0
        case 13:
            15
        default:
            10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 10:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id",
                                                          for: indexPath) as! WordBoxCollectionCell
            cell.set(object: cells[0][indexPath.row])
            return cell
        case 12:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id",
                                                          for: indexPath) as! ClickableWordCollectionCell
            cell.configurate(cellData: translations[indexPath.row])
            return cell
        case 13:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id",
                                                          for: indexPath) as! ClickableWordCollectionCell
            cell.configurate(cellData: translations[indexPath.row])
            cell.wordLabel.font = UIFont(name: "Futura",
                                         size: 16)
            return cell
        case 15:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id",
                                                          for: indexPath) as! CustomProgressViewCell
            cell.configurate(cellData: ProgressCellData(tag: indexPath.row,
                                                        state: indexPath.row > currentTask ? .gap : .filled))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id",
                                                          for: indexPath) as! WordBoxCollectionCell
            cell.set(object: cells[indexPath.section + 1][indexPath.row])
            if cells[0].containsItemWithTag(tag: cells[indexPath.section + 1][indexPath.row].tag) {
                cell.configuratePlug(cellData: cells[indexPath.section + 1][indexPath.row])
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView.tag {
        case 10, 15:
            return UIEdgeInsets(top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0)
        case 12, 13:
            return UIEdgeInsets(top: 10,
                                left: 10,
                                bottom: 10,
                                right: 10)
        default:
            let numberOfCells = cells[section + 1].count
            var summ: CGFloat = 0
            for i in cells[section + 1] {
                summ += i.width
            }
            let cellSpacing: CGFloat = 10
            
            let collectionViewWidth = collectionView.bounds.width
            
            let horizontalInset = max(0, (collectionViewWidth - summ - CGFloat((numberOfCells - 1)) * cellSpacing) / 2)
            return UIEdgeInsets(top: 10,
                                left: horizontalInset * 0.95,
                                bottom: 0,
                                right: horizontalInset * 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 10:
            return CGSize(width: cells[0][indexPath.row].width,
                          height: 40)
        case 12, 13:
            return CGSize(width: translations[indexPath.row].width,
                          height: 20)
        case 15:
            return CGSize(width: progress.bounds.width / 9,
                          height: 9)
        default:
            return CGSize(width: cells[indexPath.section + 1][indexPath.row].width,
                          height: 40)
        }
    }
}

extension HearSentencesGameViewController: WordBlocksCollectionsBlockDelegate {
    func setSelfAsDelegate(forBlock block: any WordBlocksCollectionsBlockView) {
        block.setDelegate(delegate: self)
        block.setDataSource(dataSource: self)
        block.setflowLayoutDelegate(delegate: self)
    }
}

enum GameMode {
    case hearSentance
    case translateSentance
    case gap
    case hear
}
