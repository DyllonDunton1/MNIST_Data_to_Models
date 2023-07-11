%%**********************************
%% filename: three.m
%% Department of Electronics
%% Carleton University
%%********************************

function [output] = three(input)

%input scaling
x(1)=-1.0+(2.0)*(input(1)-(0.0191327)) / ((0.397959) - (0.0191327));
x(2)=-1.0+(2.0)*(input(2)-(20.6435)) / ((88.4416) - (20.6435));
x(3)=-1.0+(2.0)*(input(3)-(20.6435)) / ((88.4416) - (20.6435));

%calculating hidden neurons
z(1) = 1.0 / ( 1.0 + exp(-1.0 * (-8.93556+x(1)*(-9.70083)+x(2)*(4.52924)+x(3)*(5.00057))));
z(2) = 1.0 / ( 1.0 + exp(-1.0 * (-12.3715+x(1)*(-13.6392)+x(2)*(-0.700323)+x(3)*(-0.0271445))));
z(3) = 1.0 / ( 1.0 + exp(-1.0 * (-36.551+x(1)*(-60.0534)+x(2)*(16.7609)+x(3)*(15.8513))));
z(4) = 1.0 / ( 1.0 + exp(-1.0 * (-4.03639+x(1)*(-1.65585)+x(2)*(1.8983)+x(3)*(1.60091))));
z(5) = 1.0 / ( 1.0 + exp(-1.0 * (-3.98763+x(1)*(-1.12822)+x(2)*(-1.31549)+x(3)*(-0.530527))));
z(6) = 1.0 / ( 1.0 + exp(-1.0 * (-12.2192+x(1)*(-14.0429)+x(2)*(11.1046)+x(3)*(11.0355))));
z(7) = 1.0 / ( 1.0 + exp(-1.0 * (-1.27128+x(1)*(1.89364)+x(2)*(-0.885702)+x(3)*(-1.17859))));
z(8) = 1.0 / ( 1.0 + exp(-1.0 * (-5.79715+x(1)*(0.78011)+x(2)*(-2.8894)+x(3)*(-2.71751))));
z(9) = 1.0 / ( 1.0 + exp(-1.0 * (1.92155+x(1)*(11.109)+x(2)*(-3.63473)+x(3)*(-3.73753))));
z(10) = 1.0 / ( 1.0 + exp(-1.0 * (-20.3858+x(1)*(-27.1834)+x(2)*(13.9926)+x(3)*(13.5713))));
z(11) = 1.0 / ( 1.0 + exp(-1.0 * (0.979586+x(1)*(11.3228)+x(2)*(-2.94754)+x(3)*(-2.67375))));
z(12) = 1.0 / ( 1.0 + exp(-1.0 * (-6.76611+x(1)*(-8.03071)+x(2)*(1.14983)+x(3)*(1.43112))));

%calculating output neurons
y(1) = 0.0314564+z(1)*(1.10078)+z(2)*(0.102051)+z(3)*(-0.0298655)+z(4)*(-1.45616)+z(5)*(-1.6238)+z(6)*(0.754229)+z(7)*(0.609319)+z(8)*(-0.587389)+z(9)*(0.277635)+z(10)*(-1.11471)+z(11)*(0.30238)+z(12)*(0.206768);
y(2) = 0.108994+z(1)*(0.190057)+z(2)*(1.46343)+z(3)*(1.19128)+z(4)*(-0.9214)+z(5)*(1.84336)+z(6)*(-0.0302005)+z(7)*(-0.256352)+z(8)*(-2.87479)+z(9)*(-0.448532)+z(10)*(0.897551)+z(11)*(0.440214)+z(12)*(-2.0002);
y(3) = -0.0123193+z(1)*(-2.81882)+z(2)*(0.289017)+z(3)*(0.040987)+z(4)*(1.93772)+z(5)*(-3.64893)+z(6)*(-0.264562)+z(7)*(1.74735)+z(8)*(-0.140873)+z(9)*(1.56229)+z(10)*(0.790372)+z(11)*(-1.75363)+z(12)*(0.0482975);
y(4) = 0.0381231+z(1)*(-0.490239)+z(2)*(0.0353673)+z(3)*(-0.112778)+z(4)*(2.61192)+z(5)*(-0.0772969)+z(6)*(-0.287137)+z(7)*(-0.243941)+z(8)*(0.0882593)+z(9)*(0.0802808)+z(10)*(0.0301021)+z(11)*(-0.253476)+z(12)*(0.0969967);
y(5) = 0.436563+z(1)*(-2.34773)+z(2)*(-0.449974)+z(3)*(-0.187874)+z(4)*(-2.22505)+z(5)*(-0.14491)+z(6)*(0.0251928)+z(7)*(-1.51957)+z(8)*(1.20457)+z(9)*(-0.442961)+z(10)*(0.611542)+z(11)*(0.370506)+z(12)*(0.366492);
y(6) = -0.0697806+z(1)*(0.81599)+z(2)*(-0.144499)+z(3)*(0.265082)+z(4)*(-1.81196)+z(5)*(3.6579)+z(6)*(0.0402537)+z(7)*(3.64419)+z(8)*(-1.18465)+z(9)*(-1.7808)+z(10)*(-0.109735)+z(11)*(1.40802)+z(12)*(-2.90397);
y(7) = 0.203284+z(1)*(-1.57916)+z(2)*(-0.0719689)+z(3)*(-0.159091)+z(4)*(2.37057)+z(5)*(0.00365304)+z(6)*(-0.410372)+z(7)*(-1.70883)+z(8)*(1.41936)+z(9)*(0.288199)+z(10)*(0.461895)+z(11)*(-0.337133)+z(12)*(0.301109);
y(8) = 0.279713+z(1)*(-1.04831)+z(2)*(-0.830933)+z(3)*(-0.311235)+z(4)*(-1.18347)+z(5)*(1.24245)+z(6)*(-0.00507637)+z(7)*(-1.63958)+z(8)*(1.08382)+z(9)*(-0.0693899)+z(10)*(0.275651)+z(11)*(0.124826)+z(12)*(1.27554);
y(9) = -0.077336+z(1)*(5.28224)+z(2)*(0.148246)+z(3)*(-0.243705)+z(4)*(-0.995068)+z(5)*(-0.606298)+z(6)*(0.456903)+z(7)*(0.630105)+z(8)*(-0.695538)+z(9)*(0.100485)+z(10)*(-1.60785)+z(11)*(0.0908868)+z(12)*(0.46056);
y(10) = 0.101423+z(1)*(0.830345)+z(2)*(-0.565417)+z(3)*(-0.443909)+z(4)*(1.76553)+z(5)*(0.412262)+z(6)*(-0.293348)+z(7)*(-1.92986)+z(8)*(1.27458)+z(9)*(0.57853)+z(10)*(-0.218432)+z(11)*(-0.476981)+z(12)*(1.94328);

%output scaling
output(1) = 0.0+(y(1)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(2) = 0.0+(y(2)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(3) = 0.0+(y(3)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(4) = 0.0+(y(4)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(5) = 0.0+(y(5)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(6) = 0.0+(y(6)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(7) = 0.0+(y(7)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(8) = 0.0+(y(8)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(9) = 0.0+(y(9)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));
output(10) = 0.0+(y(10)-(0.0))*((1.0) - (0.0))/((1.0)-(0.0));