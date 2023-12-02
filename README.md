# 📱 청소년톡Talk 


![main_app](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/bbc0ca81-862c-445d-bba5-989ef50569bb)
![board_app](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/71a73bb5-cc35-48d8-91ff-1c94a9abc351)
<br>
![image](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/e9d97947-e3a5-4dcc-b63f-dbd5057cc0bf)
![manager_app](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/af02c3a1-492a-4dbd-9fe6-71f35078fb3a)

<br>

## 프로젝트 소개

- 저희 서비스는 청소년(부모)와 학부모에게 민관통합 맞춤형 복지제공 서비스를 제공하는 어플리케이션 플랫폼입니다.
- 청소년복지 사업 및 정부의 다양한 복지 정책을 맞춤형으로 제공함으로써 청소년 위기 가구 등 사회적 취약 계층에 대한 선제적 사례를 발굴 및 지원합니다.
- 생성형 AI 기반 챗봇 서비스를 통해 디지털 소외계층을 위한 맞춤형 복지 정보 추천을 제공합니다.

<br>

## 팀원 구성

<ul>
  <li>김서윤 - 생성형 AI기반 챗봇 개발</li>
  <li>김태희 - Flutter를 이용한 앱 개발, UI/UX 디자인</li>
  <li>나윤주 - 프로젝트 매니징 및 Flutter를 이용한 앱 개발</li>
  <li>박준우 - 관리자페이지 개발, 백엔드 개발</li>
  <li>박현도 - 생성형 AI기반 챗봇 개발</li>
</ul>

<br>

## 1. 개발 환경

### TechStack
![TechStack](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/7b54a6b6-765e-4348-9b05-c43cef6f179a)
<ul>
  <li>MariaDB, MySQL을 사용한 DB 설계</li>
  <li>Node.js를 이용한 서버 구축</li>
  <li>Firebase이용하여 푸시알림 등의 일부 기능 구현</li>
  <li>Flutter 프레임워크 사용하여 안드로이드와 IOS 모두 사용 가능</li>
  <li>Open AI API와 Python을 사용하여 개인화된 챗봇 구현</li>
  <li>영암군 지자체 데이터 활용</li>
</ul>

### ERD
![ERD](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/fd106739-52a7-4f02-8b3b-2630d135efbd)
<ul>
  <li>유저, 정책, 이벤트 등에 대한 ERD</li>
  <li>유저, 정책 테이블로 분류하여 각각 테이블의 요소들은 실제 개발에서 코드 형태로 관리 및 사용</li>
  <li>이벤트 참여, 무화과 사용 내역, 출석체크 등은 로그 관리를 위해 테이블 정규화</li>
  <li>토근, 탈퇴내역, 공지사항, 코드정보는 관리 편의성을 위해 별개의 테이블로 분리</li>
</ul>

<br>

## 어플리케이션 내 세부 기능

### [회원 가입 / 로그인]
- 어플리케이션 내에서 회원가입, 로그인 가능
- 가입된 회원 정보는 DB에 저장
  
| 회원 가입 / 로그인 |
|----------|
|![image](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/35ea11e3-c000-4c73-8abc-d063230decdc)|

<br>

### [관리자 페이지]
- 회원, 정책 정보 CRUD 관리 기능
- 회원 정보(비밀 번호 등 개인 정보 제외)하고 관리자 페이지에서 회원 목록과 정보 확인
- 관리자 페이지에서 탈퇴 처리 및 정보 수정 같은 회원 정보 CRUD 가능
- 원하는 정책과 배너를 어플리케이션에 업로드 가능
  - 관리자 페이지에서 담당자가 정책을 등록한 정책 데이터는 DB에 저장되고, 모바일 복지검색 페이지에서 데이터를 불러와 정책 목록과 상세 멀명을 보여줌
  - 배너 또한 이미지와 제목을 등록하면 DB에 저장되어 앱 내 메인페이지에서 확인 가능

| 관리자 페이지 |
|----------|
|![image](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/fe00793e-8b22-4fab-bdd4-e70530a5a0be)|

<br>

### [정책 검색]
- 어플리케이션 내에서 키워드 검색과 조건 검색을 통해 사용자 누구나 원하는 정책 검색 가능
- 키워드 검색 - 제목과 내용 중 키워드가 있는 정책을 찾아주는 검색 기능
- 조건 검색 - 학업, 상담 등의 카테고리별로 정책을 분류해 선택한 카테고리의 정책 확인 가능

| 정책 검색 |
|----------|
|![main_app](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/1158f572-d941-4c70-b9cd-9b6c69136ada)![board_app](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/281a7c35-389d-415a-afb9-15fef0812412)|

<br>

### [스크랩, 마이톡톡(마이페이지)]
- 로그인 상태 시에 정책 스크랩 기능과 마이톡톡(마이페이지) 기능 제공
- 다시 보고 싶은 정책 스크랩 가능
- 회원 가입 시 입력한 개인 정보와 무화과 포인트를 마이페이지에서 확인 및 변경 가능

| 스크랩, 마이톡톡(마이페이지) |
|----------|
|<img src="#" alt="스크랩, 마이톡톡 img">|

<br>

### [이벤트]
- 회원 가입, 출석체크, 친구 초대 등의 이벤트 참여를 통해 무화과 포인트를 적립 가능
- 무화과 포인트는 기프티콘 등의 리워드로 교환 가능

| 이벤트 |
|----------|
|![image](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/89c59fe5-8d4a-49c0-9bb2-766906e03024)|

<br>

### [SNS 연동 가능]
- 카카오톡 로그인, 카카오톡 정책 공유, 카카오톡 친구 초대 가능


| SNS 연동 가능 |
|----------|
|![image](https://github.com/Seoyun0626/Yeongam-Project-Talktalk/assets/104416283/e163aab1-8e4e-4f0a-ab80-7109ea9cfdcd)|

<br>

### [정책 추천 챗봇]
- 챗봇에게 특정 정보를 포함하여 추천을 요청하면 사용자 맞춤형 정책 제공
- HuggingFace의 SentenceTransformer를 사용하여 기존 데이터 중 정확도에 필요한 항목만 Embedding 하는 과정을 통해 유사도 산출

| 정책 추천 챗봇 |
|----------|
|![image](https://github.com/Seoyun0626/Seoyun0626/assets/104416283/e9d97947-e3a5-4dcc-b63f-dbd5057cc0bf)|

<br>







