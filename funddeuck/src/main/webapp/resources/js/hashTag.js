// 해시태그 유사성 계산 함수
function calculateSimilarity(str1, str2) {
    var minLength = Math.min(str1.length, str2.length);
    var matchCount = 0;

    for (var i = 0; i < minLength; i++) {
        if (str1.charAt(i) === str2.charAt(i)) {
            matchCount++;
        }
    }

    var similarity = matchCount / Math.max(str1.length, str2.length);
    return similarity;
}

// 해시태그 무작위 출력 및 중복 태그가 많을 수록 크기가 커지게 설정
window.onload = function () {
    var hashtags = document.querySelectorAll('.random-hashtag');
    var existingPositions = [];
    var hashtagCounts = {};

    for (var i = 0; i < hashtags.length; i++) {
        var hashtagText = hashtags[i].innerText.trim();

        if (hashtagText.includes(',')) {
            var splitHashtags = hashtagText.split(',');
            for (var k = 0; k < splitHashtags.length; k++) {
                var singleHashtag = splitHashtags[k].trim();
                if (!hashtagCounts[singleHashtag]) {
                    hashtagCounts[singleHashtag] = 1;

                    var position = getRandomPosition(existingPositions, hashtags[i].clientWidth, hashtags[i].clientHeight);
                    if (position) {
                        var newHashtag = document.createElement('div');
                        newHashtag.className = 'random-hashtag';
                        newHashtag.style.fontSize = 14 + hashtagCounts[singleHashtag] * 2 + 'px';
                        newHashtag.innerText = singleHashtag;
                        newHashtag.style.left = position.x + 'px';
                        newHashtag.style.top = position.y + 'px';
                        hashtags[i].parentNode.insertBefore(newHashtag, hashtags[i]);
                    }
                } else {
                    hashtagCounts[singleHashtag]++;
                }
            }
            hashtags[i].remove();
        } else {
            if (!hashtagCounts[hashtagText]) {
                hashtagCounts[hashtagText] = 1;
                var position = getRandomPosition(existingPositions, hashtags[i].clientWidth, hashtags[i].clientHeight);
                if (position) {
                    hashtags[i].style.fontSize = 14 + hashtagCounts[hashtagText] * 2 + 'px';
                    hashtags[i].style.left = position.x + 'px';
                    hashtags[i].style.top = position.y + 'px';
                }
            } else {
                hashtags[i].remove();
            }
        }
    }

    for (var i = 0; i < hashtags.length; i++) {
        var hashtagText = hashtags[i].innerText.trim();

        for (var j = 0; j < i; j++) {
            var prevHashtagText = hashtags[j].innerText.trim();
            var similarity = calculateSimilarity(hashtagText, prevHashtagText);
            if (similarity >= 0.5) {
                hashtags[i].classList.add('similar');
                hashtags[j].classList.add('similar');
                
                hashtagCounts[hashtagText]++;
                hashtagCounts[prevHashtagText]++;
                hashtags[i].style.fontSize = 14 + hashtagCounts[hashtagText] * 0.8 + 'px';
                hashtags[j].style.fontSize = 14 + hashtagCounts[prevHashtagText] * 0.8 + 'px';
            }
        }
    }

    for (var i = 0; i < hashtags.length; i++) {
        var position = getRandomPosition(existingPositions, hashtags[i].clientWidth, hashtags[i].clientHeight);
        hashtags[i].style.left = position.x + 'px';
        hashtags[i].style.top = position.y + 'px';
    }
};

function getRandomPosition(existingPositions, hashtagWidth, hashtagHeight) {
    var x, y;
    var maxAttempts = 100;
    var attempt = 0;

    do {
        x = Math.random() * (370 - hashtagWidth);
        y = Math.random() * (180 - hashtagHeight);
        attempt++;
    } while (isTooClose(existingPositions, x, y, hashtagWidth, hashtagHeight) && attempt < maxAttempts);

    if (attempt === maxAttempts) {
        console.log("적합한 장소가 없습니다.");
        return null;
    }

    existingPositions.push({ x: x, y: y, width: hashtagWidth, height: hashtagHeight });
    return { x: x, y: y };
}

function isTooClose(existingPositions, x, y, width, height) {
    for (var i = 0; i < existingPositions.length; i++) {
        var position = existingPositions[i];
        var distanceX = Math.abs(position.x - x);
        var distanceY = Math.abs(position.y - y);

        if (distanceX < (position.width + width) / 2 && distanceY < (position.height + height) / 2) {
            return true;
        }
    }
    return false;
}

document.addEventListener('DOMContentLoaded', function () {
    var hashLinks = document.querySelectorAll('.hash-link');

    hashLinks.forEach(function (link) {
        link.addEventListener('click', function (event) {
            var searchKeyword = this.querySelector('.random-hashtag').innerText;
            if (searchKeyword) {
                if (this.classList.contains('similar')) {
                    event.preventDefault();
                    window.location.href = 'fundingSearchKeyword?searchKeyword=' + searchKeyword;
                }
            }
        });
    });
});
