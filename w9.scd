// 딜레이 사운드 같이 할 수 있는 synthdef

var buf = Buffer.loadDialog();

// 1. 먼저 딜레이 사운드를 만들어보자
(
    var delay = DelayL.ar(
        in: SinOsc.ar(freq: 440, mul: 0.2),
        delaytime: 0.2,
        decaytime: 0.2,
        maxdelaytime: 0.5
    );
    delay.play();
)

// synthdef PlayBuf.ar 에 numChannels는 상수만 들어갈 수 있음.

b = Buffer.loadDialog();
b.play();


(
    SynthDef(\delay, {
        var in = In.ar(0, 2);
        var delay = DelayL.ar(
            in: in,
            delaytime: 0.2,
            decaytime: 0.2,
            maxdelaytime: 0.5
        );
        Out.ar(0, in + delay);
    }).add;
)

// Pbind \dur -> 0하면 에러남.
// Out.ar에 amp 곱하는 거는 효과가 없음!

// Pbind \rate [1,2,3,4,5,6,7] -> 배음 소리
// Pbind
// random 에서 소수점을 적지 않으면 int 사이에서만 왔다갔다함.

// modulation, env 더해야 좀더 고급진 사운드가 되는 듯.
