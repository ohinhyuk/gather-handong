import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gather_handong/app.dart';
import 'package:gather_handong/components/GridButtons.dart';
import 'package:gather_handong/components/GridButtonsSignup.dart';
import 'package:gather_handong/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'controller/FirebaseController.dart';
import 'model/myUser.dart';

const List<String> interestList = [
  '서적',
  '감상',
  '글쓰기',
  '요리',
  '배우기',
  '마술',
  '노래',
  '랩',
  '피아노',
  '드럼',
  '서예',
  '미술',
  '요가',
  '댄스',
  '발레',
  '스쿼시',
  '등산',
  '서핑',
  '스케이트보드',
  '수영',
  '요트',
  '야구',
  '축구',
  '농구',
  '탁구',
  '볼링',
  '골프',
  '테니스',
  '배드민턴',
  '킥복싱',
  '사격',
  '크로스핏',
  '스노우보드',
  '스케이트',
  '클라이밍',
  '스쿠버다이빙',
  '낚시',
  '악기',
  '사진',
  '영화',
  '드라마',
  '만화',
  '웹툰',
  '게임',
  '보드게임',
  '퍼즐',
  '카드',
  '비디오 편집',
  '애니메이션',
  '웹디자인',
  '모형',
  '로봇',
  '코딩',
  '캘리그라피',
  '비누 만들기',
  '플라워 아트',
  '헬스',
  '필라테스',
  '홈트',
  '체조',
  '헬리콥터',
  '주식',
  '경제',
  '외국어',
  'DIY',
  '영화 감상',
  '음악 감상',
  '여행',
  '사진 찍기',
  '드라이브',
  '산책',
  '캠핑',
  '피크닉',
  '꽃 키우기',
  '악기 연주',
  '독서',
  '맛집 탐방',
  '커피',
  '차',
  '와인',
  '테마파크',
  '전시회',
  '쇼핑',
  '패션',
  '향수',
  '뷰티',
  '피부관리',
  '네일아트',
  '요리 클래스',
  '요가 수련',
  '영화 제작',
  '방송',
  '드라마 연기',
  '스포츠 경기 관람',
  '패션 디자인',
  '사진 스튜디오',
  '공연 관람',
  '동물 애호가',
  '환경 보호',
  '자원 봉사',
  '사회 봉사',
  '기부 활동',
  '걷기',
  '달리기',
  '사이클링',
  '수상스키',
  '요트',
  '골프',
  'PC방',
  'K-드라마',
  '물리학',
  '춤',
  '독서',
  '자전거'
];

const Map<String, List<String>> aboutMeList = {
  'MBTI': [
    'ISTJ',
    'ISFJ',
    'INFJ',
    'INTJ',
    'ISTP',
    'ISFP',
    'INFP',
    'INTP',
    'ESTP',
    'ESFP',
    'ENFP',
    'ENTP',
    'ESTJ',
    'ESFJ',
    'ENFJ',
    'ENTJ'
  ],
  'Education': ['대학교 재학중', '대학교 졸업', '석사', '박사'],
  'BloodType': ['A형', 'B형', 'AB형', 'O형'],
  'Religion': ['기독교', '천주교', '불교', '이슬람', '힌두교', '타종교'],
  'ContactType': [
    '📱카톡 자주 하는 편',
    '📞전화 선호함',
    '🖥영상 통화 선호함',
    '📱카톡 별로 안하는 편',
    '👫직접 만나는 걸 선호함'
  ],
  'loveLanguage': ['✨배려심 깊은 행동', '🎁선물', '🤝스킨십', '👏칭찬', '👩‍❤️👨‍함께 보내는 시간'],
  'Priority': [
    '👔일',
    '✏학업',
    '😀건강',
    '❤연애',
    '️👨‍👩‍👧‍👧가족',
    '🚀취미',
    '💤휴식',
    '💥자기 개발'
  ]
};

const Map<String, List<String>> lifeStyleList = {
  'Drink': [
    '🍺아예 안마심',
    '🍺가끔 마심',
    '🍺자주 마심',
    '🍺매일 마심',
    '🍺혼술할 정도로 좋아하는 편',
    '🍺친구들 만날 때만 마시는 편',
    '🍺현재 금주 중'
  ],
  'Smoke': ['🚭비흡연', '🚬흡연', '🚭금연 중'],
  'WorkOut': ['🏋️‍️매일', '🏋자주', '🏋가끔', '🏋안함'],
  'SNS': ['📱인플루언서', '📱자주 활동함', '📱가끔 활동함', '📱눈팅족', '📵sns 안함'],
  'Sleep': ['😴아침형 인간', '😴야행성', '😴때에 따라 다름'],
};

const List<String> relationList = [
  '💘진지한 연애',
  '😍진지한 연애를 찾지만 캐주얼해도 괜찮음',
  '🍸캐주얼한 연애를 찾지만 진지해도 괜찮음',
  '🎉캐주얼하게 만날 친구',
  '👋새로운 동네 친구',
  '🤔아직 모르겠음'
];

// const List<String>  aboutYouList = {
//   ''
// }

const List<Widget> sexes = <Widget>[
  Text('남자'),
  Text('여자'),
];

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  // List<String> myInterest = [];
  List<String> myAboutMe = [];
  List<String> myLifeStyle = [];
  List<String> myRelation = [];
  List<String> myImages = [];

  // List<String> myEducation = [];
  // List<String> myReligion = [];
  // List<String> myContact = [];
  // List<String> myLoveLanguage = [];
  // List<String> myPriority = [];
  final _interestController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _passwordController = TextEditingController();

  // List<String> added = [];
  //거주지
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  String currentText = "";

  SimpleAutoCompleteTextField? interestAutoCompleteTextField;

  // _SignUpPage() {
  //   interestAutoCompleteTextField = SimpleAutoCompleteTextField(
  //     key: key,
  //     decoration: InputDecoration(
  //       // icon: Icon(Icons.search),
  //       hintText: '관심 태그를 검색',
  //       // helperText: '간략하게 작성',
  //       // counterText: 'ex) 서울특별시',
  //     ),
  //     controller: _interestController,
  //     suggestions: interestList,
  //     textChanged: (text) => {currentText = text},
  //     clearOnSubmit: true,
  //     textSubmitted: (text) => setState(() {
  //       if (interestList.contains(text) && !myInterest.contains(text)) {
  //         myInterest.add(text);
  //       }
  //     }),
  //   );
  // }

  int _selectedSex = 0;

  // final _sexList = ['남성' , '여성'];
  // var _selectedValue = '남성';

  final firebaseRef = FirebaseStorage.instance.ref();

  var uploadImageUrl = 'https://handong.edu/site/handong/res/img/logo.png';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    interestAutoCompleteTextField = SimpleAutoCompleteTextField(
        key: key,
        decoration: InputDecoration(
          // icon: Icon(Icons.search),
          hintText: '관심 태그를 검색',
          // helperText: '간략하게 작성',
          // counterText: 'ex) 서울특별시',
        ),
        controller: _interestController,
        suggestions: interestList,
        textChanged: (text) => {currentText = text},
        clearOnSubmit: true,
        textSubmitted: (text) => {
              if (interestList.contains(text) &&
                  !appState.myInterest.contains(text))
                {appState.addInterest(text)}
            }
        // setState(() {
        // if (interestList.contains(text) && !myInterest.contains(text)) {
        //   myInterest.add(text);
        // }
        // }

        // ),

        );

    var appState_watch = context.watch<ApplicationState>();
    // TODO: implement build
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            '회원 가입',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 50),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(
                    15.0), // 테두리를 round 처리하기 위한 BorderRadius 설정
              ),
              width: double.infinity,
              // color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_gather_handong.png',
                    height: 100,
                  ),

                  Text(
                    '! 신중하게 작성해주세요 !',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: TextField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.drive_file_rename_outline),
                        hintText: '닉네임',
                        helperText: '이름 , 별명 등',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: _ageController,
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.timer),
                        hintText: '나이',
                        helperText: '숫자만 입력 가능',
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child:
                        // textField,
                        TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.home),
                        hintText: '거주 지역',
                        helperText: '간략하게 작성',
                        counterText: 'ex) 서울특별시',
                      ),
                      controller: _locationController,
                      keyboardType: TextInputType.number,
                      // decoration: InputDecoration(
                      //   filled: true,
                      //   // border: OutlineInputBorder(),
                      //   fillColor: Theme.of(context).colorScheme.background,
                      //   labelText: '거주지',
                      // ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(Icons.male),
                          Icon(Icons.female),
                          SizedBox(
                            width: 40,
                          ),
                          ToggleSwitch(
                            minWidth: 90.0,
                            initialLabelIndex: 1,
                            cornerRadius: 20.0,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            totalSwitches: 2,
                            labels: ['남자', '여자'],
                            icons: [
                              FontAwesomeIcons.mars,
                              FontAwesomeIcons.venus
                            ],
                            activeBgColors: [
                              [Colors.blue],
                              [Colors.pink]
                            ],
                            onToggle: (index) {
                              _selectedSex = index!;
                              print('switched to: $index');
                            },
                          ),
                          // ToggleButtons(
                          //   direction: Axis.horizontal,
                          //   onPressed: (int index) {
                          //     setState(() {
                          //       // The button that is tapped is set to true, and the others to false.
                          //       for (int i = 0;
                          //           i < _selectedSexes.length;
                          //           i++) {
                          //         _selectedSexes[i] = i == index;
                          //       }
                          //       print(_selectedSexes);
                          //     });
                          //   },
                          //   borderRadius:
                          //       const BorderRadius.all(Radius.circular(8)),
                          //   selectedBorderColor: Colors.red[700],
                          //   selectedColor: Colors.white,
                          //   fillColor: Colors.red[200],
                          //   color: Colors.red[400],
                          //   constraints: const BoxConstraints(
                          //     minHeight: 40.0,
                          //     minWidth: 80.0,
                          //   ),
                          //   isSelected: _selectedSexes,
                          //   children: sexes,
                          // ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Divider(
                        thickness: 2,
                        height: 1,
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ),

                  BigTitle('나의 관심사를 골라주세요😀'),
                  ListTile(
                    title: interestAutoCompleteTextField,
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: GridButtons(items: appState.myInterest),
                  ),
                  OptionGrid(
                      interestList, '관심사 키워드 목록', 6, appState.myInterest),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Divider(
                        thickness: 2,
                        height: 1,
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ),

                  BigTitle('나를 잘 나타내는 정보를 추가해주세요😀'),
                  // Center(child: Text('나를 잘 나타내는 정보를 추가해주세요😀' , style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  //   color: Theme.of(context).colorScheme.onBackground,
                  // ),),),

                  OptionGrid(
                      aboutMeList['MBTI']!, 'MBTI가 무엇인가요?', 6, myAboutMe),
                  OptionGrid(
                      aboutMeList['Education']!, '학력이 궁금해요!', 6, myAboutMe),
                  OptionGrid(
                      aboutMeList['Religion']!, '종교를 가지고 계시나요?', 6, myAboutMe),
                  OptionGrid(aboutMeList['ContactType']!, '연락 스타일이 어떻게 되시나요?',
                      3, myAboutMe),
                  OptionGrid(aboutMeList['loveLanguage']!,
                      '어떨때 상대방에게 매력을 느끼시나요?', 5, myAboutMe),
                  OptionGrid(
                      aboutMeList['Priority']!, '당신의 우선 순위는?', 4, myAboutMe),

                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Divider(
                        thickness: 2,
                        height: 1,
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ),

                  // LifeStyle
                  BigTitle('나의 라이프 스타일을 추가해주세요😀'),

                  OptionGrid(
                      lifeStyleList['Drink']!, '음주는 얼마나 하시나요?', 6, myLifeStyle),
                  OptionGrid(
                      lifeStyleList['Smoke']!, '흡연 여부가 궁금해요!', 6, myLifeStyle),
                  OptionGrid(
                      lifeStyleList['WorkOut']!, '운동 하시나요?', 6, myLifeStyle),
                  OptionGrid(
                      lifeStyleList['SNS']!, 'SNS를 하시는 빈도는?', 3, myLifeStyle),
                  OptionGrid(lifeStyleList['Sleep']!, '수면 패턴이 어떻게 되세요?', 5,
                      myLifeStyle),

                  BigTitle('내가 찾는 관계'),
                  OptionGrid(relationList, '수면 패턴이 어떻게 되세요?', 5, myRelation),

                  BigTitle('프로필 사진 업로드'),
                  ImageGrid(),

                  Center(
                    child: FilledButton(
                      onPressed: () => {
                        Navigator.pushNamed(context, "/"),
                        FirebaseController.myUserAdd(myUser(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          email: FirebaseAuth.instance.currentUser!.email
                              as String,
                          nickname: _nicknameController.text,
                          age: int.parse(_ageController.text),
                          sex: _selectedSex == 0 ? '남자' : '여자',
                          location: _locationController.text,
                          aboutMe: myAboutMe,
                          interest: appState.myInterest,
                          lifeStyle: myLifeStyle,
                          profileImages: appState_watch.uploadImageUrl
                              .where((item) => item.isNotEmpty)
                              .toList(),
                          relation: myRelation[0],
                          likes: [],
                        ))
                      },
                      child: Text(
                        '가입 하기',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),

                  // Center(child: Text('나의 라이프 스타일을 추가해주세요😀' , style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  //   color: Theme.of(context).colorScheme.onBackground,
                  // ),),),

                  // Center(child: Text('' , style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  //   color: Theme.of(context).colorScheme.onBackground,
                  // ),),),
                  // OptionGrid(interestList , ' ' , 6),
                ],
              ),
            )

            // )

            ));
  }
}

class ImageGrid extends StatefulWidget {
  @override
  _ImageGrid createState() => _ImageGrid();
}

class _ImageGrid extends State<ImageGrid> {
  final firebaseRef = FirebaseStorage.instance.ref();

  // var appState =
  // List<String> uploadImageUrl = ['' , '' , '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    var appState_watch = context.watch<ApplicationState>();
    var appState_read = context.read<ApplicationState>();

    void _pickImage(int index) async {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image?.path == null) return null;

      final ref = firebaseRef.child('product_image').child(image!.name);

      await ref.putFile(File(image!.path));

      ref.getDownloadURL().then((value) => {
            appState_read.addImage(value, index),
            // uploadImageUrl[index] = value,
            // print( appState_watch.uploadImageUrl[index] + value),
            // setState(() {
            // })
          });
    }

    // TODO: implement build
    return GridView.count(
      padding: EdgeInsets.all(20),
      mainAxisSpacing: 15,
      crossAxisSpacing: 10,
      childAspectRatio: 3 / 4,
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: appState_watch.uploadImageUrl.asMap().entries.map((entry) {
        return entry.value == ''
            ? InkWell(
                onTap: () {
                  _pickImage(entry.key);
                },
                child: ImageItem())
            // 사진  / 3에는 사진 리스트의 길이가 들어가면 됨
            : Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     color: Theme.of(context).colorScheme.onBackground,
                    //     width: 2.0,
                    //   ),
                    // ),
                    child: Image.network(entry.value),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: InkWell(
                      onTap: () {
                        // 클릭 이벤트 발생 시 실행될 코드 작성
                        // Navigator.pop(context); // 현재 화면 닫기
                        appState_read.removeImage(entry.key);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              );
      }).toList(),
    );
  }
}

class ImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(
        color: Theme.of(context).colorScheme.onBackground,
        width: 2.0,
      )),
      child: Center(child: Icon(Icons.add)),
    );
  }
}

class OptionGrid extends StatefulWidget {
  final List<String> myList;
  final List<String> itemList;
  final String title;
  final int gridNum;

  OptionGrid(this.itemList, this.title, this.gridNum, this.myList, {Key? key})
      : super(key: key);

  @override
  _OptionGrid createState() => _OptionGrid();
}

class _OptionGrid extends State<OptionGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        child: Column(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            GridButtonsSignup(items: widget.itemList, myItems: widget.myList)
            // GridView.count(
            //   mainAxisSpacing: 15,
            //   crossAxisSpacing: 10,
            //   childAspectRatio: 3 / 1,
            //   crossAxisCount: 4,
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   children: widget.itemList!.map((mbti) {
            //     return Container(
            //       child: widget.myList.contains(mbti)
            //           ? FilledButton(
            //               onPressed: () {
            //                 widget.myList.remove(mbti);
            //                 setState(() {});
            //               },
            //               child: Text(
            //                 mbti,
            //                 style: TextStyle(
            //                   fontSize: 13,
            //                 ),
            //               ),
            //               style: OutlinedButton.styleFrom(
            //                 padding: EdgeInsets.only(
            //                   right: 0,
            //                 ),
            //               ),
            //             )
            //           : OutlinedButton(
            //               onPressed: () {
            //                 widget.myList.add(mbti);
            //                 setState(() {});
            //               },
            //               child: Text(
            //                 mbti,
            //                 style: TextStyle(
            //                   fontSize: 13,
            //                 ),
            //               ),
            //               style: OutlinedButton.styleFrom(
            //                 padding: EdgeInsets.only(
            //                   right: 0,
            //                 ),
            //               ),
            //             ));
            // }).toList(),
            // ),
          ],
        ));
  }
}

class BigTitle extends StatelessWidget {
  var title = "";

  BigTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
    // 나의 라이프 스타일을 추가해주세요😀
  }
}
