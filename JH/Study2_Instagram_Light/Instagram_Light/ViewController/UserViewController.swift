//
//  UserViewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/03.
//

import UIKit
import SnapKit
import SwiftUI

public let userName = "JHL"

@available(iOS 15.0.0, *)
struct UserViewPreview: PreviewProvider {
    static var previews: some View {
        UserViewControllerRepresentable()
            .previewInterfaceOrientation(.portrait)
    }
}

struct UserViewControllerRepresentable:UIViewControllerRepresentable {
    typealias UIViewControllerType = UserViewController
    
    func makeUIViewController(context: Context) -> UserViewController {
        return UserViewController()
    }
    
    func updateUIViewController(_ uiViewController: UserViewController, context: Context) {
    }
}

// 그리드 뷰를 위해 새로운 셀을 하나 더 만들어서 이미지만 받아오게 함.
class UserViewController: UIViewController {
    
    private let userCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidAppear(_ animated: Bool) {
        userCollectionView.reloadData()
        super.viewDidAppear(animated)
        print("UserViewController의 view가 화면에 나타남")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        userCollectionViewLayout()
    }
    
    func userCollectionViewLayout() {
        self.userCollectionView.dataSource = self
        self.userCollectionView.delegate = self
        self.userCollectionView.register(UserViewCustomCell.self, forCellWithReuseIdentifier: "UserViewCustomCell")
        
        view.addSubview(userCollectionView)

        userCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(410)
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureLayout() {
        view.backgroundColor = .white /* Self는 사용하지말자! */
        
        let userNamelabel = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        
        userNamelabel.text = "임재혁"
        userNamelabel.font = UIFont.boldSystemFont(ofSize: 15)
        userNamelabel.textColor = .black
        userNamelabel.sizeToFit()
        
        view.addSubview(userNamelabel)
        
        userNamelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240)
            make.leading.equalToSuperview().offset(25)
        }
        
        let subMassageText = UILabel()
        
        subMassageText.text = "죽어나가는 클론 코딩"
        subMassageText.font = UIFont.systemFont(ofSize: 13)
        subMassageText.textColor = .black
        
        view.addSubview(subMassageText)
        
        subMassageText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(263)
            make.leading.equalToSuperview().offset(25)
        }
        
        let profileTextOne = UILabel()
        
        profileTextOne.text = "게시물"
        profileTextOne.font = UIFont.systemFont(ofSize: 18)
        profileTextOne.textColor = .black
        
        view.addSubview(profileTextOne)
        
        profileTextOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.leading.equalToSuperview().offset(150)
        }
        
        let profileTextTwo = UILabel()
        
        profileTextTwo.text = "팔로워"
        profileTextTwo.font = UIFont.systemFont(ofSize: 18)
        profileTextTwo.textColor = .black
        
        view.addSubview(profileTextTwo)
        
        profileTextTwo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.leading.equalToSuperview().offset(230)
        }
        
        let profileTextThree = UILabel()
        
        profileTextThree.text = "팔로잉"
        profileTextThree.font = UIFont.systemFont(ofSize: 18)
        profileTextThree.textColor = .black
        
        view.addSubview(profileTextThree)
        
        profileTextThree.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.leading.equalToSuperview().offset(310)
        }
        
        let profileNumOne = UILabel()
        
        profileNumOne.text = "3"
        profileNumOne.font = UIFont.systemFont(ofSize: 20)
        profileNumOne.textColor = .black
        view.addSubview(profileNumOne)
        
        profileNumOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(168)
        }
        
        let profileNumTwo = UILabel()
        
        profileNumTwo.text = "10"
        profileNumTwo.font = UIFont.systemFont(ofSize: 20)
        profileNumTwo.textColor = .black
        view.addSubview(profileNumTwo)
        
        profileNumTwo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(242)
        }
        
        let profileNumThree = UILabel()
        
        profileNumThree.text = "10"
        profileNumThree.font = UIFont.systemFont(ofSize: 20)
        profileNumThree.textColor = .black
        view.addSubview(profileNumThree)
        
        profileNumThree.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(322)
        }
        
        let mainTitleText = UILabel()
        mainTitleText.text = "JaehyeokLim"
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
        
        //둥근 테두리
        viewImageOne.layer.cornerRadius = 50
        view.addSubview(viewImageOne)
        viewImageOne.layer.borderWidth = 1
        viewImageOne.layer.borderColor = UIColor.gray.cgColor
        
        //넘치는 영역 잘라내기
        viewImageOne.clipsToBounds = true
        
        viewImageOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.leading.equalToSuperview().offset(20)
            make.size.width.height.equalTo(100)
        }
        
        let profileEditButton = UIButton()
        profileEditButton.backgroundColor = .white // 배경 색상 지정
        profileEditButton.setTitle("프로필 편집", for: .normal) // 타이틀 지정
        profileEditButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        profileEditButton.setTitleColor(.black, for: .normal)
        
        profileEditButton.layer.borderWidth = 1
        profileEditButton.layer.borderColor = UIColor.systemGray5.cgColor
        profileEditButton.layer.cornerRadius = 5
        view.addSubview(profileEditButton)
        
        profileEditButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(295)
            make.leading.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.size.equalTo(CGSize(width: 350, height: 35))
        }
        
        profileEditButton.addTarget(self, action:#selector(self.profileEditButtonAction), for: .touchUpInside)
        
        let mainTabViewOne = UIButton()
        let mainTabViewTwo = UIButton()
        
        mainTabViewOne.setImage(UIImage.init(systemName: "squareshape.split.3x3"), for: .normal)
        mainTabViewTwo.setImage(UIImage.init(systemName: "person.crop.square"), for: .normal)
        
        mainTabViewTwo.tintColor = UIColor.systemGray2
        
        view.addSubview(mainTabViewOne)
        view.addSubview(mainTabViewTwo)
        
        let hrll = UILabel()
        
        hrll.layer.borderWidth = 1
        hrll.layer.borderColor = UIColor.systemGray5.cgColor
        view.addSubview(hrll)
        
        hrll.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(345)
            make.leading.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.size.equalTo(CGSize(width: 350, height: 1))
        }
        
        //버튼 이미지 꽉차게!!
        mainTabViewOne.contentVerticalAlignment = .fill
        mainTabViewOne.contentHorizontalAlignment = .fill
        mainTabViewTwo.contentVerticalAlignment = .fill
        mainTabViewTwo.contentHorizontalAlignment = .fill
        
        mainTabViewOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(355)
            make.leading.equalToSuperview().offset(85)
            make.size.equalTo(CGSize(width: 37, height: 30))
        }
        
        mainTabViewTwo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(355)
            make.right.equalToSuperview().offset(-85)
            make.size.equalTo(CGSize(width: 37, height: 30))
        }
        
        let FeedText = UILabel()
        let PeopleText = UILabel()
        
        FeedText.text = "Feed"
        PeopleText.text = "People"
        
        FeedText.font = UIFont.boldSystemFont(ofSize: 10)
        PeopleText.font = UIFont.boldSystemFont(ofSize: 10)
        
        FeedText.textColor = .systemBlue
        PeopleText.textColor = .systemGray
        
        view.addSubview(FeedText)
        view.addSubview(PeopleText)
        
        FeedText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(380)
            make.leading.equalToSuperview().offset(92)
            make.size.equalTo(CGSize(width: 37, height: 30))
        }
        
        PeopleText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(380)
            make.right.equalToSuperview().offset(-82)
            make.size.equalTo(CGSize(width: 37, height: 30))
        }
        
        mainTabViewTwo.addTarget(self, action:#selector(self.mainTabViewTwoButtonAction), for: .touchUpInside)
        
    
    }
    
    // 팝업 1 Alert이용
    @objc func profileEditButtonAction() {
        let popup = UIAlertController(title: "알림", message: "이 기능은 구현 예정입니다!", preferredStyle: .alert)
        let popupAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        popup.addAction(popupAction)
        self.present(popup, animated: true, completion: nil)
    }
    
    // 팜업 2
    @objc func mainTabViewTwoButtonAction() {
        let popup = UIAlertController(title: "알림", message: "이 기능은 구현 예정입니다!", preferredStyle: .alert)
        let popupAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        popup.addAction(popupAction)
        self.present(popup, animated: true, completion: nil)
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

    //1
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {

            let interval:CGFloat = 3
            let width: CGFloat = ( UIScreen.main.bounds.width - interval * 2 ) / 3
            return CGSize(width: width , height: width )
    }

    //2
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 3
    }

    //3
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 3
    }
}
