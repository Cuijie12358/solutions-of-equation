          function fx = Fn(Numcoa,x)
            fx=0;
            Xsize=size(Numcoa);
            for i=1:1:Xsize(2)
                fx = fx + Numcoa(i)* power(x,Xsize(2)-i);
            end
        end