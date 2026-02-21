# KyuKurarin PCRE : KyuKurarin Bootstrap구현시, 컴파일러 재작용.

perl호환 regex를 CytarrBytes<L>로 구현한다면 역.대.급. 초고속일거라고 생각했다.

## bytes(b-string) • string in KyuKyrarin

 + SlicibleTarr<T, L>은 x.slice(size_t start = 0, size_t end = x::length::value, size_t step = 1)로, x.slice(k), x.slice(0, k), x.slice(0, x::length::value, k)가 정의되어있어서, x.slice(size_t start = 0, size_t end = x::length::value, size_t step = 1)를 y = x.slice(start, end); y.slice(0, y::length::value, step)으로, x.slice(start, end)를 x.slice(0, end).slice(start)로 취급한다.
 + 또한, SlicibleTarr<T, L>은 벡터로 변환 가능하며, SlicibleTarr<T, L> x, SlicibleTarr<T, N> y에 대해, x + y로 concat이 정의된다.

그.러.나.초.고.속.임.

 + SlicibleTarr<T, L>을 immutable하게 관리해주는 wrapper 객체를, CytarrTuple<T, L>(cython에서 T를 object로 명시시  T = PyObject)이라 하고
SlicibleTarr<T*, L>*을 mutable마냥 append나 extend를 해당 포인터의 concat값으로의 치환으로 대체하는 wrapper 객체을 CytarrList<T, L>(cython에서 T를 object로 명시시  T = PyObject)이라 하고(단. SafeCytarrList<T, L>은 SlicibleTarr<T, L>를 new로 할당해놓고, 그 객체는 new에 의한 포인터이므로, 객체 변수들을 mutable마냥 append나 extend를 concat값으로 연산한 결과로, 객체 변수를 업데이트하고, 이전 값이었던 포인터를 지우는 방식으로 작동하는 안전한 리스트. 안전한 이유는, T*의 관리가 아니라서, T*에 간접적으로 접근하면서 Free하지 않아서 안전한게 첫번째, 두번째로, 배열의 각 인덱스가 포인터처럼 다뤄지지 않아서, python list특유의 side-effect를 없엘수 있음)
 + CytarrTuple<char, L>를 bytesarray처럼 관리하는 wrapper 객체를 CytarrBytesArray<L>라 하고 (크으~ char이라 편하다.)
 1 CytarrBytesArray<L>를 bytes처럼 관리하는 wrapper객체를 CytarrBytes<L>라 하겠다. (크으~ 이것도 char이라 편하다.)

요약 : Cytarr은 기본 Collection이 str제외하고 고속화되어있고, pxd로 불러올때, cythonic하게 정적 타입도 가능하며, 무엇보다, bloom-filter나 union-find구현이 용이하며, 해시 맵도 만들기 용이하다. 자료구조 구현이나, perl호환 regex를 cython으로 AOT컴파일하는것도 나쁘지 않겠다.

CytarrBytes를 잘 생각해보면, pcre에 비트레벨 조작기능과 `x ~= s/(.*?)/7$1/g; x ~= 본체`를 추가해서, 이미 캡쳐한 문자를 bit-index값의 조합으로 표시하면, 그걸 C++연산취급해서, 여러가지 문자를 다룰수 있고, `x ~= s/(.*?)/7$1/g; x ~= 본체`로 "0b01010101"을 미리 제공하므로써, 공문자열 입력에도 대처가 용이한 PCRE프로그래밍이 가능할듯하다.

<고속 비트 • 문자열 처리>
 >
 > KyuKurarin PCRE를 다음과 같이 정의함.
 > 
 > + EBNF를 CytarrBytes기반 bitwise조작 •bloom filter•uniom-find를 곁들인 PCRE에 서브루틴 매치패턴으로 컴파일(EBNF비터미널 문자열이 PCRE페턴을 DEFINE한 서브루틴으로 컴파일됨)하는 방식으로 구현하면 으흐흐... 심지어는 EBNF 에러까지도 전•후방 긍정 탐색 등에 걸리면, 플래그 패턴을 정의시키는 식으로 구현 가능하다. 요컨데, ["KyuKurarin PCREBNF"라는 `\{ebnf}`라는 이스케이프로, EBNF코드를 PCRE서브루틴으로 만드는 "언어" 다.](./KyuKyurarinPCREBNF)
 > + 그리고, PCRE substituate • pettern자체를 하나의 서브루틴으로 취급하여, ${서브루틴명}으로 실행까지 가능하다면 금☆상☆첨☆화.
 > + [IO<typename T, iob G> io에 대해, G io[T channel]로 두고, G ob에 대해, CytarrBytes<L> 타입의 ob.input<L>() 및, output<L>(CytarrBytes<L> data); 인 IO객체를 입출력 함수로 가상화해서,  > + `#pragma IO<filename.h>(io)`라고 작성하고, filename.h라는 KyuKurarin에서 이를 지정](./IO)해주면,
 > 1. 평범하게 C의 stdio/stderror/program parameter • exit/pipe massage • process massage • syscall 및 Aduino와의 I/O연동용으로 구현 가능
 > 2. C#과 연계하여, 네이티브 GUI용 입출력과 연계 가능
 > 3. WASM으로 컴파일시 JS와 연계 가능.
 > 4. KyuKurarin을 프로그래밍 언어로 사용
 > 5. 무슨 미친놈의 PCRE 언어가, **서브루틴•제귀가 있고, 분기가 있는** PCRE특성상, 튜링 완전하다.

Note : [Implementation by bootstrapping Kyukyrarin](./Implementation)

N.B. CyTarr은 Cython을 쓰지 않음. python.h를 따로 include해야만 PyObject사용 가능. 즉, 순수 KyuKurarin이고, Cython과 동형이라 CyTarr라고 불릴 뿐.

## Actual Fact

사실 KyuKyurarin PCRE는, 다음 EVA계획의 수정판이다.

[EVA계획](./CancledPlan/EVA)
그리고 EVA계획도, [PCREW](./https://github.com/FarAway6834/PCREW)와 [Pepe](./CancledPlan/Pepe)의 수정이다