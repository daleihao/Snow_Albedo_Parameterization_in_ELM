function snowflake(N,x0,y0,d)
hold on
set(gca,'DataAspectRatio',[1 1 1]);
x1=-d/2;y1=-1/6*3^(1/2)*d;
x2=d/2;y2=y1;
xc=x1;yc=y1-.2;
[x3,y3]=third_point(x1,y1,x2,y2,xc,yc);
snf(N,x1,y1,x2,y2,x3,y3);
snf(N,x1,y1,x3,y3,x2,y2);
snf(N,x2,y2,x3,y3,x1,y1);
hold off
    function snf(n,x1,y1,x2,y2,x3,y3)
        if n==1
            plot([x1 x2],[y1 y2]);
            return ;
        end
        
        a1=(2*x1+x2)/3;b1=(2*y1+y2)/3;
        a2=(x1+2*x2)/3;b2=(y1+2*y2)/3;
        [a3,b3]=third_point(a1,b1,a2,b2,x3,y3);
        snf(n-1,a1,b1,a3,b3,a2,b2);
        snf(n-1,a2,b2,a3,b3,a1,b1);
        
        snf(n-1,x1,y1,a1,b1,x3,y3);
        snf(n-1,a2,b2,x2,y2,x3,y3);
    end
    function [x3,y3]=third_point(x1,y1,x2,y2,xc,yc)
        x0=(x1+x2)/2;
        y0=(y1+y2)/2;
        d=sqrt((x1-x2)^2+(y1-y2)^2);
        [x,y]=solve('(x-x0)^2+(y-y0)^2=3*d^2/4','y=y0-(x1-x2)/(y1-y2)*(x-x0)','x','y');
        x=eval(x);
        y=eval(y);
        
        l1=(xc-x(1))^2+(yc-y(1))^2;
        l2=(xc-x(2))^2+(yc-y(2))^2;
        if l1>l2
            x3=x(1);y3=y(1);
        else
            x3=x(2);y3=y(2);
        end
    end
end
