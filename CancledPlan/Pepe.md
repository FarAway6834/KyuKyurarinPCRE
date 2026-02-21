# **P**epe : **E**bnfible**P**crew - **E**bnf (EBNF that used on EBNFiblePCREW)

역두문자어 PEPE는 다음의 약자이다.

**P**epe : **E**bnfible**P**crew - **E**bnf (EBNF that used on EBNFiblePCREW)

EBNFiblePCREW가 지원하는 유사 EBNF이다.

표면적으로는, EBNFiblePCREW상의 EBNF이지만, 사실랑 유사 EBNF임을 공식으로 명시할거다.

(지금 작성자는 현제 재작성일 (최초작성일 다음날인 1월 25일) 재작성시간 (9시 8분) 기준 막일어나서 졸려서 설명이 빻은점 양해 부탁한다.)

사실 Pepe코드랑 EBNF코드는 작성부터 다르다.

````markdown
```EBNF
이게 EBNF
```

```pepe
이게 pepe
```
````

이다.

또한 Pepe는 Pepe 컴파일러 (**Pe**PeC : **Pe**pe **C**ompiler)에 의해, PCRE상의 Pepe Core Runtime으로 컴파일된다.

EBNFiblePCREW는 PCREW-DSL의 베터리(Bettery, 언어 내장 기본제공 라이브러리를 의미하는 말)인 DSL인데, Pepe를 사용하기 위한 언어다.

Pepe는 "script for function definition" 페러다임언어고, EBNFiblePCREW는 Pepe의 이용자 (고객) 언어이다.

Pepe랑 EBNFiblePCREW코드는 또 EBNF랑 PCREW랑도 다르다.

````markdown

```EBNF
```

```pepe
```

```pcrew/ebnfible
#!/bin/pcrew/dsl/ebnfible
```

```pcrew
```
````

그렇다. EBNFiblePCREW는 DSL이랍시고 붙인 저 컴파일러 "ebnfible"이 컴파일러인 언어이다.

사실 DSL도 아니고 pcrew를 컴파일러로 활용하게해주는 FW니까 컴파일러라고 불러도 손색이 없고, 그게 사실 옳은말이다.

DSL이 커스컴이 안되고 컴차일만 되명 뭐가 도메인-특화인가? 전혀 문법을 유저가 정의하지 않는데. 그건 걍 컴파일러다.

암튼

pepe코드는 다음과 같이 사용된다.

````pcrew/ebnfible
#!/bin/pcrew/dsl/ebnfible

...함수명 생략... = s/...패턴 앞부분 생략... ```pepe
...pepe 코드 생략...
; 이 버전은 s/$pettern/$replace-str/gm 버전
``` ...패턴 뒷부분 생략.../...치환 문자열 부분 생략.../gm

...함수명 생략... = pcrew(pr/...패턴 앞부분 생략... ```pepe
...pepe 코드 생략...
; 이 버전은 pcrew(pr/$pettern/gm, "$replace-str") 버전
``` ...패턴 뒷부분 생략.../gm, "...치환 문자열 부분 생략...")
````

그리고 자칭 dsl컴파일러라는 사실상 EBNFiblePCREW언어의 컴파일러는, 위에서,

1. pepe코드블럭을 읽는다.
2. Pepe 컴파일러 (**Pe**PeC : **Pe**pe **C**ompiler) 에게 시켜서 PCRE상의 Pepe Core Runtime으로 컴파일시킨다.
3. pepe코드 블럭을 컴파일 결과물인 PCRE상의 Pepe Core Runtime으로 치환한다.
4. 그러면 해당 코드는 일반 PCREW나 다를바 없는 코드가 된다.
5. 그러면 컴파일 끝 ㅋㅋ

이러한 언어가 EBNFiblePCREW이고, EBNFiblePCREW용도의 자칭 EBNF가 Pepe다.

 - Original BNF
 - Wirth's EBNF
 - Cromwell's EBNF
 - Lex/Yacc BNF
 - ABNF
 - Lark EBNF
 - Peg.js / PEG.js
 - RFC 2234
 - ISO/IEC 14977
 - W3C EBNF
 - PEP 617 (EBNF for Python)
 - Regex-infused EBNF
 - 젠장 너무 많아서 검색 포기함...

등 여러가지 EBNF들은 PCREW의 bettery FW인 PCREW-DSL을 통해서 잘 만들기를 빈다. Pepe를 배우는것보다, 차라리, EBNFiblePCREW를 로직으로 빌드된 PCREW-DSL을 이용해서, EBNFiblePCREW로 컴파일되는 코드블럭으로, 각각의 BNF/EBNF들의 코드블럭의 문법을 지원시키기를 바란다. 이상. 서론 끝.

## "script for function definition" 페러다임

함수를 정의하는 용도의 프로그래밍 언어 (스크립트 언어)를 이르는 말.

물론, 그런 페러다임 없다. 내가 붙인 이름

"script for function definition" 페러다임 언어는 항상 라이브러리 용도로 사용되며, 그 라이브러리의 이용자 (고객) 언어가 항상 존재해야한다.

안그러면 라이브러리인 자신을 써줄 타깃이 없으니까.

## PSSL (Pepe Syntax Sugar Layer)

Pepe의 문법 설탕 파트다. 사실은 Pepe는 많는 부분이 문법 설탕으로 되어있다.

예컨데,

```EBNF
(□)<○|●>
```

는 PCRE기준

```PCRE
(□){○,●}
```

에 해당한다.

(왜 bra-cket의 내적의 기호를 썼냐면, 원래 EBNF에서, 비단말 기호명은 BNF/EBNF 문법이 적용되는 문자열로 만들수 없기 때문에, 사용이 불가능한 `<○|●>`를 이런 의미로 사용할수 있게 추가했다)

TIP : `●`는 공문자열이여도 된다. `*`를 확인해보도록.

그리고 예컨데, 이러한 방식에서 파생되는 문법설탕만 해도 여러가지인데,

```EBNF
(□)<|○>
```

는

```EBNF
(□)<0|○>
```

이다.

그리고, special한 수량자 약어가 또 있는데

```EBNF
(□)?
```

는

```EBNF
[□]
```

이고

```EBNF
(□)<0|1>
```

이며

```EBNF
(□|)
```

이다.

그리고,

```EBNF
(□)*
```

는

```EBNF
{□}
```

이고

```EBNF
(□)<0|>
```

이며

```EBNF
(□(□)*)?
```

이다.

그리고,

```EBNF
(□)+
```

는

```EBNF
(□)<1|>
```

이고,

```EBNF
(□)(□)*
```

이다.

(괄호버전은 `【□】` 같은걸로 하고싶지만, 굳이 그런걸 추가하기에는 햇갈려서 추가하지 않았다. (`+`나 `*`나 `?`가 EBNF표준의 의미가 아닌 PCRE적으로 해석되는 이유는 Pepe에서 사용할거라서, 귀찮게 이상한 의미를 쓰기 싫었다. (에초에, 표준이 중구난방인 짜증나는 EBNF가 아니라 BNF를 지원하고 싶언던거라 양해 부탁한다. ~~(왠지 고죠 사토루마냥 자신만만해서 고멘)~~)))

그래서, 모든 문법설탕을 소개하자면...

아.. 미안하다. PReSS(**P**epe**Re**peation**S**yntax**S**ugar)가 모든 문법설탕의 전부인데 이미 소개해버렸다.

앞서 소개한 `<○|●>`와 special한 기호가 다다 ㅋㅋ

미안하다 ㅋㅋ 전혀 formal하지 않게 설명해버렸다 ㅋㅋ

해해 배째 (작성자는 현재(최초작성당일 n번째 edit이고, 10시 51분경) 조증이다)

## PwP (Pepe without PSSL)

PSSL에서 지원하는 문법이 결어된 Pepe로, 문법 설탕으로 만들어진 다수의 문법이 존재하지 않는다.

여기서 지원되는 문법이라고는, BNF의 문법과 그룹, 문자열 기능과, '!'밖에 없다.

예를들어서,

```EBNF
(□)?
```

는

```EBNF
((□)?)
```

로 묶이고,

이는 (□)그룹에 대해서, regex문자열 '?'가 붙은 형태다.

```EBNF
(□)*
```

는

```EBNF
((□)*)
```

로

```EBNF
(□)+
```

는

```EBNF
((□)+)
```

로

```EBNF
(□)<|○>
```
는

```EBNF
((□)<0|○>)
```

로

```EBNF
(□)<○|●>
```

는

```EBNF
((□)<○|●>)
```

로

regex식으로 잘만 평가된다.

문자열도

```EBNF
"□"
```

은

```EBNF
("□")
```

로 평가되며,

```EBNF
<□><○><●>
```

는

```EBNF
(<□><○>)<●>
```

와 같으며

```EBNF
<□>(<○><●>)
```

와 같고,

```EBNF
(□)<○><●>
```

도

```EBNF
(□)(<○><●>)
```

와 같으며

```EBNF
<□><○>(●)
```

도

```EBNF
(<□><○>)(●)
```

와 같으며,

```EBNF
<□>(○)<●>
```
도

```EBNF
(<□>(○))<●>
```

와 같고

```EBNF
<□>((○)<●>)
```

와 같으며,

```EBNF
(□)(○)<●>
```

는

```EBNF
(□)((○)<●>)
```

와 같으며,

```EBNF
<□>(○)(●)
```

는

```EBNF
(<□>(○))(●)
```

와 같으며,

```EBNF
(□)<○>(●)
```

는

```EBNF
((□)<○>)(●)
```

와 같으며

```EBNF
(□)(<○>(●))
```
와 같고,

```EBNF
(□)(○)(●)
```

는

```EBNF
((□)(○))(●)
```
와 같으며

```EBNF
(□)((○)(●))
```

와 같다.

마찬가지로, 선언지 BNF형식에 대해서도,

```EBNF
<□>|<○>|<●>
```

는

```EBNF
(<□>|<○>)|<●>
```

와 같으며

```EBNF
<□>|(<○>|<●>)
```

와 같고,

```EBNF
(□)|<○>|<●>
```

도

```EBNF
(□)|(<○>|<●>)
```

와 같으며

```EBNF
<□>|<○>|(●)
```

도

```EBNF
(<□>|<○>)|(●)
```

와 같으며,

```EBNF
<□>|(○)|<●>
```
도

```EBNF
(<□>|(○))|<●>
```

와 같고

```EBNF
<□>|((○)|<●>)
```

와 같으며,

```EBNF
(□)|(○)|<●>
```

는

```EBNF
(□)|((○)|<●>)
```

와 같으며,

```EBNF
<□>|(○)|(●)
```

는

```EBNF
(<□>|(○))|(●)
```

와 같으며,

```EBNF
(□)|<○>|(●)
```

는

```EBNF
((□)|<○>)|(●)
```

와 같으며

```EBNF
(□)|(<○>|(●))
```
와 같고,

```EBNF
(□)|(○)|(●)
```

는

```EBNF
((□)|(○))|(●)
```
와 같으며

```EBNF
(□)|((○)|(●))
```

마지막으로, 만약

```EBNF
□ ! ○
```

에서, 빈칸 □, ○가 그룹이나, 비단말기호가 아니라면,

```EBNF
□ ! ○
```

Equal

```EBNF
(□) ! ○
```

Equal

```EBNF
□ ! (○)
```

Equal

```EBNF
(□) ! (○)
```

이다.

참고로,

```EBNF
<□> ::= (○ ! ●)
```

는

```EBNF
<□> ::= ○ ! ●
```

인 레벨으로, 괄호가 없으면 한 줄에서 우선순위가 가장 빠르다. (`::=`급)

그리고, 그 다음으로는 `|`이 가장 크다.

또한,

`□`나 `"□"`나 평가가 동일하다면,

```EBNF
□
```

는

```EBNF
"□"
```

로 평가된다.

이제 위에 적용된 평가 규칙들을 PwP 생성규칙이라고 생각해보아라.

PwP 문법은 다음과 같은 종류로 제한된다.

1. 길이-2-연속

e.g. (길이 = 3일때를 길이-2-연속으로 표기하는 법)

```EBNF
((□○)●)
```

2. 길이-2-선언지

e.g. (길이 = 3일때를 길이-2-선언지로 쵸기하는법)

```EBNF
((□|○)●)
```

3. 격리-예외구문

```EBNF
(□) ! (○)
```

혹은

```EBNF
<□> ! <○>
```

4. pepe용 문자열 : simple text : 격리-문자열

```EBNF
("□")
```

5. regex용 문자열 : regex text : 격리-수량자

(제 0 종)

```EBNF
((□)<○|●>)
```

및

(제 1 종)

```EBNF
((□)?)
```

및

(제 2 종)

```EBNF
((□)*)
```

및

(제 3 종)

```EBNF
((□)+)
```

이것 외에 PwP에 허용되는 구문은 없기에, PwP는 한정적인 구문만을 허용하게 되는것이고, 모든 내부 구문 을, 일항 • 이항적으로 기재하게 된다.

## Pepe Core

Pepe Core란, Pepe를 구성하는 최소 문법이다. Pepe를 구성하는 문법 자체가 제한되어있지만, Pepe Core문법에 해당하는 문법으로 Pepe의 모든 문법이 에초에 표현 가능하다.

그래서, Pepe는 Pepe Core로 컴파일된다.

PwP에서 알수 있듯, Pepe는 사실 그룹이 별로 필요 없다.

그렇다는 점에서 착안해서, 그룹은 전부 랙싱해서 전개해버리면 그만이라는 사실을 알 수 있다.

그렇기에, Pepe는 파싱하기에 편한, 튜플의 제귀적 정의를 이용해서,

문법명(부가요소1, 부가요소2, ..., 부가요소n)을

문법명(부가요소1, 문법명(부가요소2, ..., 문법명(부가요소n-1, 부가요소n) ... ))로 이항관계마냥 단순화시킨다.

에초에, regex 문자열셋의 합타입 • 곱타입 • 에러문법타입이라는 세가지 타입에 있어서, 합타입 • 곱타입만이 두가지 이상의 인자를 받고, 멱등 가환반군(합타입은 가환반군, 곱타입은 가환 모노이드 (왜냐하면 empty가 항등원이다))이기 때문이다. 사실상 집합 S에서 선택함수로 요소를 하나씩 빼는 이항 연산을 취해주는거나 다름없다. (유한집합에 대해서는 선택함수가 존재한다는거 누구나 알거다)

### Pepe Core의 문법

빈칸 □, ○, ●에 대하여,

0. 문자열 (사실상 PCRE의 캡쳐를 문자열로 취급한다)

```EBNF
<□> ::= "○"
```

PCRE를 문자열로 취급하는 발상이라, 문자열들의 집합타입에 가까운데, 문자열 타입이라니 솔찍히 내가만들었지만 유쾌하다 ㅋㅋ

그렇기에,

위 종류는 simple-text

라고 하고, regex-text는

```EBNF
<□> ::= <■>{○,●}
```

나

```EBNF
<□> ::= <○>*
```

나

```EBNF
<□> ::= <○>?
```

나

```EBNF
<□> ::= <○>+
```

식의 구문만이 정의된다.

1. 합타입

```EBNF
<□> ::= <○>|<●>
```

2. 곱타입

```EBNF
<□> ::= <○><●>
```

3. 에러 타입

```EBNF
<□> ::= <○> ! <●>
```

이렇게 내가지 구문으로 단순화 가능하며, 이는 PCREW의 서브루틴이자 캡쳐 객체로 다루고 싶었기 때문이었고, 그래서 여러가지 트리 내 객체 접근자와, 플래그을 이용한 Pepe Core Runtime을 만들었다.

이 트리 모델은 이항트리가 되니까 갓벽하다고 생각했기 때문이고,

트리의 각 오브젝트는, 패턴의 역할을 해야한다고 봤기 때문이다.

왜냐? : Leftwise식으로 Rightwise식이 분류된다는 방식이니까

### Pepe Core Runtime

* 들어가기 앞서 : darkside에 대한 설명

곧 설명할거지만, 에러가 나는 상황에서 특별하게 side-effect를 만들어주는 일회용 서브루틴 매치 표현식이다.

C++에서 에러가 나면 스택 트레이스가 많다고 투덜거리는데, 그건 에러 관리를 잘못했기 때문이라고 지적할수 있다.

물론 그 스택트레이스는 짜증난다. "ぶっ殺す"라고 외치면서 개빡칠만큼.

여기도 그런식이다. 에초에, 작성자가 PCRE로 코딩하는건 오늘(2026.01.24)이 처음이라서 별로 죄책감이 없다.

에러가 났다면, darkside에서 이미 탐색을 마친 뒤다.

(?:(?<darkside 이름>))의 방식으로 이용되는데, darksize자체의 캡쳐값은 사용하지 않고, darksize에 매칭되면, darksize내의 서브트리가 정의된다.

darksize는 "?>"와 달리 "?:"가 서브트리를 기록하는 side-effect를 가지기 위해 존재한다.

그렇기에, darkside는 호출하면 안되는 pepe내부 시스템의 함수인것이다. (내부꺼고 호출하면 안된다는게 에초부터 너무 당연하지만 (~~이름부터가 바로 SF냄새난다~~))

만일, EBNF에서, '!'로 인한 에러가 났다면, darkside의 side-effect가 실행된다.

굳이 용어풀이하자면, pepe's darkside = side effect based pepe system's non referenced named math group subrootine expr라고 이해하면 된다.

'!'위반해서 에러가 생긴 경우엔 -> darkside는 에러가 참임을 현제 객체로 기록된다.
'!'를 위반하지 않았고, 새부 내용에서 오류가 생겼을때 -> darkside는 에러가 참임을, 현제 객체고 기록한다.

그리고 마지막으로 밀봉 작업을 진행하는데, 

'!'를 위반한 경우에, 매인 표현식 내에서만 비원자적을 쑨다.

만약, flag확인 함수를 호출했다면, 캡쳐 타입이 아니라 텍스트 타입인 경우를 제외하고,

'!'를 위반한 경우, flag확인 함수 내부 : 

1.bool. 원자적 수량자로 여부를 확인한다.
2.true. 자신의 오류 원인 = 자신의 캡쳐로 할당
2.false. 오류 = 빈칸 할덩

합타입의 경우, flag확인 함수 내부 : 

1.bool. first가 select되었는가? (격리된 서브루틴이 따로 존재한다)
2.true. 자신의 오류 원인 = first
2.false. 자신의 오류 원인 = last

곱타입의 경우, flag확인 함수 내부 : 

1.bool. 원자적 수량자로, first에서 오류가 났는지 확인한다. (격리된 서브루틴이 따로 존재한다)
2.true. 자신의 오류 원인 = first
2.false. 자신의 오류 원인 = last

참고로, 격리된 서브루틴은, 조건문 처리를 위해, 참인 조건을 매치하는거다.

* 들어기기 앞서를 종료. 계속해서 본론 설명

0. emtpy

```PCRE
(?(DEFINE)
    (?<pepe_emtpy>)
)
```

로 기본 정의됨.

1. sum type

```EBNF
<□> := <○>|<●>
```

는

```PCRE
(?(DEFINE)
    (?<pepe_main_□>
        (?<pepe_group_first_□> (?&pepe_main_○)
        )|(?<pepe_group_last_□> (?&pepe_main_●))
    )
    (?<pepe_flag_□>
        (?((?>(?&pepe_main_□)))
            (?((?>(?&pepe_true)))
                (?<pepe_flag_sumtype_□>
                )|(?<pepe_flag_prodtype_□)(?<pepe_flag_texttype_□>)(?<pepe_flag_errible_type_□>)
            )
            (?(<pepe_flag_errible_type_□>)
                (?((?>(?&pepe_group_first_□)))
                    (?:(?<pepe_flag_darksideof_□>
                        (?<pepe_flag_error_true>
                            (?&pepe_main)
                        )
                    )) | (?<pepe_flag_error_false>)
                )
            )
            (?(<pepe_flag_sumtype_□>)
                (?((?>(?&pepe_group_first_□)))
                    (?<pepe_flag_first_matched_□>
                    ) | (?<pepe_flag_last_matched_□>)
                )
            )
            (?(<pepe_flag_prodtype_□>)
                (?<pepe_subtree_first_□>
                    (?((?>(?&pepe_main_□)))
                        (?&pepe_group_first_□)
                    )
                )
                (?<pepe_subtree_last_□>
                    (?((?>(?&pepe_main_□)))
                        (?>(?&pepe_group_first_□))
                        (?&pepe_group_last_□)
                    )
                )
            )
        )
    )
)
```

로

2. product type

```EBNF
<□> := <○><●>
```

는

```PCRE
(?(DEFINE)
    (?<pepe_main_□>
        (?<pepe_group_first_□> (?&pepe_main_○)
        )(?<pepe_group_last_□> (?&pepe_main_●))
    )
    (?<pepe_flag_□>
        (?((?>(?&pepe_main_□)))
            (?((?>(?&pepe_true)))
                (?<pepe_flag_prodtype_□)
                )|(?<pepe_flag_sumtype_□>(?<pepe_flag_texttype_□>)
            )
            (?(<pepe_flag_sumtype_□>)
                (?((?>(?&pepe_group_first_□)))
                    (?<pepe_flag_first_matched_□>
                    ) | (?<pepe_flag_last_matched_□>)
                )
            )
        (?(<pepe_flag_prodtype_□>)
            (?<pepe_subtree_first_□>
                (?((?>(?&pepe_main_□)))
                    (?&pepe_group_first_□)
                )
            )
            (?<pepe_subtree_last_□>
                (?((?>(?&pepe_main_□)))
                    (?>(?&pepe_group_first_□))
                    (?&pepe_group_last_□)
                )
            )
        )
    )
)
```

NOTE : 이제봐서 그런데, if-else같은 흐름을 수정할거다. 저런식의 if다발은 ㅈ도 매치 안될거다. 그러니 해당사항은 지적하지 말아달라.
NOTE : 그리고, 아직 코드를 다 짜지 않아서, 로직을 다 안적어서 그런데, errible type에서는, (?((?:(?<pepe_main_darkside_of_□> (?<pepe_group_last_□> (?&●))))) \k<pepe_group_last_□> | (?<pepe_group_first_□> (?&○)) 로 잘 내부 소스를 작성할 생각이니, 해당사항도 지적 ㄴ.

...작성중...