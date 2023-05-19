# Bitmap

## Introduction

Bitmap are like string, except we can handle bit to bit (1) operations, and not byte to byte (8).
Bitmap can be updated with operation with the BITFIELD command

## Use case

Can handle big array of boolean.

- Site access log
- Privilege settings

## Questions

1. How can I see if a key stores a bitmap?
2. How can I set a bit at a given index inside a bitmap?
3. How can I invert all the bits of a given bitmap?
4. Can I invert only a range of bits of a given bitmap?
5. How can I get the bit value at a given index inside a bitmap?
6. How can I set and retrieve back a bitmap representing an 32bit unsigned integer with 1000?
