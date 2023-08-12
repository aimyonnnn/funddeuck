// 휴대폰 번호 입력 필드의 포맷팅과 백스페이스 처리
// 모든 휴대폰 번호 입력 필드를 선택
var phoneNumberInputs = document.querySelectorAll("input[name='maker_tel']");

// 각각의 입력 필드에 대해 이벤트 리스너 등록
phoneNumberInputs.forEach(function(phoneNumberInput) {
    phoneNumberInput.addEventListener("input", function (event) {
        // 입력 내용에서 "-"를 제외하고 숫자만 추출
        var inputValue = event.target.value.replace(/-/g, '');

        // "-" 제외한 번호 길이를 확인
        var length = inputValue.length;

        // 휴대폰 번호 형식에 맞게 "-"를 추가
        var formattedValue = '';
        if (length > 3) {
            formattedValue += inputValue.substr(0, 3) + '-';
            if (length > 6) {
                formattedValue += inputValue.substr(3, 4) + '-';
                formattedValue += inputValue.substr(7, 4);
            } else {
                formattedValue += inputValue.substr(3);
            }
        } else {
            formattedValue = inputValue;
        }

        // 변환된 번호를 입력 필드에 설정
        event.target.value = formattedValue;
    });

    phoneNumberInput.addEventListener("keydown", function (event) {
        // Backspace 키를 눌렀을 때 "-"를 제거
        if (event.key === "Backspace") {
            var inputValue = event.target.value.replace(/-/g, '');
            inputValue = inputValue.slice(0, -1); // 마지막 문자 제거
            var formattedValue = '';
            if (inputValue.length >= 3) {
                formattedValue += inputValue.substr(0, 3) + '-';
                if (inputValue.length >= 7) {
                    formattedValue += inputValue.substr(3, 4) + '-';
                    formattedValue += inputValue.substr(7);
                } else {
                    formattedValue += inputValue.substr(3);
                }
            } else {
                formattedValue = inputValue;
            }
            event.target.value = formattedValue;
        }
    });
});

// ============================================================================

// 사업자 등록번호 입력 필드를 선택
var individualBizNumInput = document.querySelector("input[name='individual_biz_num']");
var corporateBizNumInput = document.querySelector("input[name='corporate_biz_num']");

// 입력 내용이 변경될 때마다 호출되는 이벤트 리스너 함수
individualBizNumInput.addEventListener("input", formatBizNumInput);
corporateBizNumInput.addEventListener("input", formatBizNumInput);

// 사업자 등록번호 입력 필드에서 키보드 입력이 발생했을 때 처리하는 이벤트 리스너 함수
individualBizNumInput.addEventListener("keydown", handleBackspace);
corporateBizNumInput.addEventListener("keydown", handleBackspace);

function formatBizNumInput(event) {
    // 입력 내용에서 "-"를 제외하고 숫자만 추출
    var inputValue = event.target.value.replace(/-/g, '');

    // "-" 제외한 번호 길이를 확인
    var length = inputValue.length;

    // 사업자 등록번호 형식에 맞게 "-"를 추가
    var formattedValue = '';
    if (length >= 3) {
        formattedValue += inputValue.substr(0, 3) + '-';
        if (length >= 5) {
            formattedValue += inputValue.substr(3, 2) + '-';
            formattedValue += inputValue.substr(5, 5);
        } else {
            formattedValue += inputValue.substr(3);
        }
    } else {
        formattedValue = inputValue;
    }

    // 변환된 번호를 입력 필드에 설정
    event.target.value = formattedValue;
}

function handleBackspace(event) {
    // Backspace 키를 눌렀을 때 "-"를 제거
    if (event.key === "Backspace") {
        var inputValue = event.target.value.replace(/-/g, '');
        inputValue = inputValue.slice(0, -1); // 마지막 문자 제거
        var formattedValue = '';
        if (inputValue.length >= 3) {
            formattedValue += inputValue.substr(0, 3) + '-';
            if (inputValue.length >= 5) {
                formattedValue += inputValue.substr(3, 2) + '-';
                formattedValue += inputValue.substr(5, 5);
            } else {
                formattedValue += inputValue.substr(3);
            }
        } else {
            formattedValue = inputValue;
        }
        event.target.value = formattedValue;
    }
}


