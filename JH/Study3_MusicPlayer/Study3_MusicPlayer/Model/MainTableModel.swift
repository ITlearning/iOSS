//
//  MainTableModel.swift
//  Study3_MusicPlayer
//
//  Created by Jaehyeok Lim on 2022/07/02.
//

import UIKit

var mainTableViewList = [MainTableViewData]()

var stillLifeLyricsList =  ["이듬해질 녘 꽃 피는 봄", "한여름 밤의 꿈 ", "가을 타 겨울 내릴 눈", "일 년 네 번 또다시 봄", "정들었던 내 젊은 날", "이제는 안녕", "아름답던 우리의 봄 여름 가을 겨울", "\"Four seasons with no reason\"", "비 갠 뒤에 비애 대신 a happy end", "비스듬히 씩 비웃듯 칠색 무늬의 무지개", "철없이 철 지나 철들지 못해 still", "철부지에 철 그른지 오래", "Marchin' 비발디", "차이코프스키,", "오늘의 사계를 맞이해", "마침내, 마치 넷이 못내", "저 하늘만 바라보고서", "사계절 잘 지내고 있어, Good-bye", "떠난 사람 또 나타난 사람", "머리 위 저세상", "난 떠나 영감의 amazon", "지난 밤의 트라우마 다 묻고", "목숨 바쳐 달려올", "새 출발 하는 왕복선", "변할래 전보다는 더욱더", "좋은 사람 더욱더", "더 나은 사람 더욱더", "아침 이슬을 맞고", "내 안에 분노 과거에 묻고", "For life", "울었던 웃었던", "소년과 소녀가 그리워 나", "찬란했던 사랑했던", "그 시절만 자꾸 기억나", "계절은 날이 갈수록 속절없이 흘러", "붉게 물들이고", "파랗게 멍들어 가슴을 훑고", "언젠가 다시 올 그날", "그때를 위하여 그대를 위하여", "아름다울 우리의 봄 여름 가을 겨울", "La la la la la la la la la la la", "La la la la la la la la la la la", "La la la la la la la la la la la", "La la la la la la la la la la la", "이듬해 질 녘 꽃 피는 봄", "한여름 밤의 꿈", "가을 타 겨울 내린 눈", "봄 여름 가을 겨울"]

var beyondLoveLyricsList = ["Back to the day", "갓 10대가 됐을 때", "그때 내가 널 보지 못했다면", "어땠을까 해", "왜인지 외로워지는 밤에 You say", "흐린 추억 속에 네게 안겨 잠드네", "Yeah 친구들과의 술자리", "나는 또 네 얘기를 꺼내", "보고 싶다는 넋두리에", "친구들 답은 뻔해", "10년도 더 된 애를 사랑할 수 있냬", "이제 그만 잊으래", "근데 그게 잘 안돼", "그래 걔 말마따나", "넌 아담의 사과일 수도", "But 난 신을 안 믿으니까", "네 전화 바로 픽업", "지금 주소 찍어", "어디든 상관없어 다 갈 테니까", "그건 사랑이 아냐", "그건 미련이 아냐", "그냥 정이라고 하자", "임마 네가 뭘 알아", "이건 사랑이 맞아", "분명 약속했단 말이야", "I know I’m wrong", "그 자리에 그대로", "두고 온 기억들을", "더듬고 있을 때면", "You say", "그건 사랑이 아냐", "그건 미련이 아냐", "그냥 정리하고 가자", "아메리카노보단 라떼를", "맛있게 내리던 네 집 앞 카페를", "매일 같이 갔었었던 그때를", "내려줄게 쓰지 않아 이제는", "넌 매일 밤 예뻐 예뻐", "해주며 날 재워 재워", "식어버린 널 데워 태워", "꿈에서 날 깨워 줘", "버려진 기억들 속에서", "쓸만한 컷들을 찾고 있어", "이미 내 곁에 더는 없는 너지만", "난 너를 느낄 수 있어", "닿을 듯 안 닿을 듯", "떠나는 뒷모습이", "왜인지 행복해 보여", "너라도 행복해줘", "그건 사랑이 아냐", "그건 미련이 아냐", "그냥 정이라고 하자", "임마 네가 뭘 알아", "이건 사랑이 맞아", "분명 약속했단 말이야", "I know I’m wrong", "그 자리에 그대로", "두고 온 기억들을", "더듬고 있을 때면", "You say", "그건 사랑이 아냐", "그건 미련이 아냐", "그냥 정리하고 가자", "그건 사랑이 아냐", "그건 미련이 아냐", "그냥 정이라고 하자", "임마 네 말이 맞아", "이건 사랑이 아냐", "그냥 정리하고 가자"]

var ghostLyricsList = ["Party’s over now", "You’re still hovering", "above my eyes", "I’m yellin’ out loud", "There’s isn’t any voice", "any sound", "Did I make u or not", "Am I mad but Im not", "I can see u clearly but they deny", "Your touch still remain", "on my mouth", "I can still hear your sound", "No doubt no doubt", "I’m so awkward with this emotion", "Something bother me", "there’s no options", "I feel like a shaman or mad man", "Illusion standing on", "all the wall like a", "Ghost", "Oh oh I can see you ghost", "Ghost", "Please don’t leave me my ghost", "You don’t need to hide", "I already know this", "Just let me feel you", "all night long", "You make me feel like a chosen one", "If you want I can sell", "my soul for ya", "Ghost ghost ghost ghost", "I’m waiting for you", "in a room no light", "Then I think I can see", "your shape more bright", "At the corner", "there’s some silhouette", "I’m pretty god damn sure", "it is you my ghost", "I’m perfectly sober", "Don’t treat me like a bad tripper", "I’m perfectly normal", "Don’t judge my symptoms", "need no doctor", "Did I swear u or not", "Can’t remember it’s like", "These days hard to focus", "on something", "Did I tell you or not", "Honestly I’m waiting for", "Tonight tonight", "I’m so awkward with this emotion", "Something bother me", "there’s no options", "I feel like a shaman or mad man", "Illusion standing on", "all the wall like a", "Ghost", "Oh oh I can see you ghost", "Ghost", "Please don’t leave me my ghost", "You don’t need to hide", "I already know this", "Just let me feel you", "all night long", "You make me feel like a chosen one", "If you want I can sell", "my soul for ya", "Ghost ghost ghost ghost", "I’m waiting for you", "in a room no light", "Then I think I can see", "your shape more bright", "At the corner", "there’s some silhouette", "I’m pretty god damn sure", "it is you my ghost"]

var stillLifeLyricsTimeList: [[Int]] = [[0, 1], [0, 5], [0, 9], [0, 13], [0, 17], [0, 22], [0, 26] , [0, 32], [0, 33] , [0, 37],
                                        [0, 41] , [0, 43], [0, 45], [0, 46], [0, 47], [0, 48], [0, 50], [0, 52], [0, 54], [0, 56], [0, 57], [0, 58],
                                        [1, 0], [1, 1], [1, 2], [1, 4], [1, 5], [1, 7], [1, 10] , [1, 14], [1, 21], [1, 25], [1, 29], [1, 34], [1, 39],
                                        [1, 47], [1, 49], [1, 55], [1, 59], [2, 3], [2, 15], [2, 24], [2, 32], [2, 40] , [2, 48], [2, 52], [2, 56], [3, 0]]

var beyondLoveLyricsTimeList: [[Int]] = [[0, 11], [0, 13], [0, 16], [0, 18], [0, 22], [0, 27], [0, 32], [0, 34], [0, 35], [0, 37], [0, 38], [0, 41], [0, 42],
                                        [0, 43], [0, 45], [0, 47], [0, 49], [0, 51], [0, 52], [1, 0], [1, 2], [1, 3], [1, 6], [1, 7], [1, 8], [1, 11],
                                        [1, 12], [1, 13], [1, 14], [1, 16], [1, 17], [1, 18], [1, 20], [1, 22], [1, 24], [1, 27], [1, 30], [1, 33], [1, 35],
                                         [1, 38], [1, 41], [1, 44], [1, 46], [1, 49], [1, 52], [1, 55], [1, 57], [2, 0], [2, 3], [2, 12], [2, 13], [2, 14],
                                        [2, 17], [2, 18], [2, 20], [2, 22], [2, 23], [2, 24], [2, 26], [2, 27], [2, 28], [2, 29], [2, 31], [2, 55], [2, 57],
                                        [2, 58], [3, 1], [3, 2], [3, 4]]

var ghostLyricsTimeList: [[Int]] = [[0, 18], [0, 20], [0, 22], [0, 26], [0, 28], [0, 30], [0, 32], [0, 34], [0, 36], [0, 39], [0, 41], [0, 42], [0, 44], [0, 49],
                                    [0, 53], [0, 54], [0, 56], [1, 0], [1, 1], [1, 4], [1, 8], [1, 12], [1, 16], [1, 19], [1, 21], [1, 23], [1, 25], [1, 27], [1, 32],
                                    [1, 33], [1, 36], [1, 51], [1, 52], [1, 55], [1, 56], [1, 59], [2, 0], [2, 3], [2, 4], [2, 6], [2, 8], [2, 13], [2, 16], [2, 18],
                                    [2, 20], [2, 22], [2, 23], [2, 25], [2, 27], [2, 29], [2, 31], [2, 36], [2, 40], [2, 42], [2, 44], [2, 48], [2, 49], [2, 52], [2, 56],
                                    [2, 59], [3, 3], [3, 7], [3, 8], [3, 11], [3, 13], [3, 15], [3, 19], [3, 21], [3, 23], [4, 10], [4, 11], [4, 13], [4, 14], [4, 17],
                                    [4, 18], [4, 21], [4, 22]]

struct MainTableViewData {
    let lyrics: String
    var state: Int
}
