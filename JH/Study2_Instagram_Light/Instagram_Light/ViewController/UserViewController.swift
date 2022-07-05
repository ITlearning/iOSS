//
//  UserViewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/03.
//

import UIKit
import SnapKit

public let userBaseImage = UIImage(named: "MainUserImage")
public let userName = "JaehyeokLim"
//public var themeMode = "WHITE"

class UserViewController: UIViewController {
    
    private let userCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidAppear(_ animated: Bool) {
        userCollectionView.reloadData()
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        userCollectionViewLayout()
        self.view.backgroundColor = UIColor.backgroundColor
    }
    
    func userCollectionViewLayout() {
        self.userCollectionView.dataSource = self
        self.userCollectionView.delegate = self
        self.userCollectionView.register(UserViewCustomCell.self, forCellWithReuseIdentifier: "UserViewCustomCell")
        
        userCollectionView.backgroundColor = UIColor.backgroundColor
        
        view.addSubview(userCollectionView)

        userCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(380)
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureLayout() {
        let userNamelabel = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        
        userNamelabel.text = "임재혁"
        userNamelabel.font = UIFont.boldSystemFont(ofSize: 15)
        userNamelabel.textColor = UIColor.textColor
        userNamelabel.sizeToFit()
        
        view.addSubview(userNamelabel)
        
        userNamelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(210)
            make.leading.equalToSuperview().offset(25)
        }
        
        let subMassageText = UILabel()
        
        subMassageText.text = "죽어나가는 클론 코딩"
        subMassageText.font = UIFont.systemFont(ofSize: 13)
        subMassageText.textColor = UIColor.textColor
        
        view.addSubview(subMassageText)
        
        subMassageText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(233)
            make.leading.equalToSuperview().offset(25)
        }
        
        let profileTextOne = UILabel()
        
        profileTextOne.text = "게시물"
        profileTextOne.font = UIFont.systemFont(ofSize: 13)
        profileTextOne.textColor = UIColor.textColor
        
        view.addSubview(profileTextOne)
        
        profileTextOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview().offset(158)
        }
        
        let profileTextTwo = UILabel()
        
        profileTextTwo.text = "팔로워"
        profileTextTwo.font = UIFont.systemFont(ofSize: 13)
        profileTextTwo.textColor = UIColor.textColor
        
        view.addSubview(profileTextTwo)
        
        profileTextTwo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview().offset(237)
        }
        
        let profileTextThree = UILabel()
        
        profileTextThree.text = "팔로잉"
        profileTextThree.font = UIFont.systemFont(ofSize: 13)
        profileTextThree.textColor = UIColor.textColor
        
        view.addSubview(profileTextThree)
        
        profileTextThree.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview().offset(317)
        }
        
        let profileNumOne = UILabel()
        
        profileNumOne.text = "3"
        profileNumOne.font = UIFont.systemFont(ofSize: 20)
        profileNumOne.textColor = UIColor.textColor
        view.addSubview(profileNumOne)
        
        profileNumOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(168)
        }
        
        let profileNumTwo = UILabel()
        
        profileNumTwo.text = "10"
        profileNumTwo.font = UIFont.systemFont(ofSize: 20)
        profileNumTwo.textColor = UIColor.textColor
        view.addSubview(profileNumTwo)
        
        profileNumTwo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(242)
        }
        
        let profileNumThree = UILabel()
        
        profileNumThree.text = "10"
        profileNumThree.font = UIFont.systemFont(ofSize: 20)
        profileNumThree.textColor = UIColor.textColor
        view.addSubview(profileNumThree)
        
        profileNumThree.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(322)
        }
        
        let mainTitleText = UILabel()
        mainTitleText.text = userName
        mainTitleText.textColor = UIColor.textColor
        mainTitleText.font = UIFont.boldSystemFont(ofSize: 30)
        mainTitleText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainTitleText)
        
        mainTitleText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        let viewImageOne = UIImageView()
        viewImageOne.backgroundColor = .red
        viewImageOne.image = UIImage(named: "MainUserImage")
        viewImageOne.translatesAutoresizingMaskIntoConstraints = false
        viewImageOne.contentMode = .scaleAspectFit
        
        viewImageOne.layer.cornerRadius = 50
        viewImageOne.layer.borderWidth = 0.5
        viewImageOne.layer.borderColor = UIColor.black.cgColor
        
        viewImageOne.clipsToBounds = true
        
        view.addSubview(viewImageOne)
        
        viewImageOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.size.width.height.equalTo(100)
        }
        
        let profileEditButton = UIButton()
        
        profileEditButton.backgroundColor = UIColor.backgroundColor
        profileEditButton.setTitle("프로필 편집", for: .normal)
        profileEditButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        profileEditButton.setTitleColor(UIColor.subTextColor, for: .normal)
        
        profileEditButton.layer.borderWidth = 0.5
        profileEditButton.layer.borderColor = UIColor.systemGray5.cgColor
        profileEditButton.layer.cornerRadius = 4.5
        
        view.addSubview(profileEditButton)
        
        profileEditButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(265)
            make.leading.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 320, height: 32))
        }
        
        let themeModebutton = UIButton()
        
        themeModebutton.backgroundColor = UIColor.backgroundColor
        themeModebutton.setImage(UIImage.init(systemName: "gear"), for: .normal)
        themeModebutton.contentHorizontalAlignment = .fill
        themeModebutton.contentVerticalAlignment = .fill
        themeModebutton.tintColor = .darkGray
 
        themeModebutton.layer.borderWidth = 0.5
        themeModebutton.layer.borderColor = UIColor.systemGray5.cgColor
        themeModebutton.layer.cornerRadius = 4.5
        
        view.addSubview(themeModebutton)
        
        themeModebutton.snp.makeConstraints { make in
            make.top.equalTo(profileEditButton).offset(-0.5)
            make.leading.equalTo(profileEditButton).offset(325)
            make.size.equalTo(CGSize(width: 32.5, height: 32.8))
        }
        
        let userViewFeedButton = UIButton()
        let userViewPeopleButton = UIButton()
        
        userViewFeedButton.setImage(UIImage.init(systemName: "squareshape.split.3x3"), for: .normal)
        userViewPeopleButton.setImage(UIImage.init(systemName: "person.crop.square"), for: .normal)
        
        userViewPeopleButton.tintColor = UIColor.systemGray2
        
        view.addSubview(userViewFeedButton)
        view.addSubview(userViewPeopleButton)
        
        let horizonLine = UILabel()
        
        horizonLine.layer.borderWidth = 1
        horizonLine.layer.borderColor = UIColor.systemGray5.cgColor
        view.addSubview(horizonLine)
        
        horizonLine.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(315)
            make.size.equalTo(CGSize(width: 400, height: 0.4))
        }
        
        userViewFeedButton.contentVerticalAlignment = .fill
        userViewFeedButton.contentHorizontalAlignment = .fill
        userViewPeopleButton.contentVerticalAlignment = .fill
        userViewPeopleButton.contentHorizontalAlignment = .fill
        
        userViewFeedButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(325)
            make.leading.equalToSuperview().offset(85)
            make.size.equalTo(CGSize(width: 37, height: 30))
        }
        
        userViewPeopleButton.snp.makeConstraints { make in
            make.top.equalTo(userViewFeedButton)
            make.right.equalToSuperview().offset(-85)
            make.size.equalTo(CGSize(width: 37, height: 30))
        }
        
        let feedButtonText = UILabel()
        let peopleButtonText = UILabel()
        
        feedButtonText.text = "Feed"
        peopleButtonText.text = "People"
         
        feedButtonText.font = UIFont.boldSystemFont(ofSize: 10)
        peopleButtonText.font = UIFont.boldSystemFont(ofSize: 10)
        
        feedButtonText.textColor = .systemBlue
        peopleButtonText.textColor = .systemGray
        
        view.addSubview(feedButtonText)
        view.addSubview(peopleButtonText)
        
        feedButtonText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(350)
            make.leading.equalToSuperview().offset(92)
            make.size.equalTo(CGSize(width: 37, height: 30))
        }
        
        peopleButtonText.snp.makeConstraints { make in
            make.top.equalTo(feedButtonText)
            make.right.equalToSuperview().offset(-82)
            make.size.equalTo(CGSize(width: 37, height: 30))
        }
        
        profileEditButton.addTarget(self, action:#selector(self.profileEditButtonAction), for: .touchUpInside)
        userViewPeopleButton.addTarget(self, action:#selector(self.mainTabViewTwoButtonAction), for: .touchUpInside)
    }
    
    @objc func profileEditButtonAction() {
        let popup = UIAlertController(title: "알림", message: "이 기능은 구현 예정입니다!", preferredStyle: .alert)
        let popupAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        popup.addAction(popupAction)
        self.present(popup, animated: true, completion: nil)
    }
    
    @objc func mainTabViewTwoButtonAction() {
        let popup = UIAlertController(title: "알림", message: "이 기능은 구현 예정입니다!", preferredStyle: .alert)
        let popupAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        popup.addAction(popupAction)
        self.present(popup, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myViewController = SubViewController()
        
        indexPathForSubView = indexPath.row
        
        myViewController.modalPresentationStyle = .fullScreen

        present(myViewController, animated: true, completion: nil)
    }
}

extension UserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserViewCustomCell", for: indexPath) as? UserViewCustomCell else { return UICollectionViewCell() }
        
        cell.UserViewImage.image = userList[indexPath.row].mainImage?.image
        
        return cell
    }
}

extension UserViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {

            let interval:CGFloat = 3
            let width: CGFloat = ( UIScreen.main.bounds.width - interval * 2 ) / 3
            return CGSize(width: width , height: width )
    }

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 3
    }

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 3
    }
}
