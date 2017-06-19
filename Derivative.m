       function Numcoad = Derivative(Numcoa)
            Xsize = size(Numcoa);     
            for i=1:1:Xsize(2)-1
                Numcoad(i) = Numcoa(i)*(Xsize(2)-i);
            end
        end