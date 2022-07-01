//
//  ViewController.swift
//  Study3_MusicPlayer
//
//  Created by Jaehyeok Lim on 2022/06/30.
//

import UIKit
import SnapKit
import AVFoundation

public var aadd = -1

public extension UIColor {
    static let textColor = UIColor(named: "commonTextColor")
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let cellTextColor = UIColor(named: "cellTextColor")
    static let cellTitleTextColor = UIColor(named: "cellTitleTextColor")
}

class MainViewController: UIViewController, AVAudioPlayerDelegate {
    
    var musicPlayer = AVAudioPlayer()
    var currentTime: Double = 0
    
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
            make.leading.equalTo(180)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        musicPlayOrStopButton.addTarget(self, action: #selector(musicPlayOrStopButtonAction(_:)), for: .touchUpInside)
        
        return musicPlayOrStopButton
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
        
        let viewList: [UIView] = [mainViewTitleLabel, forwardEndButton, backwardEndButton]
        
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
            make.bottom.equalTo(musicPlayOrStopButton)
            make.leading.equalTo(musicPlayOrStopButton).offset(100)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        backwardEndButton.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        backwardEndButton.contentHorizontalAlignment = .fill
        backwardEndButton.contentVerticalAlignment = .fill
        
        backwardEndButton.snp.makeConstraints { make in
            make.bottom.equalTo(musicPlayOrStopButton)
            make.right.equalTo(musicPlayOrStopButton).offset(-100)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    @objc func musicPlayOrStopButtonAction(_ sender: UIButton) {
//        let point = sender.convert(CGPoint.zero, to: collectionView)
//        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
//
        if aadd == 0 {
            initPlayer(songName: "starman")
        } else {
            initPlayer(songName: "stillLife")
        }
        
        if musicPlayOrStopButton.imageView?.image == UIImage(systemName: "play.fill") {
            self.musicPlayer.play()
            
            musicPlayOrStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

        } else {
            currentTime = musicPlayer.currentTime
            self.musicPlayer.pause()
            musicPlayOrStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
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
            try self.musicPlayer = AVAudioPlayer(data: soundAsset.data)
            self.musicPlayer.delegate = self
//            self.musicPlayer.play()
        } catch let error as NSError {
            print("플레이어 초기화 오류 발생 : \(error.localizedDescription)")
        }
    }
    
    func initList() {
        let item: MainData = MainData(mainDataTitleImage: UIImage(named: "starmanAlbumCoverImage")!, mainDataTitleLabel: "Starman", mainDataSingerLabel: "David Bowie", mainDataAlbumLabel: "The Rise And Fall Of Ziggy Stardust", mainDataSongDate: "1972")
        
        let itemTwo: MainData = MainData(mainDataTitleImage: UIImage(named: "stillLifeAlbumCoverImage")!, mainDataTitleLabel: "Still Life", mainDataSingerLabel: "BIGBANG", mainDataAlbumLabel: "STILL LIFE", mainDataSongDate: "2022")
        
        let itemThree: MainData = MainData(mainDataTitleImage: UIImage(named: "ghostAlbumCoverImage")!, mainDataTitleLabel: "Ghost", mainDataSingerLabel: "Zior Park", mainDataAlbumLabel: "SYNDROMEZ", mainDataSongDate: "2021")
        
        mainList.append(item)
        mainList.append(itemTwo)
        mainList.append(itemThree)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        // Save start time view at indexPath.
        aadd = indexPath.row
        print(aadd)
    }
}

