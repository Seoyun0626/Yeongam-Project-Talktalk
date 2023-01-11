// Description: 회원관련 함수 모음
// router를 통해 보내는 함수들

// 읍면동 숫자->글자
exports.emd_code_to_name =  function (emd_code){
    if(emd_code == 0) return "영암읍";
    else if(emd_code == 1) return "삼호읍";
    else if(emd_code == 2) return "덕진면";
    else if(emd_code == 3) return "금정면";
    else if(emd_code == 4) return "신북면";
    else if(emd_code == 5) return "시종면";
    else if(emd_code == 6) return "도포면";
    else if(emd_code == 7) return "군서면";
    else if(emd_code == 8) return "서호면";
    else if(emd_code == 9) return "학산면";
    else if(emd_code == 10) return "미암면";
}

// 나이코드 -> 사용자 구분
exports.age_code_to_class =  function (age_code){
    if(age_code == 0) return "청소년";
    else if(age_code == 1) return "학부모";
    else if(age_code == 2) return "청소년 부모";
}

// 권한코드 -> 권한
exports.role_code_to_class =  function (role_code){
    if(role_code == 0) return "관리자";
    else if(role_code == 1) return "일반 회원";
}