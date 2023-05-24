
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/app.dart';

const List<String> interestList = [
  '서적', '감상', '글쓰기', '요리', '배우기', '마술', '노래', '랩', '피아노', '드럼', '서예', '미술', '요가', '댄스', '발레', '스쿼시', '등산', '서핑', '스케이트보드', '수영', '요트', '야구', '축구', '농구', '탁구', '볼링', '골프', '테니스', '배드민턴', '킥복싱', '사격', '크로스핏', '스노우보드', '스케이트', '클라이밍', '스쿠버다이빙', '낚시', '악기', '사진', '영화', '드라마', '만화', '웹툰', '게임', '보드게임', '퍼즐', '카드', '비디오 편집', '애니메이션', '웹디자인', '모형', '로봇', '코딩', '캘리그라피', '비누 만들기', '플라워 아트', '헬스', '필라테스', '홈트', '체조', '헬리콥터', '주식', '경제', '외국어', 'DIY', '영화 감상', '음악 감상', '여행', '사진 찍기', '드라이브', '산책', '캠핑', '피크닉', '꽃 키우기', '악기 연주', '독서', '맛집 탐방', '커피', '차', '와인', '테마파크', '전시회', '쇼핑', '패션', '향수', '뷰티', '피부관리', '네일아트', '요리 클래스', '요가 수련', '영화 제작', '방송', '드라마 연기', '스포츠 경기 관람', '패션 디자인', '사진 스튜디오', '공연 관람', '동물 애호가', '환경 보호', '자원 봉사', '사회 봉사', '기부 활동', '걷기', '달리기', '사이클링', '수상스키', '요트', '골프', 'PC방', 'K-드라마', '물리학', '춤', '독서', '자전거'
];

const Map<String, List<String>> aboutMeList = {
  'MBTI' : ['ISTJ', 'ISFJ', 'INFJ', 'INTJ', 'ISTP', 'ISFP', 'INFP', 'INTP', 'ESTP', 'ESFP', 'ENFP', 'ENTP', 'ESTJ', 'ESFJ', 'ENFJ', 'ENTJ'],
  'Education' : ['대학교 재학중', '대학교 졸업' , '석사' , '박사'],
  'BloodType' : ['A형' , 'B형' , 'AB형' , 'O형'],
  'Religion' : ['기독교', '천주교' , '불교' , '이슬람' , '힌두교' , '타종교'],
  'ContactType' : ['카톡 자주 하는 편', '전화 선호함' , '영상 통화 선호함', '카톡 별로 안하는 편' , '직접 만나는 걸 선호함'],
  'loveLanguage' : ['배려심 깊은 행동' , '선물' , '스킨십' , '칭찬', '함께 보내는 시간'],
  'Priority' : ['일' , '학업' , '건강' , '연애' , '가족' , '취미' , '휴식' , '자기 개발']
};


const List<Widget> fruits = <Widget>[
  Text('남자'),
  Text('여자'),
];


class SignUpPage extends StatefulWidget {

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  List<String> myInterest = [];
  List<String> myMBTI = [];
  List<String> myEducation = [];
  List<String> myReligion = [];
  List<String> myContact = [];
  List<String> myLoveLanguage = [];
  List<String> myPriority = [];

  final _nicknameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<bool> _selectedFruits = <bool>[true, false];
  // final _sexList = ['남성' , '여성'];
  // var _selectedValue = '남성';


  final firebaseRef = FirebaseStorage.instance.ref();

  var uploadImageUrl = 'https://handong.edu/site/handong/res/img/logo.png';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor : Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        leading: IconButton( icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },),
        title: Text('회원 가입' , style: Theme.of(context).textTheme.titleLarge,),
      ),
      body:Padding(

        padding: EdgeInsets.only(left: 30 , right: 30, top: 50, bottom: 50),
        child: Container(
          width: double.infinity,
          // decoration: BoxDecoration(
          //   color: Colors.blue,
          //   borderRadius: BorderRadius.circular(20.0), // 모서리 반지름 설정
          // ),
            color: Colors.white,
          // child: Expanded(

            child: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo_gather_handong.png'),
                Text(
                  '! 신중하게 작성해주세요 !',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),

          Padding(padding: EdgeInsets.all(20),
            child: TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                labelText: '닉네임',
              ),
            ),
          ),
              Padding(padding: EdgeInsets.all(20),
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: '나이'
                  ),
                ),
              ),

                Padding(padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _locationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: '거주지',

                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20),
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedFruits.length; i++) {
                        _selectedFruits[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.red[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.red[200],
                  color: Colors.red[400],
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedFruits,
                  children: fruits,
                ),

                ),
                Padding(padding: EdgeInsets.all(20) ,child :
                  Divider(thickness: 2 , height: 1 , color: Theme.of(context).colorScheme.primaryContainer ),
                ),

                Center(child: Text('나의 관심사를 골라주세요' , style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),),),
                OptionGrid(interestList , ' ' , 6 , myInterest),

                Padding(padding: EdgeInsets.all(20) ,child :
                Divider(thickness: 2 , height: 1 , color: Theme.of(context).colorScheme.primaryContainer ),
                ),

                Center(child: Text('나를 잘 나타내는 정보를 추가해주세요😀' , style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),),),

                OptionGrid(aboutMeList['MBTI']!, 'MBTI가 무엇인가요?' , 6 , myMBTI),
                OptionGrid(aboutMeList['Education']!, '학력이 궁금해요!' , 6 , myEducation),
                OptionGrid(aboutMeList['Religion']! , '종교를 가지고 계시나요?',6 , myReligion),
                OptionGrid(aboutMeList['ContactType']!, '연락 스타일이 어떻게 되시나요?' , 3 , myContact),
                OptionGrid(aboutMeList['loveLanguage']!, '어떨때 상대방에게 매력을 느끼시나요?' , 5, myLoveLanguage),
                OptionGrid(aboutMeList['Priority']!, '당신의 우선 순위는?' , 4, myPriority),


                Padding(padding: EdgeInsets.all(20) ,child :
                Divider(thickness: 2 , height: 1 , color: Theme.of(context).colorScheme.primaryContainer ),
                ),

                // Center(child: Text('' , style: Theme.of(context).textTheme.titleLarge?.copyWith(
                //   color: Theme.of(context).colorScheme.onBackground,
                // ),),),
                // OptionGrid(interestList , ' ' , 6),



              ],
            ),
          )

        // )

      )

    );
  }

}



class OptionGrid extends StatefulWidget {


  final List<String> myList;
  final List<String> itemList;
  final String title;
  final int gridNum;

  const OptionGrid(  this.itemList ,  this.title ,  this.gridNum, this.myList, {Key? key}) : super(key: key);

  @override
  _OptionGrid createState() => _OptionGrid();
}

class _OptionGrid extends State<OptionGrid> {

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(20),
      child:  Column(
        children: [
            Text(widget.title ,  style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          GridView.count(
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 1,
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: widget.itemList!.map((mbti){
              return Container(

                child: widget.myList.contains(mbti) ? FilledButton(
  onPressed: (){
    widget.myList.remove(mbti);
    setState(() {});
  },
  child: Text(mbti, style: TextStyle(
  fontSize: 13,
  ),
  ),
  style: OutlinedButton.styleFrom(
  padding: EdgeInsets.only(
  right: 0,
  )
  ,),
  ) : OutlinedButton(
                  onPressed: (){
                    widget.myList.add(mbti);
                    setState(() {});
                  },
                  child: Text(mbti, style: TextStyle(
                    fontSize: 13,
                  ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.only(
                      right: 0,
                    )
                    ,),
                ));

            }).toList(),
          ),
        ],
      )
    ) ;


  }
}