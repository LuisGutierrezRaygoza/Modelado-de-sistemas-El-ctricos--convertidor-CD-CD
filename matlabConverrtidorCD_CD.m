clc;
clear all;
tinicial = 0;
tfinal = .01;
paso = .000001;
duracion = (tinicial:paso:tfinal);
inicial = [0,0];
[t,x] = ode45(@odefun,duracion, inicial);




figure(1)
plot(t,x(:,1));
hold on
plot(t,x(:,2));
hold off
grid on
title("Posición")
xlabel("Tiempo")
ylabel("Metros")
legend('X1','X2')



function dx= odefun(t,x)
trabajo =4;
frecuencia = 100000;
periodo = 1/frecuencia;
L = .002;
R = 10;
C = .00001;
Uin = 32;

pasoPWM = periodo/10;
time = 0:pasoPWM:.01;
k= 0;
PWM = zeros(length(time),1);
for i = 1:length(time)
    if(k < 4)
        PWM(i) = 1;
    end
    k= k + 1;
    if(k == 10)
        k = 0;
    end
end

PWMF = interp1(t, PWM);

dx = zeros(2,1);
dx(1) = (-1/L)*x(2) + (Uin/L)*PWMF;
dx(2) = (1/C)*x(1)+(-1/(R*C))*x(2);
end