# KyuKyurarinPCREBNF

["KyuKurarin PCREBNF"에서 `\{ebnf}`라는 이스케이프로, EBNF코드를 PCRE서브루틴으로 만드는 "언어"를 만들거라고 말했었다.](./..)

그것에 대해서 짧막하게 설명하겠다.

## 구문

```
\{ebnf}
<비단말명 1> := 값 1
<비단말명 2> := 값 2
...

<비단말명 n> := 값 n
<main> := 값
\{ebnf}
```

식으로 되어있는 부분이

```
(?(DEFINE)
    (?<_SYSTEM_WHAT_KyuKyurarinPCREBNF_MANGLING_비단말명 1> 컴파일된 값 1)
    (?<_SYSTEM_WHAT_KyuKyurarinPCREBNF_MANGLING_비단말명 2> 컴파일된 값 2)
    ...
    (?<_SYSTEM_WHAT_KyuKyurarinPCREBNF_MANGLING_비단말명 n> 컴파일된 값 n)
    | (?<_SYSTEM_WHAT_KyuKyurarinPCREBNF_MANGLING_main> 컴파일된 값)
)
```

으로 컴파일되는것 뿐이다.

## 제작

1. KyuKyurarinPCREBNF가 아직 구현되지 않은 KyuKyurarinPCRE로 먼저 구현한다.
2. 가독성과 유지보수를 위해 KyuKyurarinPCREBNF를 포함한 KyuKyurarinPCRE로 제구현한다.