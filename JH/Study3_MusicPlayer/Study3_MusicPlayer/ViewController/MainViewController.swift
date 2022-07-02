//
//  ViewController.swift
//  Study3_MusicPlayer
//
//  Created by Jaehyeok Lim on 2022/06/30.
//

import UIKit
import SnapKit
import AVFoundation

public extension UIColor {
    static let textColor = UIColor(named: "commonTextColor")
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let cellTextColor = UIColor(named: "cellTextColor")
    static let cellTitleTextColor = UIColor(named: "cellTitleTextColor")
}

class MainViewController: UIViewController, AVAudioPlayerDelegate {
    
    var musicPlayer = AVAudioPlayer()
    var currentTime: Double = 0
    var timer = Timer()
    let currentTimeLabel = UILabel()
    let currentSongMaxTimeLabel = UILabel()
    let repeatButton = UIButton()
    
    var currentSongIndexPath: Int = .zero
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.register(MainViewCollectionCell.self, forCellWithReuseIdentifier: "MainViewCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.backgroundColor
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(140)
            make.bottom.equalTo(view).offset(-290)
            make.leading.equalTo(view)
            make.right.equalTo(view)
        }
        
        return collectionView
    }()
    
    lazy var musicPlayOrStopButton: UIButton = {
        let musicPlayOrStopButton = UIButton()
        
        musicPlayOrStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        musicPlayOrStopButton.contentHorizontalAlignment = .fill
        musicPlayOrStopButton.contentVerticalAlignment = .fill
        
        view.addSubview(musicPlayOrStopButton)
        
        musicPlayOrStopButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-60)
            make.leading.equalTo(175)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        musicPlayOrStopButton.addTarget(self, action: #selector(musicPlayOrStopButtonAction(_:)), for: .touchUpInside)
        
        return musicPlayOrStopButton
    }()
    
    lazy var playSlider: UISlider = {
        let playSlider = UISlider()
        
        playSlider.setThumbImage(UIImage(), for: .normal)
        view.addSubview(playSlider)
        
        playSlider.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(510)
            make.top.equalToSuperview().offset(555)
//            make.height.equalTo(100)
            make.width.equalTo(view)
        }
        
        playSlider.addTarget(self, action: #selector(sliderValueControl), for: .touchUpInside)
        
        return playSlider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initList()
        configureLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func configureLayout() {
        view.backgroundColor = UIColor.backgroundColor
        
        let mainViewTitleLabel = UILabel()
        let forwardEndButton = UIButton()
        let backwardEndButton = UIButton()
        
        let viewList: [UIView] = [mainViewTitleLabel, forwardEndButton, backwardEndButton, repeatButton, currentTimeLabel, currentSongMaxTimeLabel]
        
        for view in viewList {
            self.view.addSubview(view)
        }
        
        mainViewTitleLabel.text = "MUZiK!"
        mainViewTitleLabel.textColor = UIColor.textColor
        mainViewTitleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        mainViewTitleLabel.layer.borderColor = UIColor.red.cgColor
        mainViewTitleLabel.textAlignment = .center
                
        mainViewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(70)
            make.width.equalTo(view)
        }
        
        forwardEndButton.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        forwardEndButton.contentHorizontalAlignment = .fill
        forwardEndButton.contentVerticalAlignment = .fill
        
        forwardEndButton.snp.makeConstraints { make in
            make.bottom.equalTo(musicPlayOrStopButton).offset(-5)
            make.leading.equalTo(musicPlayOrStopButton).offset(100)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        backwardEndButton.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        backwardEndButton.contentHorizontalAlignment = .fill
        backwardEndButton.contentVerticalAlignment = .fill
        
        backwardEndButton.snp.makeConstraints { make in
            make.bottom.equalTo(musicPlayOrStopButton).offset(-5)
            make.right.equalTo(musicPlayOrStopButton).offset(-100)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
        repeatButton.contentHorizontalAlignment = .fill
        repeatButton.contentVerticalAlignment = .fill
        repeatButton.tintColor = .systemGray

        repeatButton.snp.makeConstraints { make in
            make.bottom.equalTo(backwardEndButton).offset(-1)
            make.right.equalTo(backwardEndButton).offset(-55)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
                
        currentTimeLabel.text = ""
        currentTimeLabel.textColor = .systemBlue
        currentTimeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        currentTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(playSlider).offset(5)
            make.leading.equalTo(2)
        }
        
        currentSongMaxTimeLabel.text = ""
        currentSongMaxTimeLabel.textColor = .systemBlue
        currentSongMaxTimeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        currentSongMaxTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(playSlider).offset(5)
            make.trailing.equalTo(-2)
        }
        
        backwardEndButton.addTarget(self, action: #selector(backwardEndButtonAction(_:)), for: .touchUpInside)
        forwardEndButton.addTarget(self, action: #selector(forwardEndButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func mainCellTitleImageAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }

        initPlayer(songName: mainList[indexPath.row].mainDataTitleLabel)
        currentSongIndexPath = indexPath.row
        
        makeAndFireTimer()
        musicPlayOrStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        musicPlayer.play()
    }
    
    @objc func musicPlayOrStopButtonAction(_ sender: UIButton) {

        if musicPlayOrStopButton.imageView?.image == UIImage(systemName: "play.fill") {
            musicPlayer.play()
            
            musicPlayOrStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

        } else {
            currentTime = musicPlayer.currentTime
            musicPlayer.pause()
            musicPlayOrStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc func backwardEndButtonAction(_ sender: UIButton) {
        if currentSongIndexPath == 0 {
            initPlayer(songName: mainList[mainList.count - 1].mainDataTitleLabel)
            currentSongIndexPath = mainList.count - 1
            
        } else {
            initPlayer(songName: mainList[currentSongIndexPath - 1].mainDataTitleLabel)
            currentSongIndexPath = currentSongIndexPath - 1
        }
        
        musicPlayer.play()
    }
    
    @objc func forwardEndButtonAction(_ sender: UIButton) {
        if currentSongIndexPath == (mainList.count - 1) {
            initPlayer(songName: mainList[0].mainDataTitleLabel)
            currentSongIndexPath = 0

        } else {
            initPlayer(songName: mainList[currentSongIndexPath + 1].mainDataTitleLabel)
            currentSongIndexPath = currentSongIndexPath + 1
        }
        
        musicPlayer.play()
    }
    
    @objc func sliderValueControl(_ sender: UISlider) {
        updateTimeLabelText(currentTime: TimeInterval(sender.value))
        
        if sender.isTracking { return }
        musicPlayer.currentTime = TimeInterval(sender.value);
    }
    
    func initPlayer(songName: String) {
        // Audio Session 설정
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
        } catch let error as NSError {
            print("audioSession 설정 오류 : \(error.localizedDescription)")
        }
        
        // 음악 파일 가져오기
        guard let soundAsset: NSDataAsset = NSDataAsset(name: songName) else {
            print("음악 파일이 없습니다.")
            return
        }
        
        // audio player를 초기화합니다.
        do {
            try musicPlayer = AVAudioPlayer(data: soundAsset.data)
            musicPlayer.delegate = self

        } catch let error as NSError {
            print("플레이어 초기화 오류 발생 : \(error.localizedDescription)")
        }
        
        playSlider.maximumValue = Float(musicPlayer.duration);
        playSlider.minimumValue = 0;
        playSlider.value = Float(musicPlayer.currentTime);
    }
    
    func initList() {
        let item: MainData = MainData(mainDataTitleImage: UIImage(named: "starmanAlbumCoverImage")!, mainDataTitleLabel: "Starman", mainDataSingerLabel: "David Bowie", mainDataAlbumLabel: "The Rise And Fall Of Ziggy Stardust", mainDataSongDate: "1972")
        
        let itemTwo: MainData = MainData(mainDataTitleImage: UIImage(named: "stillLifeAlbumCoverImage")!, mainDataTitleLabel: "Still Life", mainDataSingerLabel: "BIGBANG", mainDataAlbumLabel: "STILL LIFE", mainDataSongDate: "2022")
        
        let itemThree: MainData = MainData(mainDataTitleImage: UIImage(named: "ghostAlbumCoverImage")!, mainDataTitleLabel: "Ghost", mainDataSingerLabel: "Zior Park", mainDataAlbumLabel: "SYNDROMEZ", mainDataSongDate: "2021")
        
        let itemList: [MainData] = [item, itemTwo, itemThree]
        
        for items in itemList {
            mainList.append(items)
        }
    }
    
    func makeAndFireTimer(){
        timer = Timer.scheduledTimer(withTimeInterval : 0.01, repeats: true, block : { [unowned self] (timer : Timer) in
            if playSlider.isTracking { return };
            updateTimeLabelText(currentTime: musicPlayer.currentTime);
            playSlider.value = Float(musicPlayer.currentTime);
        })
        
        timer.fire();
    }
    
    func updateTimeLabelText(currentTime:TimeInterval){
        let currentTimeMinute : Int = Int(currentTime / 60)
        let currentTimeSecond : Int = Int(currentTime.truncatingRemainder(dividingBy: 60))
        
        let durationTimeMinute : Int = Int(musicPlayer.duration / 60)
        let durationTimeSecond : Int = Int(musicPlayer.duration.truncatingRemainder(dividingBy: 60))

        let currentTimeText : String = String(format : "%02ld:%02ld", currentTimeMinute, currentTimeSecond);
        let durationTimeText : String = String(format : "%02ld:%02ld", durationTimeMinute, durationTimeSecond);

        currentTimeLabel.text = currentTimeText
        currentSongMaxTimeLabel.text = durationTimeText
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mainList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewCollectionCell", for: indexPath) as? MainViewCollectionCell else { return UICollectionViewCell() }
        let mainListData = mainList[indexPath.row]
        
        cell.transportDataToCell(titleImage: mainListData.mainDataTitleImage, titleText: mainListData.mainDataTitleLabel, singerText: mainListData.mainDataSingerLabel, albumText: mainListData.mainDataAlbumLabel, dateText: mainListData.mainDataSongDate)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 430)
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
        // Save start time view at indexPath.
//    }
}

