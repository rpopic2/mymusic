// Starts recording
(
    // You can drag a folder into the IDE.
    s.prepareForRecord("/Users/rpopic2/Music/SuperCollider Recordings/file.wav");
    s.record();
)

// Play a sound, and it will be recorded to the file
(
    var synth = {
        SinOsc.ar(440.0);
    };
    synth.play();
)

// looking at freqscope of a whitenoise
// freqscope의 주파수 눈금이 다른 이유는 옥타브마다 2배가 뛰기 때문에.
(
    var whitenoise = {
        var sig = WhiteNoise.ar;
        sig = LPF.ar(sig, 1000);
        sig = HPF.ar(sig, 100);
        sig;
    };
    var pinknoise = {
        PinkNoise.ar();
    };
    // 이 saw파는 깔끔한 모양이 아님! LFSaw의 경우에는 깔끔한 모양을 가짐.
    // dbamp은 10db의 gain을 준다는 의미.
    var saw = {
        Saw.ar(freq: 440.0, 10.dbamp);
    };
    saw.plot();
)

// 이 부분 중요! 사인파 중첩해서 만들 수 있음!
(
    var sine_control = {
        // 어떤 값이 나올지 생각해보기
        // freq, mul, add를 바꿔가며 실험해보자
        SinOsc.kr(freq: 10.0, mul: 10, add: 1000);
        // -10 ~ 10 상태에서 -> 90 ~ 110
        // mul: 100, add: 100 했을 때 0~200헤르츠의 소리가 남. 중간에 소리가 안나오게 되는데, 가청 주파수를 넘어서 그럼.
    };

    var sine2 = {
        SinOsc.ar(sine_control);
    };

    sine2.play();
)

// 마우스 가지고 놀기
(
    var mouse_control = {
        // 마우스는 kr만 있음.
        MouseX.kr(minval: -300, maxval: 5000);
    };

    var mouse_y = {
        MouseY.kr(minval: 0, maxval: 1);
    };

    var sine = {
        SinOsc.ar(440 + mouse_control, 0, mouse_y);
    };

    sine.play();
)

(
    // line
    var line = {
        //doneAction: 2 -> finish
        Line.kr(start: 0.0, end: 1.0, dur: 3.0, doneAction: 2);
    };

    // exponential line
    var xline = {
        XLine.kr(start: 0.001, end: 1.0, dur: 3.0);
    };

    line.plot();
)

// kr vs ar
// 샘플링을 가청주파수 * 2로 해야한다는 이론이 있어서
// 이어진 아날로그 신호 -> 각진 디지털 신호로 변환
// 샘플링 레이트 낮추면, 높은 주파수부터 날라감. 높은 주파수는 더 촘촘하기 때문에.
// 비트 레이트: 16일 때는 16개의 레벨로 표현됨. 2^16 = 65536개 하나가 i16으로 저장되는 것임.
// PCM code

// AD, DA (Analogue to Digital) Converting
// input -> LF filter (20 아래는 필요없으니까) -> quantising -> a/d converter -> digital signal
// digital signal -> d/a converter -> low pass filter(이걸 지나면 보간되어서 아날로그화 된다고 함) -> output

// kr: sample rate / 64
// -> kr is more efficient in performance.

// # LFSaw, LFPulse, LFTri
// non-bandlimited UGen

(
    var lf_saw = {
        LFSaw.ar(1.0);
    };

    var saw = {
        Saw.ar(1.0);
    };

    //plot(saw, 1);
    plot(lf_saw, 1);

)

// LFO -> Low Frequency Oscillator
// 낮은 주파수로 다른 요소 조종
(
    var lfsaw = {
        LFSaw.ar(1, mul: 0.5, add: 0.5);
    };

    var sine = {
        SinOsc.ar(100, 0, lfsaw);
    };

    var sine_reverse = {
        SinOsc.ar(100, 0, 1 - lfsaw);
    };
)

// 1 -> 0 -> 1로 움직임, 0.1,  0.2는 각 점 사이의 시간
(
    var env = Env.new(levels: [1, 0, 1], times: [0.1, 0.2], curve: [1, -1]);

    var envgen = {
        EnvGen.kr(env);
    };

    var sine = {
        SinOsc.ar(440, 0, envgen); // * envgen으로 곱할 수도 있음
    };

    envgen.plot();
)

(
    //Env.new([1, 0, 1], [1.0, 0.5]).plot();
    Mix.ar(SinOsc.ar(Array.rand(5, 100, 1000), mul: 0.2));

    Env.new(levels: [0, 1, 0], times: [1, 1], curve: 3).plot();

    // 아치형 모양
    Env.new(levels: [0, 1, 0], times: [1, 1], curve: [-3, 3]).plot();

    Env.new(levels: [0, 1, 0], times: [1, 1], curve: \sin).plot();

    Env.new(levels: [0, 1, 0], times: [1, 1], curve: \step).plot();
)

(
    Env.linen(attackTime: 0.03, sustainTime: 0.5, releaseTime: 0.1).plot();
    Env.adsr(attackTime: 0.01, decayTime: 0.5, sustainLevel: 0.5, releaseTime: 0.1).plot();
    Env.perc(attackTime: 0.05, releaseTime: 0.5, level: 1.0, curve: 0).plot();
)


(
    var env = {
        Env.new([1000, 20], 1.0)
    };

    var env_gen = {
        EnvGen.ar(env);
    };

    var sin0 = {
        SinOsc.ar(env_gen, 0, 0.1);
    };

    var sin1 = {
        SinOsc.ar(440.0, 0, sin0);
    };

    sin1.play();
)

