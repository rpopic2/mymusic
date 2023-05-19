// shows a prompt
b = Buffer.loadDialog;

b = Buffer.read(s, "/Users/rpopic2/18-pno01A0.wav");
b.play;

// prints info about the buffer
b.query;

b.duration;

// panp = pan point -1 is left, 1 is right
(
    SynthDef("test", {
        |bufnum = 1, speed = 1, rp = 0 panp = 0|
        // var trig = Trig.kr(Dust.kr(3), 1);
        var trig = 0;
        // rp = reading point
        var env = Env.new(levels: [0.01, 1.0, 0.01], times: [0.3, 0.3], curve: "exp");
        // env_gen not working!
        //var eng_gen = EnvGen.kr(env, doneAction: 2);
        var snd = PlayBuf.ar(2, bufnum: bufnum, rate: speed, trigger: trig, startPos: rp * 44100, loop: 1, doneAction: 2);
        var pan = Pan2.ar(snd, panp);
        // PanAz, Pan4, Pan2 -> 2 channels
        Out.ar(0, pan * env);
    }).add;
)

Synth("test", ["bufnum", 0, "speed", 0.3, "rp", 1, "panp", 0]);
// [\bufnum, 0] 도 가능


// Pbind -> pattern binding

(
    Pbind.new.play;
)

(
    Pbind(\dur, 0.1, \midinote, 80).play;
)

(
    // Pseq = sequence
    Pbind(\dur, 0.1, \freq, 440, Pseq(list: [60, 62, 64, 65], repeats: 2)).play;
)

(
    Pbind(\dur, Pseq([0.75, 0.5, 0.25, 0.125, 0.075], inf), \midinote, Pseq(list: [60, 62, 64, 65], repeats: 2)).play;
)

Pbind(
    \instrument, \test,
    \bufnum, 0,
    \dur, Pseq(1 / [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 18, 22], 1),
    \speed, Pseq(1 / [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 18, 22], 1)
).play;

// Pser -> p series
(
var a, b;
a = Pser([1, 2, 3], 5);    // return 5 items
b = a.asStream;
6.do({ b.next.postln; });
)

// Prand -> p random
(
var a, b;
a = Prand([1, 2, 3, 4, 5], 6);    // return 6 items
b = a.asStream;
7.do({ b.next.postln; });
)

(
Pbind(
    \instrument, \test,
    \bufnum, 0,
    \dur, Prand([1, 2, 3, 4], inf),
    \speed, Prand([1, 1.1, 1.05, 0.98], inf)
).play;
)

// Pxrand
(
var a = Pxrand.new(#[1, 2, 3], 10);
var b = a.asStream;
11.do({
    b.next.postln;
});
)

Pan2
// Pwhite -> random
(
Pbind(
    \instrument, \test,
    \bufnum, 0,
    \dur, Pwhite(0.1, 2, inf),
    \speed, Pwhite(4, 6, inf)

//    \dur, Pwhite(0.1, 0.2, inf),
//    \speed, Pwhite(0.11, 0.2, inf)
).play;
)


// Pshuf -> shuffle, shiffled list
(
var a, b;
a = Pshuf([1, 2, 3, 4, 5], 3);    // repeat 3 the shuffled list times
b = a.asStream;
16.do({ b.next.postln; });
)

(
Pbind(
    \dur, 0.08,
    \legato, 2.5,
    \freq, Pwhite(80, 90, inf).midicps
).play
)

(
Pbind(
    \degree, Pseq([0,2,4,7], inf),  // Major scale
    \dur, 0.125,
    \octave, 4
).play
)

// Pn -> repeatedly embed a pattern
(
Pbind(
    \scale, Pseq( [ Pn([0,2,3,5,7,8,10], 8), Pn([0,2,4,5,7,9,11], 8) ], inf),
    \degree, Pseq([0,2,4,7], inf),
    \dur, 0.125
).play
)

// 1 / [1, 2, 3, 4, 5, 6, 7, 8, 9] ->  점점 짧아짐
Pbind(\dur, Pn(Pseq[1 / [1, 2, 3, 4, 5, 6, 7, 8, 9], 1), 3)).play;
