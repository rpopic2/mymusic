s.options.memSize = 2 ** 20;

(
~mysynth = {
    SinOsc.ar(440)
};
)

~mysynth.play();

// Basic 440Hz sine wave
{SinOsc.ar(440)}.play();

// Either two of these will send 440Hz to both channels
{SinOsc.ar([440, 440])}.play();
{SinOsc.ar(440)!2}.play();
// if array length is greater than channels available, it will not be audible
Splay.ar({SinOsc.ar([440, 440, 440])});
// Using Splay.ar will send the signal to all channels

// Array. 440Hz is sent to the left, 330 is sent to the right
{SinOsc.ar([440, 330])}.play();


// Plots a single cycle
{SinOsc.ar(440)}.plot(1/440);

// Alternating phases
{SinOsc.ar(440)}.plot(1/440);
{SinOsc.ar(440, pi)}.plot(1/440);
{SinOsc.ar(440, pi * 0.5)}.plot(1/440); // -> cosin wave

midicps(60); // -> middle C
midicps(69); // -> 440Hz

SinOsc.ar(midicps(60)); // -> middle C

scramble("hello world"); // -> "hleolwrdlo"

plot(scramble([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]));


reciprocal(3); // -> 1/3

rand(3); // 0~2

rrand(3, 5); // 3~5

Array.series(size: 10, start: 3, step: 1); // -> [3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

(3..12)
(3..12).asArray; // -> [3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

Array.rand(size: 10, min: 3, max: 5); // -> [3, 4, 5, 3, 4, 5, 3, 4, 5, 3]

Array.geom(10, 1, 2); // -> [1, 2, 4, 8, 16, 32, 64, 128, 256, 512]

midicps(60); // -> 261.6
midicps(60).round(0.1); // -> 261.6

midicps(60) * (1..9).asArray; // -> overtones from middle c

({
    Splay.ar(
        SinOsc.ar(
            Array.series(28, 333, 28)
            , 0, 0.1
        )
    )
}).play();
