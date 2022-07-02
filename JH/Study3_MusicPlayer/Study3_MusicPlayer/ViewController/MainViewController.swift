//
//  ViewController.swift
//  Study3_MusicPlayer
//
//  Created by Jaehyeok Lim on 2022/06/30.
//

import UIKit
import SnapKit
import AVFoundation
import MediaPlayer

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
    var currentSongIndexPath: Int = -1
    var repeatButtonStateNumber: Int = .zero
    let currentTimeLabel = UILabel()
    let currentSongMaxTimeLabel = UILabel()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.register(MainViewCollectionCell.self, forCellWithReuseIdentifier: "MainViewCollectionCell")
        collectionView.backgroundColor = UIColor.backgroundColor
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(MainViewTableCell.self, forCellReuseIdentifier: "MainViewTableCell")
        tableView.backgroundColor = UIColor.backgroundColor
        
        return tableView
    }()
    
   let musicPlayOrStopButton: UIButton = {
        let musicPlayOrStopButton = UIButton()
        
        musicPlayOrStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        musicPlayOrStopButton.contentHorizontalAlignment = .fill
        musicPlayOrStopButton.contentVerticalAlignment = .fill
                
        return musicPlayOrStopButton
    }()
    
    let playSlider: UISlider = {
        let playSlider = UISlider()
        
        playSlider.setThumbImage(UIImage(), for: .normal)
            
        return playSlider
    }()
    
    let repeatButton: UIButton = {
        let repeatButton = UIButton()
        
        repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
        repeatButton.contentHorizontalAlignment = .fill
        repeatButton.contentVerticalAlignment = .fill
        repeatButton.tintColor = .systemGray
        
        return repeatButton
    }()
    
    let backgroud: UIView = {
        
        let background = UIView()
            background.backgroundColor = .clear
        
    return background
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initList()
        configureLayout()
        tableView.rowHeight = 25;
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        print(mainTableViewList.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func configureLayout() {
        view.backgroundColor = UIColor.backgroundColor
        
        let mainViewTitleLabel = UILabel()
        let forwardEndButton = UIButton()
        let backwardEndButton = UIButton()
        
        let viewList: [UIView] = [collectionView, tableView,mainViewTitleLabel, musicPlayOrStopButton, forwardEndButton, backwardEndButton, playSlider, repeatButton, currentTimeLabel, currentSongMaxTimeLabel]
        
        for view in viewList {
            self.view.addSubview(view)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(140)
            make.bottom.equalTo(view).offset(-290)
            make.leading.equalTo(view)
            make.right.equalTo(view)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(currentTimeLabel).offset(15)
            make.bottom.equalTo(musicPlayOrStopButton).offset(-60)
            make.leading.right.equalToSuperview()
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
        
        musicPlayOrStopButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-60)
            make.leading.equalTo(175)
            make.size.equalTo(CGSize(width: 40, height: 40))
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
        
        playSlider.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(510)
            make.top.equalToSuperview().offset(555)
            make.height.equalTo(10)
            make.width.equalTo(view)
        }

        repeatButton.snp.makeConstraints { make in
            make.bottom.equalTo(backwardEndButton).offset(-1)
            make.right.equalTo(backwardEndButton).offset(-58)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
                
        currentTimeLabel.text = ""
        currentTimeLabel.textColor = .systemBlue
        currentTimeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        currentTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(playSlider).offset(10)
            make.leading.equalTo(2)
        }
        
        currentSongMaxTimeLabel.text = ""
        currentSongMaxTimeLabel.textColor = .systemBlue
        currentSongMaxTimeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        currentSongMaxTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(playSlider).offset(10)
            make.trailing.equalTo(-2)
        }
        
        musicPlayOrStopButton.addTarget(self, action: #selector(musicPlayOrStopButtonAction(_:)), for: .touchUpInside)
        backwardEndButton.addTarget(self, action: #selector(backwardEndButtonAction(_:)), for: .touchUpInside)
        forwardEndButton.addTarget(self, action: #selector(forwardEndButtonAction(_:)), for: .touchUpInside)
        playSlider.addTarget(self, action: #selector(sliderValueControl), for: .touchUpInside)
        repeatButton.addTarget(self, action: #selector(repeatButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func mainCellTitleImageAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }

        initPlayer(songName: mainCollectionViewList[indexPath.row].mainDataTitleLabel, index: indexPath.row)
        
        makeAndFireTimer()
        musicPlayOrStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
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
            initPlayer(songName: mainCollectionViewList[mainCollectionViewList.count - 1].mainDataTitleLabel, index: mainCollectionViewList.count - 1)
            
        } else if currentSongIndexPath == -1 {
            return

        } else {
            initPlayer(songName: mainCollectionViewList[currentSongIndexPath - 1].mainDataTitleLabel, index: currentSongIndexPath - 1)
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentSongIndexPath, section: 0), at: .init(rawValue: 0), animated: true)
    }
    
    @objc func forwardEndButtonAction(_ sender: UIButton) {
        
        forwardEndFunction()
    }
    
    @objc func repeatButtonAction(_ sender: UIButton) {
        
        if repeatButtonStateNumber == 2 {
            repeatButtonStateNumber = 0
            
            repeatButton.tintColor = UIColor.systemGray
            repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
            
        } else {
            repeatButtonStateNumber += 1
            
            if repeatButtonStateNumber == 2 {
                repeatButton.setImage(UIImage(systemName: "repeat.1"), for: .normal)
            }
            
            repeatButton.tintColor = UIColor.systemBlue
        }
    }
    
    @objc func sliderValueControl(_ sender: UISlider) {
        updateTimeLabelText(currentTime: TimeInterval(sender.value))
        
        if sender.isTracking { return }
        musicPlayer.currentTime = TimeInterval(sender.value);
    }
    
    func initList() {
        let item: MainCollectionViewData = MainCollectionViewData(mainDataTitleImage: UIImage(named: "stillLifeAlbumCoverImage")!, mainDataTitleLabel: "Still Life", mainDataSingerLabel: "BIGBANG", mainDataAlbumLabel: "STILL LIFE", mainDataSongDate: "2022")
        
        let itemTwo: MainCollectionViewData = MainCollectionViewData(mainDataTitleImage: UIImage(named: "BeyondLoveAlbumCover")!, mainDataTitleLabel: "Beyond Love", mainDataSingerLabel: "BIG Naughty (서동현)", mainDataAlbumLabel: "Beyond", mainDataSongDate: "2022")
        
        let itemThree: MainCollectionViewData = MainCollectionViewData(mainDataTitleImage: UIImage(named: "GhostAlbumCoverImage")!, mainDataTitleLabel: "Ghost", mainDataSingerLabel: "Zior Park", mainDataAlbumLabel: "SYNDROMEZ", mainDataSongDate: "2021")
        
        let itemList: [MainCollectionViewData] = [item, itemTwo, itemThree]
        
        for items in itemList {
            mainCollectionViewList.append(items)
        }
    }
    
    func initPlayer(songName: String, index: Int) {
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
            currentSongIndexPath = index
            remoteCommandInfoCenterSetting()
            initLyrics(index: currentSongIndexPath)
            tableView.reloadData()
            musicPlayer.play()

        } catch let error as NSError {
            print("플레이어 초기화 오류 발생 : \(error.localizedDescription)")
        }
        
        playSlider.maximumValue = Float(musicPlayer.duration);
        playSlider.minimumValue = 0;
        playSlider.value = Float(musicPlayer.currentTime);
    }
    
    func initLyrics (index: Int) {
        mainTableViewList.removeAll()
        
        if index == 0 {
            for lyrics in stillLifeLyricsList {
                let item: MainTableViewData = MainTableViewData(stillLifeLyrics: lyrics, stillLifeState: 0)
                mainTableViewList.append(item)
                
            }
            
        } else if index == 1 {
            
            for lyrics in beyondLoveLyricsList {
                let item: MainTableViewData = MainTableViewData(stillLifeLyrics: lyrics, stillLifeState: 0)
                mainTableViewList.append(item)
            }
        }
    }
    
    func forwardEndFunction() {
        if currentSongIndexPath == (mainCollectionViewList.count - 1) {
            initPlayer(songName: mainCollectionViewList[0].mainDataTitleLabel, index: 0)
            
        } else if currentSongIndexPath == -1 {
            return

        } else {
            initPlayer(songName: mainCollectionViewList[currentSongIndexPath + 1].mainDataTitleLabel, index: currentSongIndexPath + 1)
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentSongIndexPath, section: 0), at: .init(rawValue: 0), animated: true)
    }
    
    func oneSongRepeatFunction() {
        initPlayer(songName: mainCollectionViewList[currentSongIndexPath].mainDataTitleLabel, index: currentSongIndexPath)
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
        
        lyricsFocusing(minute: currentTimeMinute, second: currentTimeSecond)
        currentTimeLabel.text = currentTimeText
        currentSongMaxTimeLabel.text = durationTimeText
    }
    
    func lyricsFocusing(minute: Int, second: Int) {
//        var currentLyricsIndex:Int = 0
//
//        if minute == 0 && second == 0 {
//            mainTableViewList[0].stillLifeState = 1
//
//        } else if minute == 0 && second == 5 {
//            mainTableViewList[0].stillLifeState = 0
//            mainTableViewList[1].stillLifeState = 1
//            currentLyricsIndex = 1
//        }
//        tableView.reloadData()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if repeatButtonStateNumber == 1 {
            forwardEndFunction()
            
        } else if repeatButtonStateNumber == 2 {
            oneSongRepeatFunction()
            
        } else {
            musicPlayOrStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    func remoteCommandInfoCenterSetting() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let center = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = center.nowPlayingInfo ?? [String: Any]()
        let image: UIImage = mainCollectionViewList[currentSongIndexPath].mainDataTitleImage
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = mainCollectionViewList[currentSongIndexPath].mainDataTitleLabel
        nowPlayingInfo[MPMediaItemPropertyArtist] = mainCollectionViewList[currentSongIndexPath].mainDataSingerLabel
        
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: {
            size in return image
        })
            
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = musicPlayer.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = musicPlayer.rate
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = musicPlayer.currentTime
        
        center.nowPlayingInfo = nowPlayingInfo
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mainCollectionViewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewCollectionCell", for: indexPath) as? MainViewCollectionCell else { return UICollectionViewCell() }
        let mainListData = mainCollectionViewList[indexPath.row]
        
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewTableCell", for: indexPath) as? MainViewTableCell else { return UITableViewCell() }
        let mainListData = mainTableViewList[indexPath.row]

        cell.transportDataToCell(lyricsText: mainListData.stillLifeLyrics, lyricsState: mainListData.stillLifeState)
        cell.selectedBackgroundView = backgroud
        
        return cell
    }
}
