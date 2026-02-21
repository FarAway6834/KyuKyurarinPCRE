# IO Plan

이전에 `#pragma IO<filename.h>(io)`라고 filename.h라는 KyuKurarin에서 이를 작성하여

 - IO<typename T, iob G> io
 - G io[T channel]
 - for all G ob,
    + CytarrBytes<L> ob.input<L>()
    + ob.output<L>(CytarrBytes<L> data)

인 IO객체를 입출력 함수로 가상화할 생각이라고 했었다.