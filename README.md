# FING
 Funny Internal Network Generator

## Questions

* What number must be included? (integer)

## Results

| Range                         | CIDR block     |
| ----------------------------- | -------------- |
| 10.0.0.0 – 10.255.255.255     | 10.0.0.0/8     |
| 172.16.0.0 – 172.31.255.255   | 172.16.0.0/12  |
| 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 |

## How will it work?
* The user enters a number they want in the IP range
* Program will find a /24 block where that number appears in every IP address.

### How should the program find this
* Text file of all possible /24 blocks
* Find string in each row (ignore `.`)
* Print all possible results


## Example

* User says they want the number `123` in their block.
* System will return the following options:

```
10.123.0.0/24
10.0.123.0/24
10.1.23.0/24
10.12.3.0/24
172.16.123.0/24
172.21.23.0/24
172.31.23.0/24
192.168.123.0/24
```

