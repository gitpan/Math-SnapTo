use Test;
BEGIN { plan tests => 209 };
use Math::SnapTo qw( snap_basic snap_sigfig snap_units );
ok(1);

### Snap Basic

ok( snap_basic(99.99,4), 100 );
ok( snap_basic(199.99,4), 200 );
ok( snap_basic(199.991,4), 200 );
ok( snap_basic(9999,4), 10000 );
ok( snap_basic(19999,4), 20000 );
ok( snap_basic(199990,4), 200000 );
ok( snap_basic(0.9999,4), 1 );
ok( snap_basic(0.09999,4), 0.1 );
ok( snap_basic(0.19999,4), 0.2 );
ok( snap_basic(0.199995,4), 0.2 );
ok( snap_basic(100.001,4), 100 );
ok( snap_basic(10000.1,4), 10000 );
ok( snap_basic(100001,4), 100000 );
ok( snap_basic(1.00001,4), 1 );
ok( snap_basic(9.99,4), 9.99 );
ok( snap_basic(19.99,4), 19.99 );
ok( snap_basic(19.991,4), 19.991 );
ok( snap_basic(999,4), 999 );
ok( snap_basic(1999,4), 1999 );
ok( snap_basic(19990,4), 19990 );
ok( snap_basic(0.999,4), 0.999 );
ok( snap_basic(0.0999,4), 0.0999 );
ok( snap_basic(0.1999,4), 0.1999 );
ok( snap_basic(0.19995,4), 0.19995 );
ok( snap_basic(10.001,4), 10.001 );
ok( snap_basic(1000.1,4), 1000.1 );
ok( snap_basic(10001,4), 10001 );
ok( snap_basic(1.0001,4), 1.0001 );


### Snap Sig Figs

ok( snap_sigfig(9,4), 9 );
ok( snap_sigfig(99,4), 99 );
ok( snap_sigfig(999,4), 999 );
ok( snap_sigfig(9999,4), 9999 );
ok( snap_sigfig(99999,4), 100000 );
ok( snap_sigfig(999999,4), 1000000 );
ok( snap_sigfig(9999999,4), 10000000 );
ok( snap_sigfig(1,4), 1 );
ok( snap_sigfig(11,4), 11 );
ok( snap_sigfig(111,4), 111 );
ok( snap_sigfig(1111,4), 1111 );
ok( snap_sigfig(11111,4), 11110 );
ok( snap_sigfig(111111,4), 111100 );
ok( snap_sigfig(1111111,4), 1111000 );
ok( snap_sigfig(5,4), 5 );
ok( snap_sigfig(55,4), 55 );
ok( snap_sigfig(555,4), 555 );
ok( snap_sigfig(5555,4), 5555 );
ok( snap_sigfig(55555,4), 55560 );
ok( snap_sigfig(555555,4), 555600 );
ok( snap_sigfig(5555555,4), 5556000 );
ok( snap_sigfig(0.9,4), 0.9 );
ok( snap_sigfig(0.99,4), 0.99 );
ok( snap_sigfig(0.999,4), 0.999 );
ok( snap_sigfig(0.9999,4), 0.9999 );
ok( snap_sigfig(0.99999,4), 1 );
ok( snap_sigfig(0.999999,4), 1 );
ok( snap_sigfig(0.1,4), 0.1 );
ok( snap_sigfig(0.11,4), 0.11 );
ok( snap_sigfig(0.111,4), 0.111 );
ok( snap_sigfig(0.1111,4), 0.1111 );
ok( snap_sigfig(0.11111,4), 0.1111 );
ok( snap_sigfig(0.111111,4), 0.1111 );
ok( snap_sigfig(0.5,4), 0.5 );
ok( snap_sigfig(0.55,4), 0.55 );
ok( snap_sigfig(0.555,4), 0.555 );
ok( snap_sigfig(0.5555,4), 0.5555 );
ok( snap_sigfig(0.55555,4), 0.5556 );
ok( snap_sigfig(0.555555,4), 0.5556 );


### Snap Units 4

ok( snap_units(1,4), 0 );
ok( snap_units(2,4), 4 );
ok( snap_units(3,4), 4 );
ok( snap_units(4,4), 4 );
ok( snap_units(5,4), 4 );
ok( snap_units(6,4), 8 );
ok( snap_units(7,4), 8 );
ok( snap_units(8,4), 8 );
ok( snap_units(9,4), 8 );
ok( snap_units(10,4), 12 );
ok( snap_units(11,4), 12 );
ok( snap_units(12,4), 12 );
ok( snap_units(13,4), 12 );
ok( snap_units(14,4), 16 );
ok( snap_units(15,4), 16 );
ok( snap_units(16,4), 16 );
ok( snap_units(17,4), 16 );
ok( snap_units(18,4), 20 );
ok( snap_units(19,4), 20 );
ok( snap_units(20,4), 20 );


### Snap Units 5

ok( snap_units(1,5), 0 );
ok( snap_units(2,5), 0 );
ok( snap_units(3,5), 5 );
ok( snap_units(4,5), 5 );
ok( snap_units(5,5), 5 );
ok( snap_units(6,5), 5 );
ok( snap_units(7,5), 5 );
ok( snap_units(8,5), 10 );
ok( snap_units(9,5), 10 );
ok( snap_units(10,5), 10 );
ok( snap_units(11,5), 10 );
ok( snap_units(12,5), 10 );
ok( snap_units(13,5), 15 );
ok( snap_units(14,5), 15 );
ok( snap_units(15,5), 15 );
ok( snap_units(16,5), 15 );
ok( snap_units(17,5), 15 );
ok( snap_units(18,5), 20 );
ok( snap_units(19,5), 20 );
ok( snap_units(20,5), 20 );


### Snap Units 0.25

ok( snap_units(2,0.25), 2 );
ok( snap_units(1.9,0.25), 2 );
ok( snap_units(1.8,0.25), 1.75 );
ok( snap_units(1.7,0.25), 1.75 );
ok( snap_units(1.6,0.25), 1.5 );
ok( snap_units(1.5,0.25), 1.5 );
ok( snap_units(1.4,0.25), 1.5 );
ok( snap_units(1.3,0.25), 1.25 );
ok( snap_units(1.2,0.25), 1.25 );
ok( snap_units(1.1,0.25), 1 );
ok( snap_units(1,0.25), 1 );
ok( snap_units(0.9,0.25), 1 );
ok( snap_units(0.8,0.25), 0.75 );
ok( snap_units(0.7,0.25), 0.75 );
ok( snap_units(0.6,0.25), 0.5 );
ok( snap_units(0.5,0.25), 0.5 );
ok( snap_units(0.4,0.25), 0.5 );
ok( snap_units(0.3,0.25), 0.25 );
ok( snap_units(0.2,0.25), 0.25 );
ok( snap_units(0.1,0.25), 0 );


### Snap Units 0.1

ok( snap_units(2,0.1), 2 );
ok( snap_units(1.975,0.1), 2 );
ok( snap_units(1.95,0.1), 2 );
ok( snap_units(1.925,0.1), 1.9 );
ok( snap_units(1.9,0.1), 1.9 );
ok( snap_units(1.875,0.1), 1.9 );
ok( snap_units(1.85,0.1), 1.9 );
ok( snap_units(1.825,0.1), 1.8 );
ok( snap_units(1.8,0.1), 1.8 );
ok( snap_units(1.775,0.1), 1.8 );
ok( snap_units(1.75,0.1), 1.8 );
ok( snap_units(1.725,0.1), 1.7 );
ok( snap_units(1.7,0.1), 1.7 );
ok( snap_units(1.675,0.1), 1.7 );
ok( snap_units(1.65,0.1), 1.7 );
ok( snap_units(1.625,0.1), 1.6 );
ok( snap_units(1.6,0.1), 1.6 );
ok( snap_units(1.575,0.1), 1.6 );
ok( snap_units(1.55,0.1), 1.6 );
ok( snap_units(1.525,0.1), 1.5 );
ok( snap_units(1.5,0.1), 1.5 );
ok( snap_units(1.475,0.1), 1.5 );
ok( snap_units(1.45,0.1), 1.5 );
ok( snap_units(1.425,0.1), 1.4 );
ok( snap_units(1.4,0.1), 1.4 );
ok( snap_units(1.375,0.1), 1.4 );
ok( snap_units(1.35,0.1), 1.4 );
ok( snap_units(1.325,0.1), 1.3 );
ok( snap_units(1.3,0.1), 1.3 );
ok( snap_units(1.275,0.1), 1.3 );
ok( snap_units(1.25,0.1), 1.3 );
ok( snap_units(1.225,0.1), 1.2 );
ok( snap_units(1.2,0.1), 1.2 );
ok( snap_units(1.175,0.1), 1.2 );
ok( snap_units(1.15,0.1), 1.2 );
ok( snap_units(1.125,0.1), 1.1 );
ok( snap_units(1.1,0.1), 1.1 );
ok( snap_units(1.075,0.1), 1.1 );
ok( snap_units(1.05,0.1), 1.1 );
ok( snap_units(1.025,0.1), 1 );
ok( snap_units(1,0.1), 1 );
ok( snap_units(0.975,0.1), 1 );
ok( snap_units(0.95,0.1), 1 );
ok( snap_units(0.925,0.1), 0.9 );
ok( snap_units(0.9,0.1), 0.9 );
ok( snap_units(0.875,0.1), 0.9 );
ok( snap_units(0.85,0.1), 0.9 );
ok( snap_units(0.825,0.1), 0.8 );
ok( snap_units(0.8,0.1), 0.8 );
ok( snap_units(0.775,0.1), 0.8 );
ok( snap_units(0.75,0.1), 0.8 );
ok( snap_units(0.725,0.1), 0.7 );
ok( snap_units(0.7,0.1), 0.7 );
ok( snap_units(0.675,0.1), 0.7 );
ok( snap_units(0.65,0.1), 0.7 );
ok( snap_units(0.625,0.1), 0.6 );
ok( snap_units(0.6,0.1), 0.6 );
ok( snap_units(0.575,0.1), 0.6 );
ok( snap_units(0.55,0.1), 0.6 );
ok( snap_units(0.525,0.1), 0.5 );
ok( snap_units(0.5,0.1), 0.5 );
ok( snap_units(0.475,0.1), 0.5 );
ok( snap_units(0.45,0.1), 0.5 );
ok( snap_units(0.425,0.1), 0.4 );
ok( snap_units(0.4,0.1), 0.4 );
ok( snap_units(0.375,0.1), 0.4 );
ok( snap_units(0.35,0.1), 0.4 );
ok( snap_units(0.325,0.1), 0.3 );
ok( snap_units(0.3,0.1), 0.3 );
ok( snap_units(0.275,0.1), 0.3 );
ok( snap_units(0.25,0.1), 0.3 );
ok( snap_units(0.225,0.1), 0.2 );
ok( snap_units(0.2,0.1), 0.2 );
ok( snap_units(0.175,0.1), 0.2 );
ok( snap_units(0.15,0.1), 0.2 );
ok( snap_units(0.125,0.1), 0.1 );
ok( snap_units(0.1,0.1), 0.1 );
ok( snap_units(0.075,0.1), 0.1 );
ok( snap_units(0.05,0.1), 0.1 );
ok( snap_units(0.025,0.1), 0 );
ok( snap_units(0,0.1), 0 );


