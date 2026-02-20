# Implementation of KyuKurarin PCRE

KyuKurarin구현 이전엔 perl로 구현된 저속 인터프리터로, KyuKurarin PCRE를 돌린다.

KyuKurarin은 구현 초기부터, KyuKurarin PCRE로 짜였으니, 초기에만, [Perl KyuKurarin PCRE interpreter](./PerlKyuKurarinPCREInterpreter)를 Blotstrap용으로 쓰지, 나중엔, KyuKurarin PCRE는 AOT언어다.

그리고, KyuKurarinPCRE는 Perl KyuKurarin PCRE interpreter가 아닌 경우, KyuKurarinPCREibleStr를 통한 고속 검색과, x[x.find(v):x.find(v)+k]를 이용한, 슬라이싱의 이용으로, @FIND라는 데코레이터를 달아놓는 PCRE substituate는 서브루틴 입출력 타입을 KyuKurarinPCREibleStr로 간주한다.
이를 통해서, 쉬운 구현을 만들려는 전략이다.
그래서, Perl KyuKurarin PCRE interpreter가 아니더라도, KyuKurarin PCRE MAD Compiler에서는 오로지 `@FIND`만 인정하는 KyuKurarinLisp컨셉(데스노트)의 노망난 컴파일러가 있다.
KyuKurarin PCRE MAD Compiler는 부트스트랩 컴파일을 위한 특수 구현일 뿐이다.
