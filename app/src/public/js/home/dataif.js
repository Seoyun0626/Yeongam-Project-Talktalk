$(function () {
    $('#frm_dataif').validate({
        onkeyup: false,
    //      debug: true,
        rules: {
            sensor_board_nm: {
                required: true,
            },
            strt_date: {
                required: true,
            },
            end_date: {
                required: true,
            },
            if_type: {
                required: function () {
                    if ($("#if_type option[value='']")) {
                        return true;
                    } else {
                        return false;
                    }
                }
            },
            if_subtype: {
                required: function () {
                    if ($("#if_subtype option[value='']")) {
                        return true;
                    } else {
                        return false;
                    }
                }
            },
            hostip: {
                required: true,
            },
            port: {
                required: true,
            },
            userid: {
                required: function () {
                    if ($("#if_type").val()=='DBS') {
                        return true;
                    } else {
                        return false;
                    }
                }
            },
            password: {
                required: function () {
                    if ($("#if_type").val()=='DBS') {
                        return true;
                    } else {
                        return false;
                    }
                }
            },
            dbname: {
                required: function () {
                    if ($("#if_type").val()=='DBS') {
                        return true;
                    } else {
                        return false;
                    }
                }
            },
            tbname: {
                required: function () {
                    if ($("#if_type").val()=='DBS' || $('#if_subtype').val()=="MQT") {
                        return true;
                    } else {
                        return false;
                    }
                }
            },
        },
        messages: {
            sensor_board_nm: {
                required: '센서정보 필수 항목입니다',
            },
            strt_date: {
                required: '데이터연계 기간 필수 항목입니다',
            },
            end_date: {
                required: '데이터연계 기간 필수 항목입니다',
            },
            if_type: {
                required: '연계종류 선택 필수 항목입니다',
            },
            if_subtype: {
                required: '연계세부종류 선택 필수 항목입니다',
            },
            hostip: {
                required: '접속 ip주소 필수 항목입니다',
            },
            port: {
                required: '접속 포트 필수 항목입니다',
            },
            userid: {
                required: 'DB접속 사용자ID 필수 항목입니다',
            },
            password: {
                required: 'DB접속 비밀번호 필수 항목입니다',
            },
            dbname: {
                required: '데이터베이스이름 필수 항목입니다',
            },
            tbname: {
                required: function () {
                    if ($("#if_type").val()=='DBS') {
                        return '테이블 이름 필수 항목입니다';
                    } else if ($("#if_subtype").val()=='MQT') {
                        return 'Topic명 필수 항목입니다';
                    }
                }
            }
        },
        submitHandler: function (form) {
            form.submit();
        }
    });
})