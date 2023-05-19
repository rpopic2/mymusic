(
    WhiteNoise.ar(mul: 0.5);
    PinkNoise.ar(mul: 0.5);
    ClipNoise.ar(mul: 0.5); // whitenoise보다 더 센 소리
    BrownNoise.ar(mul: 0.5); // pink보다 무게중심이 낮음
)

(
    var white_noise = {
        WhiteNoise.ar(mul: 0.5);
    };
    var b = BPF.ar(white_noise, 440.0, rq: XLine.kr(start: 10, end: 0.1, dur: 5));
    LPF.ar(white_noise, freq: 440.0); // low pass filter -> 2번 걸면 더 날카롭게 떨어짐. cutoff freq. -3db 떨어진 곳.
    // freq = cutoff freq.
    HPF.ar(white_noise, 440.0); // high pass filter
    BPF.ar(white_noise, 440.0, rq: 0.1); // band pass filter, rq = 통과되는 소리
    BRF.ar(white_noise, 440.0); // band reject filter. also called band stop filter
    // bandwidth
    // Q(quality factor) freq / bandwidth
    // RQ(reciprocal quality factor) = 1 / Q = bandwidth / freq

    {b}.play();
)

(
    var white_noise = {
        WhiteNoise.ar(mul: 0.5);
    };
    var b = {
        BPF.ar(white_noise, 440.0, rq: XLine.kr(start: 10, end: 0.1, dur: 5));
    };
    b.play();
)


// 과제 1: 화이트노이즈에 대역필터를 건 뒤, 통과대역 및 대역폭을 MouseX, MouseY로 제어해 볼 것
(
    var white_noise = {
        WhiteNoise.ar(mul: 0.5);
    };
    var b = {
        BPF.ar(white_noise, MouseX.kr(min: 100, max: 1000, warp: 1), rq: MouseY.kr(min: 0.1, max: 10, warp: 1));
    };
    b.play();
)


(
    var white_noise = {
        WhiteNoise.ar(mul: 0.5);
    };

    var mouse_x = {
        MouseX.kr(min: 100, max: 1000, warp: 1);
    };

    var mous
)

(
    var rand = Array.rand(10, 1000, 1100);
    var rand2 = Array.rand(10, 0.1, 0.3);
    var splay = {
        Splay.ar(
            SinOsc.ar(freq: a, mul: b),
        );
    };

    splay.play();
)

(
    Dust.ar(1); // 1초에 랜덤하게 나오는 소리
    Resonz.ar()
)

(
    do (8) {
        arg x;
        var freq = 440 * (x + 1);
        {
            SinOsc.ar(freq: freq, mul: 0.2 /  (x + 1));
        }.play();
    }
)

// cmd-m-t -> node tree
// SynthDef(\name, { |args| ... }).add;
    // "test" == \test

(
    SynthDef.new(name: "test", ugenGraphFunc: {
        arg freq = 440,
        amp = 0.2;

        var out = 0;
        Out.ar(out, SinOsc.ar(freq: freq, mul: amp));
    }).add(); // -> add to the server.
)

// calling defined synth
Synth(defName: "test", args: [freq: 520, amp: 0.2]);

// Synth set
// arg = 자리에는 상수만 가능
(
    var alias = Synth(defName: "test", args: [freq: 520, amp: 0.2]);
    alias.set(\freq, 440);
    alias.set([freq: 440, amp: 0.5]);
    alias.free();
)

// identical to Synth(defName: "test", args: [\freq, 520, \amp, 0.2]);

(
    Out.ar(0, SinOsc.ar(freq: 440, mul: 0.2)); // == write signal to a bus
)

// 과제 2: 버퍼에 사운드 파일 로딩해서 재생하기

(
    var buf = Buffer.read(s, "/Users/rpopic2/1.wav");
    // rate를 Line.kr(128, 256, 20) 하면 꿀잼임
    // Line은 한번만 실행됨. SinOsc는 계속 실행됨
    PlayBuf.ar(numChannels: 2, bufnum: buf.bufnum, rate: 1, loop: 1);
)
// buffer::numFrames = sampleRate * buf.duration

// 피아노 옥타브(속도)만 바꿔도 꽤 흥미로운 소리

