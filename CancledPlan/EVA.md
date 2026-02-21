# EVA : Ebnf(Eva-bnf)ible Ver Ablepro

(참고 : PCRE는 서브루틴, 제귀, 선택이 가능한 튜링 완전 언어이지, 정규 언어가 아니다.)

(N.B. tri-bit memory runtime은 s/□/■/gm_tbmr이 s/(.*?)/\x55$1/gm이후 s/(?<blep_tbrm>\C)□/■/gm로 처리시키는 방식이라서, \<belp_tbrm<b○>>식으로 ○번째 비트에 접근하는 방식이다. 왜냐하면, 공문자열이 입력으로 들어왔을때는, 아무것도 출력 못하는게 PCRE니까, 그 문제를 해결하기 위해 존재하는거다.)

(N.B. 하... '□, ■, ○, ●'는 빈칸이고, 비트를 다루는 동작은, perl에서는 perl함수로, C에서는 callout을 통해서, C수준에서 조작함. 런타임에 비트를 다뤄야 하기에, 에초에 {PCRE + 사용언어}의 조합임.)

Blep (Bit Level Extended PCRE) 라는 언어로, 비트 레벨까지 조작할수 있는 언어를 만들고, tri-bit runtime memory라는 기능으로, 초반에 \x55를 주어서, 3bit주소당 한 비트씩 배정한, 1바이트를 주어 비트를 다룰수 있게 해주는 플래그도 도입하고, 이 Blep에서, IO()가 IO("")이며, IO(io_chennel_str, data)로, data가 안주어지면, input, 주어지면 output으로, io_channel_str이 공문자열이면, 기본 IO(대게 문자열 입출력)으로 하는 추상화된 I/O로 구현체에 따라서, 프로그램 인자 I/O일수도 있고, 파일 입출력일수도 있고, 시스템 콜일수도 있고, GUI컴포넌트 연결일수도 있게 만든 프로그래밍 언어 Blepro (Bleprogramming)에 대하여, ${IO()}랑 ${IO(□)}랑 ${IO()()}랑 ${IO()(□)}랑 ${IO(□)()}랑 ${IO(□)(■)}를 각각 ${IO()}랑 ${IO(□)}랑 ${IO("")}랑 ${IO("", □)}랑 ${IO(□)}랑, ${IO(□, ■)}로 해석하고, 이게 perl 버전과 C PCRE2.h버전으로 나뉘는데, PCRE2.h에서는, Callout기능을 응용하는거로하고, LLVM버전은 아직 개발 개획이 불확실하지망, PCRE2.h바이트코드를 LLVM AOT하는 전략인게, 어짜피 이 언어에서, 페턴은 추가생성되지 않기 때문. 결국, blepro(pr/□/gm■, "○")를 문법설탕을 통해, s/□/○/gm■로 표기하고, 또한, 여러줄에 걸쳐서 함수명 = blepro(pr/□/gm■, "○")를 쓸수 있으나, 라이브러리용이기 때문에, 다른 blepro파일을 import할수 없고, export도 안되며, 파일내 함수간 상호작용도 불가능하며, 오로지 정규식만 되는 언어. Ablepro : Abstractal Blepro에서는, /bin/ablepro/apkg라는 페키지 메키져가 있어서, /bin/ablepro/apkg project init <directory>로 프로젝트를 제작 가능하며, /bin/ablepro/apkg project delete <directory>로 삭제도 되고, 프로젝트 내부 구조는, {__init__.py, __main__.py, __apkg__.py, apkg/__init__.pyx, apkg/__main__.pyx, apkg/include 디렉토리}가 존재해서, __init__.py는 __apkg__.py를 로드해서 (사실 이미 __pycache__까지 함께 배포됨), __apkg__.py가 초반에 pyximport를 로드하고, apkg/__init__.pyx를 로드하는 방식이며, __main__.py는 __main__.pyx를 import해서, __name__ == "__main__"시 main을 실행하는 로직을, cython에서 if과 함수실행으로 미리 cdef한 함수를 통해서, if__name__is__main__then(__name__, main)이라는 방식으로 실행하는 라이브러리고, C라이브러리라서, 상호 라이브러리간 참조는, "#!/bin/ablepro/pkg/apkg_pramga"가 셔뱅으로 명시되어 있다면, #pragma apkg include "□/■"라고 적힌 부분을 #include "../../../□/apkg/include/■"라고 컴파일해주는 apkg_pramga라이브러리가 존재하고, /bin/ablepro/apkg project build <디렉토리> 를 쓰면 whl이 생기고, /bin/ablepro/apkg project deploy <디렉토리> 를 쓰면, PyPI에 deploy해주면, /bin/ablepro/apkg package download <PyPI 프로젝트명> 을 해주면, pyz파일이 다운로드 받아지는데, 이는, pip download <PyPI 프로젝트명>으로 tempdir에 다운로드받은 프로젝트 whl을 설치해주는 __main__.py라는 파일을 pyz로 묶어서, <whl파일명>.pyz라는 파일로 다운로드 하는것. /bin/ablepro/apkg package install <PyPI 프로젝트명>이라고 하면, /bin/ablepro/apkg package download <PyPI 프로젝트명>로 생성한 pyz파일을 실행해주는데, __main__.py 파일이, /bin/ablepro/pkg에 <PyPI 프로젝트명>이라는 실행파일이나 쉘파일을 생성해서, 거기서, "python -m <PyPI 프로젝트명> $@"식으로 인자를 전달하도록 하며, whl을 pip으로 install하기에, 의존성이 이미 다운로드 되어있는 만큼, 아주 잘 설치된다. 해당 pyz는 근처의 pyz가 whl을 포함하면 실행해주는데, 이는, tempdir에서, 미리 의존성까지 download되어있으면, 그거에 대해서도 pyz로 apkg용 페키지로 만들기 때문이다. 마지막으로, apkg는 최초 설치 도중에, 기본적으로 apkg download를 통해 설치하는 라이브러리거 존재하기에, /bin/ablepro/apkg init이라는 명령어를 무조건 한번은 해당 개발환경에서 실행해야한다.

또한, /bin/ablepro/setting디렉토리의 yaml • toml로 설정을 편집 가능하며, /bin/ablepro/compile로 ablepro를 컴파일 가능하다. 보통 디렉토리나 json을 인자로 넘겨주며, 디렉토리인 경우, __apkg_project__라는 파일에, 컴파일용 셔뱅줄을 기재한다. 그렇다. apkg로 다운로드한 ablepro컴파일러는 참 종류가 많을수 있다. 또한, ablepro는 python3, python3-pip, llvm, clang, perl등의 라이브러리를 참조하므로, dpkg에 의해, PPA로 apt를 통해 리포지토리로 배포되지만, 대부분의 기능이 ablepro에 대한 PyPI 페키지에서 코드로 작성되어있기에, 다운로드 후 초기화 스크립트에 ablepro에 대한 PyPI 페키지를 다운로드 받는 방식이다.

EVA : Ebnf(Eva-bnf)ible Ver Ablepro는 EVA-BNF를 사용할수 있는 Ablepro인데,

/bin/eva 디렉토리에 설치된다. pkg에 항상 eva라는 페키지가 설치되어있다.

````eva
#!/bin/eva/pkg/eva
...
□ = s/□```eva/bnf
코드
```□/□/gm□
...
````
식으로 작성되며, ```eva/bnf가 시작된 지점부터 ```로 종료된 부분까지 켑쳐하여, eva-bnf로 컴파일한다.

eva-bnf는 ablepro로 컴파일되는 Eva용 BNF이다. 사실상 EBNF의 에러 '!'기능과, 그룹 '('기능과 터미널 '"'기능이 존재하고, '*'나 '?'나 '+'가 수량자이며, bra-ket '<□|■>'가 PCRE의 "{□,■}" 에 대응하도록, 원래라면 불가능한 비단말기호 명칭을, bra-ket을 통한 수량자로 개조했으며, 내부적으로, 에러 기능은, "<main> ! <exception>"으로, 최우선순위, 선언지는 "<first_type>|<last_type>"으로 차우선순위, 연언지는 "<first><last>로 세번째 우선순위를 가지고, 내부적으로, 괄호는 렉싱되어서, 특정 이름으로 치환되고, eva_bnf_core라는 언어로 컴파일되는데, eva_bnf_core에서는, _eva_bnf_core_lexed_□로 □에 렉싱한 횟수 번째 숫자로 렉싱되는것과, _eva_bnf_core_mangling_□로, 기존 비단말기호 □가 맹글링되는걸 만들며, 문자열의 역할을 하는 기호는, 죄다 문자열 터미널 기호 '"'로 처리된 후, 괄호에 둘려싸여져서, 괄호가 _eva_bnf_core_lexed_□로 렉싱되고, 수량자도 괄호에 둘려싸여져서, _eva_bnf_core_lexed_□로 렉싱되고, 연언지와 선언지는, 다항연산에서 이항연산이 되는데 결합법칙이 성립하므로, 아무렇게나 나눠서, 괄호에 둘러싸여져서 (어떻게 괄호를 할지 컴파일러에 지시해줄수 있음) _eva_bnf_core_lexed_□로 렉싱되고, _eva_bnf_core_lexed_□로 렉싱된 항목들은 사실 이초에, _eva_bnf_core_lexed_□라는 이름의 비단말기호로 추가되는 거라 ok이고, '!'는 에초에 괄호 없이 여러번 쓰이면 의미 파악 모호성으로 거부하게끔 해놔서, 결국, {문자열 (무인자), 수량자 (수량 대상이 인자로, 단일인자. bra-cket이나 수량자 기호는 기호일 뿐 인자 아님), 연언 (first, last라는 두가지 인자), 선언 (first_type, last_type이라는 두가지 인자), 예외처리 (main, except라는 두가지 인자)} 라는 다섯가지 타입만 허용하고, 이를 Blep화 하면, 여러가지 검사 • 캡쳐 • 플래그 생성 등으로, <태그명_접근 지시어명>으로, 해당 그룹을 매치하거나, 검사, 하위 항목으로 접근하는 사실상 이항이하 트리 파싱과, 예외가 발생했는지의 여부 파악, 해당 태그로 매칭되는지 확인하고, 그렇다면, 해당 문자열의 상태를 플래그나 변수로 파악해주는 서브루틴, 선언지에서 선택된 타입을 알려주는 서브루틴, 오류가 어느 선언지•연언지에서 발생했는지 확인해주는 서브루틴 • 예외처리 타입에서 오류가 발생했는지의 플래그와, 어떤 조건을 위반했는지 에러문자열, 등등 OOP나 namespace마냥 어떤 부분에서 어떤 설정이 있는지 파악할수 있는 Blep용 서브루틴 모음의 DEFINE으로 컴파일됨. 한마디로, 런타임 라이브러리 화 되는것.

(N.B. 모든 apkg는 <페키지명>/apkg/include에 C코드가 있는데, ..은 <페키지명>/apkg이고, ../..은 <페키지명>이고, ../../..은 <페키지명>/..임, 근데, 모든 python의 pip기반 페키지는, site-packages/<페키지명>에 위치하기에, ../../..는 site-packages임. 그러므로, 페키지가, site-packages에 정상 설치되었다면, 링킹 오류는 나지 않음. 그리고, pyximport는 __init__.pyx같은 pyx만 import할때 쓰이고, 해당 pyx는 <페키지명>/apkg내에만 있고, <python.h>도 <페키지명>/apkg의 C파일에서만 참조됨. <페키지명>/apkg의 C코드에서, "include/<순수 C해더>"를 include시, "site-packages/<페키지명>/apkg/include/<순수 C해더>"를 불러오기에, 문제가 아예 없음, 그리고, "site-packages/<페키지명>/apkg/include/<순수 C해더>"에서, "../../../<페키지명 2>/apkg/include/<순수 C해더 2>"를 include하는건 앞서 말했듯, "site-packages/<페키지명 2>/apkg/include/<순수 C해더 2>"를 불러오는것과 같음!! 따라서, apkg의 링킹이 씹창나는 경우는, 이미 python의 pip와 site-packages가 비정상 작동하는 경우밖에 없게 됨!! 그런 python이 만드는 에러 하나로도 무너질수 있다는건 인정하는데, 그점은 python을 이용했다면, python측에서 실수할 가능성을 감안래야하는게, 툴킷 개발은 신뢰 기반이니까.)

## 주의 사항

주의사항 목록을 다룬다

python_system_patch는 핵심 의미론이 아니라, python-pip의 더러운 추상화 폭력때문에 생긴 해프닝으로 에초에, 파일 설치 자체는 python 표준성을 지키는 형식적 범주를 강제하기에 문제 없다.
단지, 비표준 python/apkg동작을, python 표준을 안지켰다는 개소리를 무마하기 위한 페치니, 짚고 넘어가지 말라.
진짜로 죽여버리고싶은 위선자 python놈들... 내 home language가 python만 아니었어도 진작에 버렸다....

### python_system_patch : python 내부 구현의 일관성 부족때문에, apkg용 라이브러리를 site-packages에 배치하지 않는 죄악이 표준 python에 일어나는 문제점으로, "pip install -e"로 설치할시의 심각한 문제점이 발생하고, apkg대신에 pip을 사용하는 경우 (예를들어 pip과 PyPI가 구려서 배포가 잘 안되는 경우) 사용자가 골치아파질수 있게 되었다. (애초에 pip쓰지 말라고 apkg만든거지만) 그래서 긴급 페치를 진행하고, python_system_patch와 ablepro_pypi_apkg라는 이름으로 격리하였다.

요약 : python측이 초래한 magic스타일 코딩 만등주의가 만든, 추상화 바운더리 내에서의 행동만 허용하는 행위가 불러오는 재앙을 막기 위해서, 바닐라 파이썬의 pip install을 통한 PyPI설치라는 정론을 안하는 망할 상황들을 타파하기 위한 긴급 페치, python_system_patch와 /ablepro/pkg/ablepro_pypi_apkg에 더럽게 패치되었다.
첨언 : 비판 안받는다. 에초에 pip install -e가 존재한다는 사실 자체만으로도 이미 python측의 죄악에 치가 떨린다. 내 설계를 멍청이들이 이해하기 어렵다거나, conventional 한 관리 측면에서 부적절하다고 비판할 명분을줬는데, 지들은 추상화라는 거짓을 만들면서 내로남불이다 이거 완전.

dual-standard (AmongusStandard / StrictStandard)

"pip install -e"라는 python 기본 기능을 통해 설치하는 노답 상황에서는, 상대경로 "../../../[페키지명]/apkg/include/[대상]"를 이용한 include가 죽어버리기에, "/bin/ablepro/ablepro_pypi_apkg/pkg/[페키지명]/apkg/include/[대상]"을 통해 include한다

apkg_pramga의 기본 버전은 single_standard로, "../../../[페키지명]/apkg/include/[대상]"가 정론이다.

Python표준이다.

근데 망할 python놈들이 "pip install -e"라는 좆뺑이치는 표준을 만드는 바람에,

상대경로가 사용 불가능한 경우가 생겼고, 결국에, 접근은, sys.path디렉토리 기준 심볼릭이 되었다. 즉, sys.path에 해당하는 절대경로를 쓸수밖에 없는 상황이 되었다는거다.

그래서, apkg_pramga에는 dual-standard모드가 존재하며, `#pramga apkg include "□/■" --option dual-standard`나 `#pramga apkg include "□/■" --option single-standard`로 취급하도록, 업대이트 되었다. (사실 기본값이 "single-standard"라 옵션을 넣을필요 없지만"

`pip install -e`방식은, 근본적인 재앙이여서 (표준의 구현에 있어서, 일관성을 저해한다는 선에서, 나는 저게 이단이라고 생각한다. 반박 안받는다.), --option으로 만들어놓은거다. apkg의 installer도 "pip install"로만 한다.

editible 디렉토리 방식은, 상위디렉토리를 완전히 추상화해버리는 짓거리로, EVA프로젝트를 좆되게 만든 근본적인 악이고, 모호성이다.

그러나, python 3버전 기준 표준이라서 수용한것 뿐, 더이상의 타협은 없다.

POSIX : dockerfile로 주로 제공됨)
/bin/ablepro/ablepro_pypi_apkg는 site-packages 디렉토리의 ablepro_pypi_apkg디렉토리, 즉, site-packages/ablepro_pypi_apkg/ 디렉토리를 가르키는 심볼릭 링크다. ablepro_pypi_apkg는 "pip install -e" 방식으로의 설치가 불허된 페키지라서, site-packages디렉토리 내에 표준적으로 설치할것이 요구된다.
ablepro_pypi_apkg디렉토리의 pkg심볼릭 링크는 ./../디렉토리. 즉, site-packages디렉토리를 가르키는 심볼릭 링크다.
고로, /bin/ablepro/ablepro_pypi_apkg/pkg는 site-packages를 가르킨다.

경로는 표준만 허용된다. 그렇지 않을경우 따뜸하게 오류로 혼줄을 내주는데,
두가지 오류의 경우가 있다.
1. /bin/ablepro/ablepro_pypi_apkg/pkg/ablepro_pypi_apkg가 존재하지 않는 경우
2. /bin/ablepro/ablepro_pypi_apkg/pkg/ablepro_pypi_apkg가 존재하지만, /bin/ablepro/ablepro_pypi_apkg가 가르키는 대상이 /bin/ablepro/ablepro_pypi_apkg/pkg/ablepro_pypi_apkg와 다른 경우
(1)의 경우, ablepro_pypi_apkg가 설치되지 않음 오류(404)고, B(2) 경우, ablepro_pypi_apkg가 editible하게 설치되었음 오류(400)다.

해당 오류가 구현되는건
ablepro_pypi_apkg/__init__.py에서, 오류가 일어났는지 체크하기에 가능하다.
1. 오류를 내뿜지 않는 경우
2. /bin/ablepro/ablepro_pypi_apkg/pkg/ablepro_pypi_apkg에 엑세스 시도서 directory not founded일시 : `/bin/ablepro/ablepro_pypi_apkg/pkg/ablepro_pypi_apkg NON EXSTAT : not installed on standard python`
3. /bin/ablepro/ablepro_pypi_apkg가 가르키는 값과 /bin/ablepro/ablepro_pypi_apkg/pkg/ablepro_pypi_apkg가 가르키는 값이 다를시 : `/bin/ablepro/ablepro_pypi_apkg != /bin/ablepro/ablepro_pypi_apkg/pkg/ablepro_pypi_apkg : not installed standardly`

또한, /bin/ablepro/python_system_patch/디렉토리의 /bin/ablepro/python_system_patch/bin은 "../../"를 가르키는 심볼릭 링크로, /bin을 가르킨다.

/bin/ablepro/ablepro_pypi_apkg는 내부 초기화 과정에서, "pip install ablepro_pypi_apkg"를 통해 설치한 ablepro_pypi_apkg의 경로이며, `python -m ablepro_pypi_apkg.status 〔ablepro의 경로〕`를 초반에 작동시키면, ablepro_pypi_apkg의 절대경로를 출력하고, `python -m ablepro_pypi_apkg.status`를 다시 호출하면, 과거에 한번 `python -m ablepro_pypi_apkg.status 〔ablepro의 경로〕` 를 실행 했었기에, ablepro_pypi_apkg/ablepro라는 심볼릭 링크로, ablepro의 경로를 가르키는 심볼릭 링크를 만들게 되고, 이때부터 __init__.py가 디렉토리 구조가 정상인지 확인한다.

디렉토리는 무조건 표준이여야 하고, 아니라면, __init__.py가 오류라고 경고하고, 표준 동작을 하지 않으려고 "배째라"를 시전하면서, "프로그래밍 언어 환경이 broken됬으니 다시 설치하라"라며, 으름장을 놓는다. 디렉토리의 모호성을 줄이기 위한 방안이다.

ablepro/python_system_patch/warning.yaml은 오로지 warning이라는 불리언 키 하나만을 가진 yaml이고, __init__.py에서, warning.yaml을 읽고, warning이 true라면, 현재 환경이 dockerfile로 주어졌는지 아닌지를 분석하고, "Warning : non-dockerfile version is AmongusStandard"라고 경고함.

사실 내부적으로 두가지 표준이 있는데, AmongusStandard의 경우는, python은 어느 경로에나 설치되도 되고, ablepro의 bin에 해당하는 디렉토리는 어느 경로여도 좋으니, 심볼릭 링크가 재대로 되어있어서, ablepro와 python이 각자 독립된 저장공간의 폴더마냥 추상화되어있으나, 모호성 0의 상태로 표준을 준수해야하는 상태고,
StrictStandard는 전용 Ubuntu Dockerfile에서 AmongusStandard조건을 만족하고, /bin디렉토리에 ablepro가 위치하고, python도 고정된 디렉토리에 존재하게 하는 조건이다.

AmongusStandard는 말이 Amongus여서 그렇지, 실제로는 ablepro설치시, PyPI apkg도 설치되고, PyPI apkg는 내부 소스 수정이 원칙상 금지 (프로그램의 의미론을 변경하는 broke시키는 행위로 취급함) 이며, ablepro디렉토리를 건드리는것도 원칙상 금지 (프로그램의 의미론을 변경하는 broke시키는 행위로 취급함) 이다. 그렇기에, 경고 끄는것도, broke취급한다.
warning.yaml에서, warning속성이 false라고 해서 오류가 막히는것도 아니고, warning.yaml에서 warning속성 말고도 속성이 있으먼 얄짤없이, broken취급해서, Broken Error고, warning이 false면, broken이지만, 유일하게 Broken Error가 안나는 broken이다. 에초에, warning속성이 false면, dockerfile이 아닐때의 warning을 끄는거라, warning속성이 false임을 broken이라고 warning해버리면, 골치아프니 그런거다.
모든 broken은 곧 Error다.
디렉토리 위치가 하나 달라졌다 해도, 전체적인 구조가 형식적으로 정해져있으먼, AmongusStandard
하나도 달라지면 안되면 StrictStandard인 셈이고, 에초에 수정을 금한다는 점에서, 형식적 의미를 훼손하는걸 해킹으로 취급한다는거다.

이러다 보니, /ablepro/pkg/ablepro_pypi_apkg 를 /ablepro/apkg가 심볼릭 링킹하도록, 변경되었고, /ablepro/pkg의 관리 방법은 그대로 유지되었다.
apkg용 라이브러리를 site-packages에 배치하지 않는 죄악을 단죄하기 위한 업데이트일 뿐이다.

업데이트 명칭은 python_system_patch

non-POSIX : /bin의 역할을 하는 디렉토리 대신에, 디스크 최상위 디렉토리 등, 설치 관리자가 지정한 디렉토리에 설치한다. (AmongusStandard), OS별 설치 관리자에 의존한다.

### blep의 주의사항

LLVM버전에 대해 : 단순히, PCRE 바이트코드를 LLVM IR로 매핑하고, LLVM화된 PCRE의 compile은 런타임에 사용 안될거고, match부분은, callout부분을 제외하고 LLVM IR로 매핑되고, callout만, C의 PCRE2.h의 callout함스 호출로 설정하면 되겠다고 생각삼. 그러면, LLVM/Clang컴파일러는, 상수로 정해진, 매칭 코드를 LLVM IR로, callout과 C부분은 Clang에 맞겨서, Clang이 C -> LLVM IR -> Target machine을 하고, LLVM이, PCRE -> LLVM IR -> Target machine을 할때, callout은 C를 LLVM IR의 함수로 되어있을때, PCRE의 LLVM IR이 해당 함수를 호출하는 로직이면 되니까. 아직 LLVM버전에 대한건 미정이다. 명세를 미뤄놓은거다. (당연하다. 그러한 최적화 방안은, 꼭 필요한것 뿐이지, 핵심적인 명세는 이미 perl/C쪽에서 다 구상되었다.)

tbrm과 비트 접근 전반에 대해 : 

tri-bit runtime memory는 그냥 blep_tbrm이라는 매칭 그룹을 몰래 추가하는것 뿐이다.
그걸로 몰래 매칭을 기본 상수랍시고 하나 주어준거다.
그리고, blep의 비트 레벨 접근은, 감지의 경우, (?<이름> (?<비트의 이름 0> \<blep>) (?<비트의 이름 1> \<blep>) (?<비트의 이름 2> \<blep>) (?<비트의 이름 3> \<blep>) (?<비트의 이름 4> \<blep>) (?<비트의 이름 5> \<blep>) (?<비트의 이름 6> \<blep>) (?<비트의 이름 7> \<blep>)이라 적었다면, (?<이름> \C)로 컴파일되고,
(?<이름2> \<blep<이름 a<비트의 이름 a>>> \<blep<이름 b<비트의 이름 b>>> \<blep<이름 c<비트의 이름 c>>> \<blep<이름 d<비트의 이름 d>>> \<blep<이름 e<비트의 이름 e>>> \<blep<이름 f<비트의 이름 f>>> \<blep<이름 g<비트의 이름 g>>> \<blep<이름 h<비트의 이름 h>>>)는 (?<이름2> ${blep(이름 a, 이름 a의 비트의 이름 a의 비트가 몇번째인지, 이름 b, 이름 b의 비트의 이름 b의 비트가 몇번째인지, 이름 c, 이름 c의 비트의 이름 c의 비트가 몇번째인지, 이름 d, 이름 d의 비트의 이름 d의 비트가 몇번째인지, 이름 e, 이름 e의 비트의 이름 e의 비트가 몇번째인지, 이름 f, 이름 f의 비트의 이름 f의 비트가 몇번째인지, 이름 g, 이름 g의 비트의 이름 g의 비트가 몇번째인지, 이름 h, 이름 h의 비트의 이름 h의 비트가 몇번째인지)})으로 컴파일되며, 
(?<이름> (?<비트의 이름 0> \<blep>) (?<비트의 이름 1> \<blep>) (?<비트의 이름 2> \<blep>) (?<비트의 이름 3> \<blep>) (?<비트의 이름 4> \<blep>) (?<비트의 이름 5> \<blep>) (?<비트의 이름 6> \<blep>) (?<비트의 이름 7> \<blep>)형식이 아니라, \<blep<...<...>>>가 한번이라도 사용되었다면, (?<비트의 이름 n>)을 \blep<<비트의 이름 n>>으로 컴파일함.
그래서,
0. blep에 공백으로 주어진 이름이 없으면, 기본 컴파일인데, 아니면,
(?<이름2> (?=((?<blep> \C))) (?(${blep(이름 a, 이름 a의 비트의 이름 a의 비트가 몇번째인지, 이름 b, 이름 b의 비트의 이름 b의 비트가 몇번째인지, 이름 c, 이름 c의 비트의 이름 c의 비트가 몇번째인지, 이름 d, 이름 d의 비트의 이름 d의 비트가 몇번째인지, 이름 e, 이름 e의 비트의 이름 e의 비트가 몇번째인지, 이름 f, 이름 f의 비트의 이름 f의 비트가 몇번째인지, 이름 g, 이름 g의 비트의 이름 g의 비트가 몇번째인지, 이름 h, 이름 h의 비트의 이름 h의 비트가 몇번째인지)})\k<blep>|(?!))
1. blep에 공백으로 주어진 이름이 없다 -> 모든 이름 값에서, 해당 비트를 마스킹 bit-and이후, 시프트하여, 현재 인자 번째수에 맞도록 시프트를 조져준다. 그 이후 합하여 리턴
2. blep에 공백으로 주어진 이름이 있다 -> 공백으로 주어지지 않은 이름은 현제 인자수에 맞도록 시프팅하고, 현재 그룹이 이미로 blep으로 캠쳐되어있을거니 해당 캡쳐값에서, 비트가 맞는지 xor로 0이 나오는지 확인 이후, 맞다면 참 아니면 거짓을 반환.
3. 비트의 이름은, \<blep<이름<비트의 이름>>으로 동작하고, 실제로 그게 비트 숫자로 컴파일되기에, 컴파일타임에만 존재하는 가상 이름일 뿐이다.
그런데,

blepro(pr/□/gm_tbrm, "■")는 그저
blepro(pr/(.*?)/gm, "\x55$1", pr/(?<blep_tbrm> (?<b0> \<blep>)(?<b1> \<blep>)(?<b2> \<blep>)(?<b3> \<blep>)(?<b4> \<blep>)(?<b5> \<blep>)(?<b6> \<blep>)(?<b7> \<blep>))□/gm, "■")로 컴파일될 뿐이야,
blepro(pr/□/gm, "■", pr/○/gm, "●")(x)는 blepro(pr/○/gm, "●")(blepro(pr/□/gm, "■")(x))와 작동이 동일하고.

그래서 `${}`를 callout으로 컴파일하는 C버전이 더 빠른거야. ?C0, ?C1가 각각 blepro문자열 합성과, blepro검사 페턴으로 활용되고, ?C2+즉, 2 이상부터는, 유저가 명시한 callout에 연결하는 구조지.

blepro는 그 유저가 명시할 callout이 ?C2, ?C3, ?C4, ?C5, ?C6인데,

typeded struct {
    char holder;
    void* chennel;
    char* io;
    char* io_curser;
    uint32 flag; (terminal (stdio • stderr • argument & exit • file I/O 등등))
} user_data;
에서, callout에 void* user_data부분에 캐스팅할 타입 구조체로 정해져 있는데,
?C6은 chennel과 uint32flag와 io문자열, io_curser를 설정해주는 역할, 

?C2 : sprintf나 printf나 파일작성이나 등등, flag를 확인해서, 적절한 출력을, buffer용도로 마련한 캡쳐그룹의 값으로 출력
?C3 : getchar하여 holder에 넣음. 만약 입출력이 터미널 입출력이 아니라면, io에서 읽고, io_curser를 증가한다.
?C4 : holder가 개행이면 tbrm을 복사한 buffer를 문자 "1"으로, 아니면 문자 "0"으로 만들어준다.
?C5 : buffer캡쳐 그룹의 마지막 문자를 holder값으로 치환한다.

이 과정은, blepro_c_env라는 blep의 서브루틴으로 이루어진다.
혹시, input하는 행위를 했다면, tbrm을 킬수밖에...

(?<buffer> \k<blep_tbrm>)라는 짓을 하거나, (?<buffer> \k<blep_tbrm>\k<blep_tbrm>)을 하거나, 해서 buffer를 편집 가능하다.

입력 알고리즘은 예를들어 "c\n"를 입력했다고 치면,

1. blepro_c_env_input_req가 문자열 "0"이 아니고, blepro_c_env_input_flag가 문자열 "0"이므로, blepro_c_env_input_buffer에 공문자열을 할당 (즉, 조건문)
2. blepro_c_env_input_req가 문자열 "0"이 아니고, blepro_c_env_input_flag가 문자열 "0"이므로, blepro_c_env_input_req가 문자열 "0"이 되도록 함 (즉, (0|1))
3. blepro_c_env_input_flag가 문자열 "1"이 되도록 함.
4. ?C3이후, ?C4를 하여, blepro_c_env_input_req를, ?C4의 결괏값으로 만듬
5. blepro_c_env_input가 다시 호출됨. (즉, 2~5은 조건문)
6. blepro_c_env_input_req가 문자열 "0"이고, blepro_c_env_input_flag가 문자열 "1"이므로, \k<blepro_c_env_input_buffer>\k<blep_tbrm>을 blepro_c_env_input_buffer에 할당 (즉, 조건문)
7. blepro_c_env_input_req가 문자열 "0"인데, blepro_c_env_input_flag가 문자열 "1"이므로, ?C5를 하여, blepro_c_env_input_buffer의 마지막을 ?C5의 결과로 함
8. ?C3이후, ?C4를 하여, blepro_c_env_input_req를, ?C4의 결괏값으로 만듬
9. blepro_c_env_input가 다시 호출됨. (즉, 7~9는 조건문)
10. blepro_c_env_input_req가 "1"이고, blepro_c_env_input_flag가 "1"이므로, blepro_c_env_input_buffer에 공문자열을 할당 (즉, 조건문)
11. blepro_c_env_input_req가 "1"이고, blepro_c_env_input_flag가 "1"이므로, \k<blepro_c_env_input_buffer>를 현재 캡쳐 그룹의 값으로 정함.
12. blepro_c_env_input_flag를 문자열 "0"으로 변경

이런식의 사실상 PCRE기반 프로그래밍이고, blep은 데이터를 만들고 처리하는 부분에 쓰임을 알 수 있다.

blepro_c_env_input_init그룹은 초기에 "0"으로 설정되어있는데, 그상태로 blepro_c_env_input을 실행하면, blepro_c_env_input_init를 "1"로 설정한 후, blepro_c_env_input의 각 플래그를 재대로 설정해준다.

사실은 해당 callout은 체널 분기를 하는 전문적인 함수를 추가로 사용하기에, ?C7과 그 이후는 정의되지 않고, 컴파일러 설정용 헤더에서, 어떻게 그 전문 함수를 적느냐에 달려있다.

## 제작 가능한 라이브러리

1. pragma lib
2. 기타 여러 C/C++용 라이브러리

등등 여러 응용 가능

### 1. pragma lib

1. apkg_pragma_lib_fw는 apkg파일을 pragma_lib으로 만들어주는 fw이자 apkg_pragma_lib_fw언어에서 apkg로 가는 컴파일러.
2. apkg_pramga는 이미 소개한 바 있음
3. llux (low-level union eXtension)는 "#pragma llux register"라고 적은 다음줄에 오는 union에 대해, uintptr_t타입의 llux라는 변수를 무조건 포함할 것을 요구하고 (아니면 에러), 다른 멤버변수가 T타입의 변수병 □라면, 그걸 등록해서, 나중에 "#pragma llux use"라고 선언한 뒤에 오는 inline함수에서, register한 union의 llux이외의 맴버 변수를 불어오는 코드를 단지 return만 하는 inline함수가 존재할것을 강제하고 (아니면 애러), 해당 맴버 변수명 □과, union변수명 ■에 대하여, "■.□"를 "(T) ■.llux"로 컴파일 해준다. 참고로, union안에 struct가 있었을 경우, ○_inner_struct_○라고 union명에 inner_struct라는 명칭과 몇번째인지 숫자를 다른 typedef로 이미 정의한거고, 또한, 함수 타입을 줬다면, ○_inner_function_ptr_○를, union을 더 주면 ○_inner_union_○를, 배열이면 ○_inner_array_○를 지정한다.
4. HMNL(Hindly-Miller Native Lambda) : HennaCPP/C/C++중 뭔지 __cplusplus__의 정의 여부로 찾아서 실행하긴 하는데... 이게, "[inline같은 지시자] lambda"나, "[캡쳐영역] lambda"라고 적은 부분에 대해서, 해당 lambda문을 Hindly-Miller를 이용하여, C++ auto나 다형성으로 변환하거나, C/C++타입에 대응시키고, Haskell처럼 `::□ -> □`식으로 타입을 명시하거나, `::<탬플릿 인자> => □ -> □`식으로도 명시 가능하며, "lambda struct"라는 구문으로 정의된 타입은, 가상 타입인데, 람다의 인자로, register키워드를 달아도 되는 맴버변수성 등, 사실상 인자를 struct식으로 명시한 문법설탕에 불과하고, 실제로 다인자를 주면, 커링이랍시고, 해당 방식으로 진행된다. 또한, 이것은 class나 struct의 맴버 함수로도 설정 가능하고, 그경우 this를 명시적으로 받아야 하며, class나 struct의 맴버 함수인 경우, 그 메소드로써, lambda를 적절히 컴파일한다. 아예 "macro inline"이라는 키워드로 존나 지원하는 레벨.
5. HennaCPP이라는 언어는 템플릿 메타 프로그래밍은 정상 지원하는데, OOP에 있어서, static class로, 함수가 static이라, self라는 이름으로 구조체를 받는다. 그리고, 그 클래스는, 네임스페이스와, 구조체로 바뀌터 컴파일되는데, 해당 구조체의 함수는 없지만, 접근할시, 해당 클래스를 의미하는 네임스페이스의 함수로 접근되는 방식으로 코딩된다.
6. HennaLambda라는 언어는, HennaCPP의 함수 호출을 CPS(Continuation-Passing Style)같이, 메서드간의 호출로 처리하고, 클래스의 상속으로 import를 하는 방식이고, HennaCPP을 지원하는 HMNL을 이용하여 HMNL은 아니지만 유사한 람다를 짜고, mutable한 자료형의 조작을 모나드로 표현한 식을, henna cpp에서 모나드 없이 그냥 자료형을 조작하는 식으로 컴파일하기에 0 cost abstaction이며, introduce_value_assignment라는 구문을 new로 쓰는데, 새로운 기호에 대한 저장공간을 할당받아, 모델론적 기표에 기의를 값-배정한다는 뜻이며, proof_elimination_value_assignment_thorem_satisfied라는 기호를 delete로 쓰는데, 이는 더이상 해당 모델론적 기표를 쓰지 않으면, 없는거나 다름없다는 증명에서, 전건인 "더이상 해당 모델론적 기표를 쓰지 않는 상황"임을 증명했다는 뜻의 기호로, 이 이후에도 동일 명칭으로 사용하면, 논리적 오류라며 오류를 내준다. 또한, let [□ := ■] in { 코드 }로, 아예 new와 delete의 스코프를 정할수 있는데, 이를 통해서 그냥, 여러번 `□`를 같은 이름으로 쓰는 방법도 있다.
7. Ablepragma : #pramga ablepragma를 통해서

````c
#pramga ablepragma "라이브러리명"
```ablepro
코드
```
````

를 해당 라이브러리 위치에, ablepro를 C나 LLVM AOT로 컴파일한 라이브러리를 저장하여 include가능하게 하는 기능이다. ablepro를 아예 C에서 쓰려는 아이디어.

### 기타 여러 C/C++용 라이브러리

8. Unbeauty라는 언어는 수식으로 프로그래밍하는데, Template Meta Programming이나 constexpr을 즐기는 HennaCpp/HennaLambda 기반이다. 에초에, CCU기반으로, 전환도 가능하다. CCU는 타입을 작성하기 좋게 해주니.
9. CCU(C/C++ Unique-style)은 C/C++의 타입의 메모리상 다이어그램을, 모든 변수 • 타입에 대하여 아스키아트마냥 그리는 문법을 가지며, HMNL로, 함수를 표현한다. 그리고, 여러가지 C/C++의 OS관련 복잡한 용어를, 단순한 비유 용어로 바꾸는 zero-cost abstract라고도 하기 뭐한 방식으로, 메모리 중심으로 컴퓨터 구조론을 푼다. HennaCpp이랑 연계도 제공한다.

#### Unbeauty

Unbeauty : 내가 고1때 개발을 시작했다가, 중단된 프로젝트)

````markdown
# unbeauty

unbeauty esolang (0⁰=1, x->0 x^x->1)

mathmatics.... beautiful 4 me....

`sementically-recursive-defined-recurrence-formular based` programming language

actually, I didn't finished this work, because of my high school exam.
~~Fucking Korea~~

## example

[tip (lang=ko)](https://FarAway6834.github.io/LAFTF1.1)

noptlib.unbe
```unbeauty
sqrt = cacher[1](λx. x^0.5)
abs = cacher[1](λx. this.sqrt(x^2))
partial_beq0c = cacher[1](λx, n, p. ((0^this.abs(n)) + n×(x + ((-1)^p)×n) ÷ (0^this.abs(n) + n^2)) × f(x, n - 1, p))
partial_beq0 = cacer(λb, x, p. this.partial_beq0(x, 2^b - p, p))
beq0 = cacher[1](λb, x. this.partial_beq0(b, x, 0) × this.partial_beq0(b, x, 1)
beq = cacher[1](λb, x, y. this.beq0(b, this.abs(x - y)))
dose_it_positive = cacher[1](λb, x. this.beq0(b, this.abs(b, x - this.abs(x))))
__cmp__ = cacher[1](λb, x. this.beq(b, x) + (-1)^(this.dose_it_positive(b, x)+1))
__le__ = cacher[1](λb, x, y. this.dose_it_positive(b, x - y))

conditionalidx = cacher[1](λp,x,y.p×(x-y)+y)
conditional = cacher[1](λp, x, y. p×x + (1-p)×y)
_4bit_eqer_ = cacher[1](λx,y.this.beq(4,x,y))
_4bit_idxer = cacher[1](λi,a0,a1,a2,a3,a4,a5,a6,a8,a9,aA,aB,aC,aD,aE,aF.this._4bit_eqer_(i,0)×a0+this._4bit_eqer_(i,1)×a1+this._4bit_eqer_(i,2)×a2+this._4bit_eqer_(i,3)×a3+this._4bit_eqer_(i,4)×a4+this._4bit_eqer_(i,5)×a5+this._4bit_eqer_(i,6)×a6+this._4bit_eqer_(i,7)×a7+this._4bit_eqer_(i,8)×a8+this._4bit_eqer_(i,9)×a9+this._4bit_eqer_(i,10)×aA+this._4bit_eqer_(i,11)×aB+this._4bit_eqer_(i,12)×aC+this._4bit_eqer_(i,13)×aD+this._4bit_eqer_(i,14)×aE+this._4bit_eqer_(i,15)×aF)

not = cacher[1](λx.1-x)
and = cacher[1](λx,y.x×y)
sor = cacher[1](λs,x,y.x+y-(1+s)*this.and(x, y))
or = cacher[1](λx,y.this.sor(0,x,y))
xor = cacher[1](λx,y.this.sor(1,x,y))
nand = cacher[1](λx,y.this.not(this.and(x,y)))
nor = cacher[1](λx,y.this.not(this.or(x,y)))
nxor = cacher[1](λx,y.this.not(this.xor(x,y)))
sub =  cacher[1](λx,y.this.and(x,this.not(y)))
rsub = cacher[1](λx,y.this.sub(y,x))
rimp = cacher[1](λx,y.this.not(this.rsub(x,y)))
imp = cacher[1](λx,y.this.not(this.sub(x,y)))
a = cacher[1](λx,y.x)
b = cacher[1](λx,y.y)
nota = cacher[1](λx,y.this.not(x))
notb = cacher[1](λx,y.this.not(y))
logicalerr = cacher[1](λx,y.0)
alwaystruth = cacher[1](λx,y.1)
lpu = cacher[1](λcod,x,y.this._4bit_idxer(cod,this.logicalerr(x,y), this.and(x,y), this.sub(x,y), this.b(x,y), this.rsub(x,y), this.a(x,y), this.xor(x,y), this.or(x,y), this.nor(x,y), this.nxor(x,y), this.nota(x,y), this.rimp(x,y), this.notb(x,y), this.imp(x,y), this.nand(x,y), this.alwaystruth(x,y)))

__gt__ = cacher[1](λb, x, y. this.not(this.__le__(b, x, y)))
__lt__ = cacher[1](λb, x, y. this.__gt__(b, y, x))
__ge__ = cacher[1](λb, x, y. this.__le__(b, y, x))

__ne__ = cacher[1](λb, x, y. this.not(this.beq(b, x, y)))
bits2bool = cacher[1](λb, x. this.not(this.beq0(b,,x)))

shr = cacher[1](λx, n.x÷(2^n))
shl = cacher[1](λb, x, n.(2^b)×x-(2^b)×(x÷(2^(b-n))))
idx = cacher[1](λb, x,i.this.shr(this.shl(b, x, i), b))
_bpucc_ = cacher[1](λb, cod,i,x,y.this.lpu(cod, this.idx)(b, x, i), this.idx)(b, y, i)) × (2^i))
_bpuc_ = cacher[1](λb, cod,i,x,y.this._bpucc_(b, i,x,y) + this.bits2bool(i)×this._bpuc_(b,i-1,x,y))
bpu = cacher[1](λb,cod,x,y.this._bpuc_(b,cod,b-1,x,y))
```

ex2.ubt - extend not base cls, ex1 cls.
```
:noptlib
fibo = cacher[1](λb, x.this.conditional(this.beq0(b, x), 0, this.conditionalidx(this.beq(b, x, 1), 1, this.fibo(b, x - 1) + this.fibo(b, x - 2))))
```

## [coding plan 24.02.24 ~ ...](./plan)

### compile time lazy evil optimizing

`[○×]this.__NAME__(□)` -> `([○×]this.__NAME__)(□)`

 > also as `conditional` too. (when function is in arguemnt, not return, make lazy)

(when mulitypling and when arguemnt value)

## FUOIR Unbeauty Optimize IR

example.unbe
```unbeauty
temp = cacher[0](λx. 2 × x)
main = cacher[0](λx. this.temp(x) + 1)
```

example.auty (jsonic)
```fuior
[
	0,
	"x",
	"this.temp(x) + 1",
	{
		"temp" : [0, "x", "2 × x"],
	}
]
```

### plan change

not using macro, will use PCRE

#### symopt

just add optimizer at ir,
that sympy optimizer.

`this.□(○)` -> `base64(hash(□(○)))` to symbolize (like-lexing)
````

Linear Unbeauty : Numpy + Numba & tensorflow 등이 사용될것으로 추정 )

```markdown
# LinearUnbeauty 계획

선형대수를 지원하는 [Unbeauty](https://faraway6834.github.io/unbeauty)

... 가 끝임
```

labare : 내가 고1때 기획한, 증명보조기 언어 (이때는 꾀나 플라톤주의적인 이과 감성에 타락해 있었음. 저런 찬양하는 시를 지금은 싫어함) )

```markdown
# labare 언어 계획

[Linear Unbeauty](https://faraway6834.github.io/unbeauty/privateNote/Proof/LinearUnbeauty)의 확장이며, 람다 산술이 지원된다.
구체적 구현은 미룰 예정이며,
성능대신 생산성이 높아보이는데, 실제로는 내 성격상 성능쪽으로 갈것같다.

형식증명에 쓰일 언어이다.

행렬 입력 / 반환을 언커링된 Input / Output으로 처리하는, Subrootine Realationship이라는 종류의 연산이 있다만, 실제로는 흉내만 내고, 아무짓도 안한다.

Proofmood 모드에서만 쓰는 기능이다

## 명칭 [유래](https://genius.com/Edna-st-vincent-millay-euclid-alone-has-looked-on-beauty-bare-annotated)

음...
```

unbare : 내가 고1때 기획한, 증명보조기 언어 2)

```markdown
# unbare 언어 계획

형식증명용 언어이다.

실행 목적이 아닌 [labare](https://faraway6834.github.io/unbeauty/privateNote/Proof/labare)코드를 뱉는 용도이다.

output laber code의 구조 :
 - virtual pararel scadular
 - calculatible part
     - pararel scadular
     - haltible part
     - outof haltible part
 - uncalculatible part

그러니까, 수학적인 Subrootine-Relationship 코드를 만드는게 목적이다.
```

alkalic : 증명 대상인 수학 체계)

````markdown
# Alalic Preview

이걸 아주 아주 잘 발전시킬거임, 깃헙 커밋으로 ㄱㄱ

거의 됬네 기분좋다.

## DEFINIRION : Alkalic : Alkalic Linear-algebra + Königsberg Axiom + Lambda Incoding Calculate (구문론적 문제로 lambda형식만 유지하고, 폐지, 람다 지분은 없음)

### Alkalic Algbra

∀x (각각 유일)∃!n(x) s.t. n = ObjectID(x) ∈ Scala

 - AlkalicVectorSpace = Scalaᵗ [t := |Scala|]
 - AlkalicMetrixSpace = AlkalicVectorSpaceᵗ [t := |Scala|]
 - SetTheorem ∈ AlkalicMetrixSpace
 - Notation Definition m ∈ n ≡ SetTheoremₒᵢ₍ₘ₎ₒᵢ₍ₙ₎ [oi := ObjectID]

Alkalraum은 여기서, Scala가 객체의 집합으로 확장되어서, |Scala| = κ가 된다.

### Lambda Including Calculate (구문론적 문제로 lambda형식만 유지하고, 폐지, 람다 지분은 없음)

Alkalic Algbra서 AlkalicVectorSpace나 oidfield = Σᵢ ObjectID eᵢ에 대해, 입력받는 Tensor입력으로 ~~람다~~, 대수함수, Alkalic Algbra서 다가함수를 포함한 함수 구현.

---

폐지되었기 때문에

람다를 아예 삭제해서, 람다가 아닌 걍 연산 과정인 Subrootine으로 바꿨다.

Alkalic Algbra서 AlkalicVectorSpace나 oidfield = Σᵢ ObjectID eᵢ에 대해, 입력받는 Tensor입력으로 대수함수, Alkalic Algbra서 다가함수를 포함한 함수 구현.

하는 체계로 바뀜.

연산 괴정이다.

모든 미지수는 이 람다 체계에서 함수 내부변항으로 고정되어서, 두 함수의 합성에서 초기화되어 창출되거나, 아니면 인자로 된다. 따라서, 어떤 수학 이론은 인자를 가지며, 모델이나 진리값배정은 그 값을 넣는다. (어떻게든 대입됨)

변항은 이론에 인자로 설명 가능

### Königsberg Axiom, VectorAxiom, InaccessibleCardinalExistanceAxiom

⊢ KönigsbergAxiom(x, y, Φ) := (x = y → (Φ ↔ (Φ [x := y])))

이때 [x := y]는 단순히 의미론적 대입 연산자.

⊢ VectorAxiom : "모든 벡터 공간은 기저를 가진다"

다음 글을 읽어 보라.
```
먼저 중위표기결합자 * 에 대해, 다음과 같은 표기법을 도입한다, (*x)(y) ≡ y * x
f(x) ≡ (∈x)라고 공역이 치역으로 정의된 f와 g(x) ≡ (=x)라고 공역이 치역으로 정의된 g를 정의하겠다, 이떄, f와 g의 전사함수임이 당연하며, `≡`는 구문론적 등호다, 참고로 정의역은 집합임으로, 해당 집합이 존재해야 들어갈 수 있다, 또한 f와 g는 표기법이기 때문에, 실제 대수적 객체가 아니며, x ∈ f⁻¹(Φ)가 Φ(x)임은 당연하다, 참고로 공역을 치역으로 정의했다는 뜻은, 저 표기법이 표기하는 수학적 객체의 집합은 저 표기법이 표기하는 수학적 객체의 집합이지, 표기법에서 따로 정의하지 않기에, 최소한의 응용이 아닌 공역이 치역이 되지 않는 큰 응용을 하는것을 형식 언어 형식 문법 수준에서 금지한다고 하는것이다. (당연하다고 말한 내용들은 정의가 아니다, 태클을 걸수 있다.), 마지막으로 h̅는 h의 진리값배정이다. 진리값배정을 뜻하는 표기법이다.
외연 공리(Axiom of Extensionality)와 같은뜻인 명제를 보자, `(∀A∀B)(((x∈A) = (x∈B)) → (A = B))` ≡ `(∀A∀B)((f(A) = f(B)) → (A = B))`이기에, 외연공리는 f가 (전)단사함수임과 동치로, 외연 공리에 따라, 외연공리꼴의 다른 표현인 `f가 (전)단사함수이다`는건 외연 공리가 참일떄 참이다.
외연 공리가 의미하는 바는, 외연 공리가 만족되는 조건은, f가 일대일대응으로 동작하도록 정의된것과 같다,
따라서, 지금부터 f는 외연공리를 만족하는 f인 F로 재정의된다, F⁻¹도 외연 공리를 만족하는 f⁻¹과 같음이, f에 대한 F의 정의상 당연하다

짝 공리(Axiom of Pairing)와 같은뜻인 명제를 보자, ∃{A, B} = ∃{x | (x=A)∨(x=B)}인데 (x=A)∨(x=B) ≡ g(A)(x)∨g(B)(x) = (g(A)∨g(B))(x)로, ∃{A, B} = ∃{x | (x=A)∨(x=B)} = ∃{x | (g(A)∨g(B))(x)}이고, ∃{A, B} f({A, B})(x) = f({x | (g(A)∨g(B))(x)})(x) = (g(A)∨g(B))(x)으로, ∃{A, B}  f({A, B}) = g(A)∨g(B)이기에, {A, B} = f⁻¹(g(A)∨g(B))에서, ∃f⁻¹(g(A)∨g(B))가 짝 공리와 동치로, 짝 공리에 따라, 짝 공리의 다른 표현 `∃f⁻¹(g(A)∨g(B))`은 짝  보장될때, 항진이다.
합집합 공리(Axiom of Union)와 같은뜻인 명제를 보자, ∃{x | (x∈A)∨(x∈B)} ≡ ∃{x | f(A)(x)∨f(B)(x)} = ∃{x | (f(A)∨f(B))(x)}에서, ∃{x | (x∈A)∨(x∈B)} f({x | (x∈A)∨(x∈B)})(x) = f({x | (f(A)∨f(B))(x)}) = (f(A)∨f(B))(x)이므로, ∃{x | (x∈A)∨(x∈B)} f({x | (x∈A)∨(x∈B)}) = (f(A)∨f(B))서, ∃f⁻¹(f(A)∨f(B))임이 합집합 공리와 같은 뜻이고, 합집합 공리에 따라, 합집합 공리의 다른 표현 `∃f⁻¹(f(A)∨f(B))`은 합집합 공리가 보장될때, 항진이다.
이때, 합집합 공리과 짝 공리가 다 참이라는 "합집합 공리와 짝 공리가 보장됨 공리"라는 공리를 세우겠다, 이 공리는 합집합 공리는 합집합 공리의 논리식 표현 p와 짝 공리의 논리식 표현 q에 대해 p와 q가 항진이라는 뜻으로 정의된다. 합집합 공리와 짝 공리가 보장됨 공리와 같은 명제를 보자, "합집합 공리와 짝 공리가 보장됨 공리" = "`∃f⁻¹(g(A)∨g(B))`와, `∃f⁻¹(f(A)∨f(B))`임이 보장됨 공리" = "`∃f⁻¹(g(A)∨g(B)), ∃f⁻¹(f(A)∨f(B))`"으로, , 이는, h̅ = (f, g) ⊨ (∃f⁻¹(h(A)∧h(B)))과 같으므로, 우리가 가정한 "합집합 공리와 짝 공리가 보장됨 공리"에 대해 "합집합 공리와 짝 공리가 보장됨 공리"에 따라, "합집합 공리와 짝 공리가 보장됨 공리"의 다른 표현인 `h̅ = (f, g) ⊨ (∃f⁻¹(h(A)∨h(B)))`는 "합집합 공리와 짝 공리가 보장됨 공리"가 참일때 참이다.
멱집합 공리(Axiom of Power Set)는 멱집합의 존재성을 보장한다.

사실 이는 f가 아닌 F에서도 동일하기에, "합집합 공리와 짝 공리가 보장됨 공리"는 외연공리가 성립하는 F에 대해서 다룰수 있다면, "`h̅ = (F, g) ⊨ (∃F⁻¹(h(A)∨h(B)))`"이다.

치환 공리꼴(Axiom Schema of Replacement)의 다른 표현을 보자, 치환 공리꼴이란 무엇일까? 한마디로 치환 공리꼴은 함수 h에 대해, {h(x) | x ∈ A}의 존재성은 A가 존재해야 보장돼야한다는것이다. 한마디로, ∃A ⇒ ∃{h(x) | x ∈ A}이다. 이때, f({h(x) | x ∈ A})(x) = (∃v ∈ A)((h(v) =)(x)) = ((∃v ∈ A)(h(v) =))(x) 이므로, {h(x) | x ∈ A} = f⁻¹(((∃v ∈ A)(h(v) =)))에서, ∃A ⇒ ∃f⁻¹(((∃v ∈ A)(h(v) =)))임이 치환 공리꼴과 동치이다, 따라서, 치환 공리꼴에 따라 치환 공리꼴의 다른 표현 `∃A ⇒ ∃f⁻¹(((∃v ∈ A)(h(v) =)))`은 치환 공리꼴이 보장될때 항진이다.

치환 공리꼴도 f가 아닌 F에서도 동일하기에, 외연공리가 성립하는 F에 대해서 다룰수 있다면 "∃A ⇒ ∃F⁻¹(((∃v ∈ A)(h(v) =)))"이다.

분류 공리꼴(Axiom Schema of Separation/Specification)은 성질 Φ를 만족하는 부분집합이 존재한다는거다, 성질 Φ를 만족하는 부분집합이 존재한다는뜻은 ∀S ∃{x |(Φ(x)) ∧ (x∈S)}이며, ∀S ∃{x |(Φ(x)) ∧ (x∈S)} ≡ ∀S ∃{x |(Φ(x)) ∧ f(S)(x)}이고, ∀S ∃{x |(Φ(x)) ∧ f(S)(x)}라는건 ∀S ∃f(P) = Φ∧f(S)임과 동치이기에, 분류공리꼴에 따라 분류공리꼴의 다른 표현 `f(P) = Φ∧f(S)`은 분류 공리꼴이 보장될때 항진이다, 이후에 분류 공리꼴을 이용하여 집합론에 대해 논하겠다.

ZF안에 ZF를 만든다고 가정하면, 범주론적으로(함자에 대한 서술로) 접근할때, "∃A ⇒ ∃F⁻¹(((∃v ∈ A)(h(v) =)))"안에서 "h̅ = (f, g) ⊨ (∃f⁻¹(h(A)∨h(B)))", "∃A ⇒ ∃F⁻¹(((∃v ∈ A)(h(v) =)))"가 성립한다, 그러나 이것은 ZF내의 ZF에서만 성립한다. `"메타언어가 서술하는 "내부언어에 관한" 구문"`꼴이기 때문이다.

따라서,
ℙ1 : "∃A ⇒ ∃F⁻¹(((∃v ∈ A)(h(v) =)))"
ℙ2 : "h̅ = (f, g) ⊨ (∃f⁻¹(h(A)∨h(B)))"
를 따로 정의하겠다.

공집합 공리(Axiom of Empty Set)와 같은뜻인 명제를 보자, `(∃S ∀x)(￢(x∈S))` ≡ `(∃S ∀x)(￢f(S)(x))` 이고 `(∃S ∀x)(￢f(S)(x))`와 같은뜻인 명제 `(∃S ∀x)(f(S)(x) = F)`는 `x⊥y = x⊥ = ⊥y = ⊥ = F`인 `⊥`정의에따라서, `(∃S)(f(S) = ⊥)`임과 동치이다, 즉, `∃f⁻¹(⊥)`은 공집합공리와 동치이기에, 공집합 공리에 따라, 공집합 공리의 다른 표현 `∃f⁻¹(⊥)`은 공집합 공리가 보장될때, 항진이다.
무한 공리 (Axiom of Infinity)는 자연수 집합의 존재성을 보장하는 공리이다. "모든 자연수 x에 대해, (∃ℕ)(f(ℕ)(x))"는 무한공리와 같다,

정칙 공리 (Axiom of Regularity / Foundation)는 랭크 함수 Rank의 존재성을 보장한다.

이때, 무한 유향 비순환 가중 그래프 preZFSetThoeremModel에 대한 중복도 W를 정의하고, W(x, y) := int(x ∈ y)로 정의하면, (또한, 동시에, 멱집합의 존재도 보장하여 구성하면,)

멤버십 관계 ∈는 분류 공리꼴을 이용하여, 다음과 같이 재정의된다 ((x ∈ y) s.t. (x ∈ y) when (h(x) = Φ(x))) := F(y)(x) s.t. (∀P ∈ 2ᴬ)(F(P) = h(P)∧F(A)) (단. F는 가능한 한 전단사인 표기법이며, 현제의 정의에서 (∃h(P), F(A) ⇒ ∃(x ∈ y)라고 치역이 정의된다)
이는 분류 공리꼴을 만족시키는 정의이다.

preZFSetThoeremModel들 중에서, ℙ1, ℙ2를 만족시키는 preZFSetThoeremModel를 ZFSetThoeremModel라 할수 있는데, 이들 중 공집합과 자연수를 이론 내부에서 논하는 집합으로 가지는 ZFSetThoeremModel는 메타 언어로 동작할 수 있고, ℙ1를 만족시키는 preZFSetThoeremModel들 중에서 공집합과 자연수를 가지는 preZFSetThoeremModel는 ZFSetThoeremModel와 위계 이외엔 동등하다.

더 나아가서, 상수로써 자연수와 공집합을 가지고, 멱집합 연산과 ℙ1, ℙ2를 구성하는 연산이 정의되는 튜링 언어를 이용하는 형식문법 G 문법의 형식언어 L의 모델은 preZFSetThoeremModel이다. 따라서 FOL에서 HOL로 확장가능한 대수공리계에서 모델론과 구문론과 집합론과 논리까지 싹다 서술 가능하다면, preZFSetThoeremModel도 서술 가능하므로, 그런 대수공리계는 ZF와 동등하다. (이러한 모델의 존재성이 참이 된다는 전제하에)
```

저러한 대수 공리계는 존재한다, 예컨데 alkalic이 그렇다.

Königsberg Axiom은 alkalic을 구성하여, 저 조건을 만족한다. 따라서 ZF공리계와 Königsberg Axiom체제 (25.07.16 커밋 이전)는 ZFC랑 그 능력이 동등하다. (상호 서술)

VectorAxiom은 AC와 동치이다, 따라서 Königsberg Axiom + VectorAxiom은 ZFC와 동등하다. (상호 서술)

이때 다음 공리를 도입하자, 아래 공리계는 Alkalic-LinearAlgebra의 ZFC로 구성되었다
⊢ InaccessibleCardinalExistanceAxiom : ∃κ cf(κ) = κ ∧ κ > ℵ₀ ∀λ<κ, 2^λ < κ [cf(x) := least δ ∈ Ord s.t. ∃f : δ → x, (∀i < δ)(f(i) < x) ∧ (∀α < x)(∃i < δ)(α < f(i))]

이때 κ가 Alkalraum의 구성에 쓰인다.

Alkalraum은 κ로 그 크기가 확장된 Alkalic-LinearAlgebra의 객체를 Scala에 포함하는 Hilbertraum같은 (((Scala^κ)^κ)^....)^κ식으로 구성된 κ Rank Covector공간이며, 복소수나 분발복소수/이원수나 2ⁿ원수 등의 행렬표현에서 그 원래 집합의 원소 역할을 하는 객체로의 대응된것 등이 있을수 있는 실수 및 함수 및 객체들로 된 선형대수 텐서공간인데, κ크기를 보장하기에, Grothendieck 우주가 존재하는 ZFC를 표현할수 있어, 여기서 SetTheorem은 자동으로 Grothendieck 우주가 존재하는 ZFC로, 범주론이 서술된다.

## About

이전에 나온 CSFBAlgebra에서 모델론이 안먹히나 했는데 먹힘, 그래서 아이 새로 CSFBAlgebra를 정리(바꿈), 그게 Alkalic.

M = (ℕ, 0 = ∅, s(x) = x ∪ {x}) 대신

수열의 곱을 다가함수로 써서,

M = Π<ℕ, [0 := ∅], [s := λx. x ∪ {x}]>

같은 서수의 정의가 가능하다는 점에서,

이제 Structure와 변수 대입까지 함수 안에서 됬음.

이제 구조체도 non-structial 논리적 귀결에서 씀으로 쓸수있음

에초에 CSFBAlgebra를 대체할 목적으로 만든거니

나머지는 이하 생략.

### Alkalic-Proofmood

KönigsbergAxiom 에 따라서, 

 > 
 > 규칙 `using x = y → (Φ ↔ (Φ [x := y])))`
 > 
 > 원리 : `x = y → (Φ ↔ (Φ [x := y])))`서 `x = y`가 결론 (5번 라인)과 같음을 보임
 > 
 > ```Alkalic-Proofmood
 > □.1. using x = y → (Φ ↔ (Φ [x := y])))
 > □.2. x = y
 > □.3. Φ
 > □.4. Φ [x := y]
 > □.5. Φ ↔ (Φ [x := y])
 > ```

모든 추론은 규칙 `using x = y → (Φ ↔ (Φ [x := y])))`에서 시작되며, 규칙 `using x = y → (Φ ↔ (Φ [x := y])))`는 기본적으로 modus ponens 추론 규칙을 따르기에 타당 (valid)하다. (심지어 Königsberg Axiom이 항진인데, Königsberg Axiom을 제외하고는 대수 연산밖에 활용하지 않기에, alkalic은 건전하다)

(전건부정의 오류 하나 있어서 삭제함)

내부적으로 결론(5번 라인)이 참일때만 계속 동작함, 또한 결론은 리스트에 쌓이면서, 마지막 줄인 Theorem에 도달할때까지 Lemma가 리스트업되서, 문장이 참인지는 Lemma로 보임.

 > 
 > 규칙 : `Starting Listup Hyperthesis`
 > 
 > 미리 Hyperthesis나열을 시작함
 > 
 > 규칙 : `Quit Listup Hyperthesis`
 > 
 > 더이상 Hyperthesis를 받지 아니함
 > 
 > 규칙 : `Starting Another Subproof`
 > 
 > 새 스택프레임을 만들어, 새로운 부분증명을 시작함
 > 
 > 규칙 : `Quit Another Subproof`
 > 
 > 부분증명을 끝내, Lemma List에 추가하고, 스택프레임을 pop함
 > 
 > 규칙 : `APAristotel-y` (nonHyperVersion 형식증명 only)
 > 
 > HAPA Theorem이라는 외부정리를 이용하여서, y = x이고 y = z이면 x = z임을 보임
 >
 > 규칙 : `APAristotel-z` (nonHyperVersion 형식증명 only)
 > HAPA Theorem이라는 외부정리를 이용하여서, x = z이고 y = z이면 y = x임을 보임
 > 

### HAPA Theorem (Hyper Alkalic-Proofmood Theorem)

Alkalic-Proofmood nonHyperVersion 형식증명의 근거.

동시에 유일한 Alkalic-Proofmood HyperVersion에서의 형식증명

`y = x`, `y = z`가 가설일때,

규칙 `using x = y → (Φ ↔ (Φ [x := y])))`를 통하여, `y = z ↔ x = z`를 보인다, 즉,

문법상, `y = z → (y = z ↔ (y = z [y := x]))` = `y = z ↔ (y = z ↔ x = z)`이므로, 

y = z ↔ (y = z ↔ x = z)를 표현하기 위한 잉여적인 체계다.

(그치만 이전에 있었던 전건부정 오류때문에 또 고쳐야함 ㅠㅠ)

## Alkalic-Proofmood (Power Up - Version)

증명에 앞부분에 붙여야 할 한정사가 추가되었다, 부분증명을 만들어서 중첩 가능하기에, 각 기능을 동시에 붙일수 없다.

 - AristotelProof(비 명시시 기본) : 기존 증명 방식으로 증명
 - DavidHumeProof : Φₜ에 대해, t번 라인마다 매거적 귀납법을 쓰고, 옆 열에는 Φₜ가 귀납법 증명에 쓰이는 경우, 쓰는 칸이 된다. 맨 마지막줄에, 번호 없이, 귀납법 증명의 종류를 기재할때, `∴ Φₜ, Φₜ₊₁, ..., Φₖ ⊨ Φₖ₊₁` (강함), `∴ Φₖ ⊨ Φₖ₊₁` (약함), `∴ Mod(Φ) = ℕ` (일반적인 수학적 귀납법) 으로 기제한다.
 - EuclidianProof : 귀류법 (HegelianProof랑 다르다, 귀류법이다) ; 반증 마지막에, `∴ ⊥ ∴ ⊭ ¬
Φ ∴ Φ`를 놓는다. (`¬Φ`는 결론을 뜻한다.)
 - HegelianProof : 반증 (결론이 부정이 나오므로, "결론이 아니다"를 증명할때 쓰임; 왜냐하면, 기존 버전에서는 논리적 오류가 나오면 오류위치를 지적하고 프로그램이 종료됬기 때문에, 오류를 만들어 반증한 후, 종료하지 않는 AristotelProof가 필요했음)

또한 검증 프로그램 정지를 피하기 위해,

 - PreviewVersion : 이 부분•전체 증명에 대해서, 프로그램 정지 후 오류 지적을 제외하고, Preview리스트에 추가한다, 근거 없는 부분이라, 이걸 단 증명을 참고해서 에러나면, "Referance on Preview"에러 로그를 따로 뱉은 후 평상시 에러처럼 에러난다
 - DebugVersion : 오류가 나는대로, 디버그를 해주며, 훓고 지나간다, **프로그램 전체에 적용된다.**
 - ConjureVersion : 추측으로써, 정지를 피할곳에, `�`를 삽입한다, 이 부분•전체 증명은 가설(Hyperthesis)로 취급된다.
 - NormalVersion (비 명시시 기본) : 기존 방식

마지막으로, 다항식의 계산을 원활하게 하기 위해,

`Polynomial Simplify`라는 부분증명 폼을 넣고 다음을 인수분해하거나, `P(x) = 0`꼴을 풀면 (후자는 미리 `using P(x) = 0 Algorithm`이라고 명시) 오류 없이 증명을 받아들여준다.

A. `LinearSimplify`명령을 통해, LinearSimplify Theorem에 근거하여, 미지수가 여러개인 일차식을 정리한다

B. `Substracting [y := xⁿ]`명령을 통해, xⁿ을 y로 치환한 문장 `Φ`에 대해, `Substracting Variable`필드에 넣은 참인 문장 `y = xⁿ`에 따라서, Φ [y := xⁿ]가 나올때까지, 미리 일차식마냥 치환한 상태로 작업하게 해준다. (치환 변수 필드 논법; `Substracting Variable Field Proofs`)

C. `Solution (a, b, c, d, e)`명령을 통해, 2차 ~ 4차식을 인수분해(근의공식) / 전개(비에트의 정리)한다.

D. `TschirnhausTheoremSubsituate (n, a, b, x)`명령을 통해, `[x := t + b/na]`를 적용한다, 마찬가지로 증명의 원활함을 위해 Substracting명령에 근거한다 (사실 그럴 필요도 없이 구문론적으로 연산자를 정의해도 되는 간단한 문장(`[x := t + b/na]`)이지만)

E. 부분증명 문법에서 `synthetic division` 한정사로, 조립제법 이용 (생략표기가, 매거적 귀납에서 고정된 열의 다수의 행에대해 쓰이므로, 여기서는 쓸때, 행을 다항식으로, 계산 과정순이 열로 되므로, 돌려봐야하는 단점이 있다.)

F. `Alright synthetic division`한정사로, 일반적인 조립제법을 쓰고, 전처리 단계에서 synthetic division로 컴파일

G. 분배법칙을 위해서, `distribute[ 대상 ]` 안에 전부 넣어가지고, 이 증명 시스템용으로 있는 `분배법칙의 일반화 정리`에 따라, 분배함

H. `AlgebraicFormula` : 미리 증명한 곱셈공식을 이용해서, 계산되었음을 명시한다.

I. Gaussian Eimination or ERO & Subsituate : 가우스 소거 혹은 가감/대입

J. System of Quadratic Equations by Quadratic Form : 이차형식으로 연립이차방 풀이

K. System of Quadratic Equations by Cubic Form : 삼차형식으로 연립삼차방 풀이

L. Règle de Cramer : 크래머의 공식으로 풀이

M. `Extraneous Root is (□)` : 무연근 명시

N. `PolynomialFractionize` : 다항함수 분수화

O. `SolvePolynomialFraction` : 해당값 풀이

P. `Fractions Solution is (□)` : 해 명시

### 형식증명의 오토마타용 문법

`□.` 라인이 부분증명이라면, `□.line.`식으로 라인을 표기한다.
그리도, 라인과 라인 사이에 오직 whitespace및 `-`,`–`,`—`만 있을경우 해당 라인을 가독성 용도로 보고 주석처리한다.

또한, line표기에 앞선 점찍은 부분 앞에서 `|`부분이 문자열의 특정 열마다 이어지고, 끝나는 말단이 앞서 설명한 `-`꼴의 주석에 연결되어있다면, 해당 부분도 따로 오류처리하지 않는다.
그외에는, 열 구분자이기에 주석으로 보지 않는다

마지막으로, `[NOTE : ]`형식을 주석으로 본다.

마크다운 문서 내부에 위치했다면, HAlkalic-Proofmood(Hyper Version), Alkalic-Proofmood(일반 버전), PowerAP(Power Up버전)으로 코드 이름인 부분만 읽는다. 또한, 마크다운 부분에 부분증명 코드부분은, 부분증명으로 렌더링한다.

마지막으로 그렇게 html화되어 정리된 렌더링 뷰는, LaTeX 표기 기능을 추가해야만 할것이다.

(그럼에도 해당 html뷰는 아직 형식증명 검토가 안돌아갔으므로, 컴파일 상태인거지, 실행 상태가 아니다. 실행은 실행기에 돌려야, 문서 내부를 파싱해서, 부가적으로 제공된, [labare](https://faraway6834.github.io/unbeauty/privateNote/Proof/labare)•[unbare](https://faraway6834.github.io/unbeauty/privateNote/Proof/unbare) 코드와 함깨 해석하여(labare•unbare는 인터프리터 언어가 아니고, 정형 대이터 겸 사용자 편의 대이터 겸 Low Level 컴파일 언어다.), 검토된다; 이제보니 실행기보다는, 형식증명 검토기라는 명칭이 더 적합하다, 프로그래밍 언어는 하나도 실행하지 않고, 추론규칙을 재대로 활용했는지만 검사하여 검토작업(오류나 로그나 상태 표시)만 하기 때문이다.)

---

### 두번째 글 : `논리적으로 다룬다 전재할때, 대수식은 논리적으로 그 뜻이 해석 • 계산된다.`의 발췌

그렇지 아니하면, 논리적 해석 흐름에서 논리기호가 도출될수가 없다.

식의 계산은 그 값의 배정인 (x̄, f(x̄))와 같이 이루어지는데, 이 방식을 거부하는것은, 논리를 쓰지 않겠다는 말과 같다. (장자 왈 갓나서 죽은 아기보다 오래 산 사람은 없으니 팽조(760살이 넘게 살았다는 전설 상의 신선)도 일찍 요절한 사람)

#### 대수식의 논리적 해석 흐름에서 논리기호를 도출하자

먼저, 다음을 보이겠다

> 함자 `f :≜ (-F)` 를 정의해서, 여기에 대해,

`x = y 이면이 f(x) = f(y)`

이말은, 진리값 T, F를 다루는 식에서, F = 0으로 가정하고 푸는거나, F ≠ 0이 아닐때 푸는거나, 전부 x = y인 등식을 쓸때 f(x) = f(y)가 F와 무관히 동등함이 당연함으로, F = 0인 경우로 잠정적으로 취급하겠음

##### 대수식의 논리적 해석 흐름중 논리적 귀결관계의 도출

Step.1. 방정식을 만족하는 집합으로써의 모델집합이 해집합임을 보이자

먼저, 다음과 같은 다항식 함수 P를 정의하자.

> `P :≜ λA. λx. Πᵢ x - Aᵢ`

그리고 다음과 같은 방정식화 논리함수 Φ를 정의하자.

> `Φ :≜ λf. (f(x) = 0)`

그리고 마지막으로, 다항 방정식 ㅍ을 정의하겠다.

> `ㅍ :≜ φ • P`

그러면,

> `Mod(ㅍ(A)) = {x | x ⊨ (Πᵢ x - Aᵢ = 0)} = {x̄ | Πᵢ x̄ - Aᵢ = 0} = {Aᵢ | ∀i}`

임이 당연하다.

---

Step.2. 논리적 귀결관계의 도출

다항방정식 ㅍ(A), ㅍ(B)에 대해,

0. Mod(ㅍ(A)) ⊆ Mod(ㅍ(B))
1. {Aᵢ | ∀i} ⊆ {Bᵢ | ∀i}
2. ∀i Aᵢ = Bᵢ《주의 : 비약이다, 저건 배열을 정렬해야만 성립한다.》
3. ∃C P(B) = P(A)P(C)
4. P(A)|P(B)

으로,

> 
> 다항식 f, g에 대해 다항방정식 Φ(f) ⊨ Φ(g)
> 
> 이면이
> 
> f | g
>

##### 대수식의 논리적 해석 흐름중 진리값 배정되는 명제논리 결합자의 도출

¬x = T - x로 해석됨을 보이자. (경고 : 형식증명 아님)
A. proof of `x ≠ T ⊢ T ± x ≠ (1 ± 1)T`
0. `x ≠ T` (비 귀류법식 전제 문장)
1. `T ± x ≠ T ± T` (이항 by 함자 `(T ±)`)
2. `T ± x ≠ T ± T = (1 ± 1)T` (1번의 연장선에서 계산)
3. `T ± x ≠ (1 ± 1)T` (2번에서 식 요약) ⋯ ■

B. proof of `⊭ (1 + 1)T = 0 ∨ (1 + 1)T = T`
0. 먼저 part A by `⊭ (1 + 1)T = 0`와 part B bt `⊭ (1 + 1)T = T`로 나눠서 생각하자.
1.A. (1 + 1)T = 0 (귀류법식 전재 문장)
2.A. (1 + 1)T = 2T = 0 (1.A.번의 연장선에서 계산)
3.A. T = 0 ⊨ 2.A. ⊨ (1 + 1)T = 0 (연역)
4.A. ⊭ T = 0 ⊨ 2.A. ⊨ (1 + 1)T = 0 (연역)
5.A. ⊭ (1 + 1)T = 0 (연역) ⋯ ⊥
6.A. ∴ ⊭ (1 + 1)T = 0 (연역) ⋯ ■
1.B. (1 + 1)T = T (귀류법식 전재 문장)
2.B. (1 + 1)T = 2T = T (1.B.번의 연장선에서 계산)
3.B. T = 0 ⊨ 2.A. ⊨ (1 + 1)T = T (연역)
4.B. ⊭ T = 0 ⊨ 2.A. ⊨ (1 + 1)T = T (연역)
5.B. ⊭ (1 + 1)T = T (연역) ⋯ ⊥
6.B. ∴ ⊭ (1 + 1)T = T (연역) ⋯ ■

C.1. A, B ⊨ (x ≠ T ⊢ T - x ≠ (1 - 1)T) (A, B번에서 귀결)
C.2. A, B ⊨ (x ≠ T ⊢ T - x ≠ (1 - 1)T = 0T = 0) (C.1.번의 연장선에서 계산)
C.3. A, B ⊨ (x ≠ T ⊢ T - x ≠ 0)  (C.2.번에서 식 요약)
C.4. A, B ⊨ (T - x = 0 ⊨ x = T ⊨ x) (C.3.번에서 연역추론 : 대우) 《주의 : "x = T"의 의미를 "진리값 x가 참"관점으로 해석함.》
C.5. A, B ⊨ (T - x = 0 ⊨ x) (C.4.번에서 식 요약) 《주의 : 근거인 C.4.에서 "x = T"의 의미를 "진리값 x가 참"관점으로 해석함.》
C.6. C.5.번 내용 ⊢ ¬x = T - x (최종결론)《주의 : "x = T"의 의미를 "진리값 x가 참"관점으로 해석함.》
Q.E.D.

x ∧ y는 xy로 해석됨을 보이자.
T에대한 방정식 (T - x)(T - y) = 0의 해는
x = T ∨ y = T이다.
따라서, x = T ∨ y = T ⊨ T - (T - x)(T - y) = T고,
x ∨ y = T - (T - x)(T - y)로 해석된다.

이때 De Morgan's Law, ¬(¬x ∨ ¬y) = x ∧ y서

T - T + (T - T + x)(T - T + y)
 = xy이다.
 ⋯ Done.

##### 방정식의 의미 : 술어논리(함수논리)의 술어로써, 잠정적으로 특칭양화사를 사용해, 잠재적으로 전칭양화사를 사용함.

방정식 P(x) = 0이 불능이란것은

∄P(x) = 0란 뜻이며

∀P(x) ≠ 0이란 뜻이고 ⋯ ①

방정식 P(x) = 0가 불능이 아니라면

∃P(x) = 0이다. ⋯ ②

방정식 P(x) = 0이 부정이란것은,

부정방정식이므로,

∀P(x) = 0이다. ⋯ ③

①에서, 불능형 방정식 P(x) = 0에 대해,

P(x) ≠ 0은 부정형이고, ⋯ ④

부정형 방정식 P(x) = 0에 대해,

P(x) ≠ 0은 불능형이다 ⋯ ⑤

그렇다면 ③에 따라 다음을 정의하자,

> `Φ :≜ λf. (∃f(x) = 0)`
> 
> `P :≜ λf. (∃f(x) ≠ 0)

그러면 다음을 알수 있다.

④에 따라, Φ(f)가 거짓 이면이 P(f)는 부정형
⑤에 따라, Φ(f)가 부정형 이면이 P(f)는 거짓

Φ(f)가 참 이면이, f(x) = 0를 만족시키는 x존재
P(f)가 참 이면이, f(x) = 0을 불만족시키는 x존재

부정형 방정식을 만들고 싶다? 하면

¬Φ(f) = P(f), Φ(x) = ¬P(f)에서,

불능형 방정식 Φ(f)에 대해 부정하거나,
불능형 방정식 P(f)에 대해 부정하면된다.

술어 P에 대해
Mod(P) = ∅ 이면이 ∄P(x) 이면이 ⊭ P
이면이
Mod(¬P) = U 이면이 ∀¬P(x) 이면이 ⊨ ¬P

따라서, 방정식은 기본적으로 특칭 술어로써, 사용할수 있음
````

## 개발 의도는 유용해 보이는 툴킷을 만든것 뿐. 그것도 작성자인 나한태만 유용함.

사실 이걸 만든놈인인 나는 비전공자고, 대학교를 모델론 전공하기를 지망하는 고등학생이고, 그냥 형식언어 오타쿠일 뿐인 Python 코더지만, 기계어랑 C/C++을 할줄 아는 Cython코더이자, Java/Haskell/perl/PCRE를 할줄 알고 esolang을 만들거나 쓰고, C#이나 JS는 구글링으로만으로도 사용법을 이해하며, 수학은, 선형논리 • 술어논리 • 양자논리 • 양상논리를 알고, 모델론을 가지고 놀며, 형식언어이론을 가지고 노는 학생이기에 제작이 가능했어.
그리고 극단적인 형식주의자이고, 형식언어의 권위나, 절대적인 대상의 정의 가능성에 대해서도, 형식언어용 전문용어가 만들어낸 허구일 가능성을 생각하거나, 사실과 대응하지 않으면, 형이상학적 허구일 가능성을 생각하는 사람이라서, 내 의도를 파악하려고 시도하는건 자제해줘.
그저, 유용해 보이는 툴킷을 만든것 뿐이야.

(사실 실제 개발이 아닌 분야에서 이론적으로 쓰이는 형식논리적인 언어의 특성이 필요했고 LowLevel특성도 있으며 compile과정에 관여 가능하고 PyPI처럼 배포가 용이한 환경이 필요했을 뿐.)

## 여담

배포 환경도 있고, blep으로 PCRE서브루틴 기반 코딩을, 비트 단위로 조작할수 있고, 메모리 할당을 할수 있게 되어, 본격적 문자열 조작과 코딩이 가능하다는 점 • {EVA + CCU(HMNL을 가진다는건, llux도 포함한다는 소리) + Unbeauty&HennaLambda&HennaCpp를 통한 "쉬운 LowLevel" + "이론전산학적 컴파일러용 언어 (dsl로도 활용을 기대할수 있음)" + "수학 (수식 프로그래밍과 henna lambda) 을 저수준으로 접근하는 아이디어; 또한 여기에 PyPI배포를 고려하여, apkg_pragma를 이용하여, python으로 import하는 대신에, "../.."방식으로, 직접 C라이브러리에 엑세스했던 배포는, CPython의 python.h부분이 C를 로드하기 이전 자체로도 C라이브러리의 역할을 톡톡히 함을 의미함. 펙트는 python.h를 include하는 라이브러리가 C부분을 include해서 작동하기에, 다른 apkg라이브러리를 참고할때는, C부분만 include하면 됨. 에초에, apkg/include내는 순수 C고, apkg디렉토리에 python.h를 쓰는 C와 cython이 존재하기 때문.}로 프로그래밍 하는 내가 사용할 프로그래밍 방식을 사용할거라는 점

그냥 이 새가지만 떠올리고 진행하는 개인 프로젝트다.